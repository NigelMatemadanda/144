# import the packages that are needed
from control.centroidtracker import CentroidTracker
from control.trackableobject import TrackableObject
from imutils.video import VideoStream
from imutils.video import FPS
import numpy as np
import argparse
import imutils
import time
import dlib
import cv2

# construct the argument parse and parse the arguments
# These command line arguments allows us to pass information to our script from the terminal during runtime
ap = argparse.ArgumentParser()
# path to the caffe deploy prototxt file
ap.add_argument("-p", "--prototxt", required=True,
                help="path to Caffe 'deploy' prototxt file")
# path to the pre trained CNN model
ap.add_argument("-m", "--model", required=True,
                help="path to Caffe pre-trained model")
# optional input, if null the webcam wil be used
ap.add_argument("-i", "--input", type=str,
                help="path to optional input video file")
# optional output, if null the video captured will not be recorded

ap.add_argument("-o", "--output", type=str,
                help="path to optional output video file")
# with 0.4 value this is the minimum probability threshold which helps to filter out weak detections
ap.add_argument("-c", "--confidence", type=float, default=0.4,
                help="minimum probability to filter weak detections")
# the number of frames that are skipped before running the DNN detector again on a tracked object
ap.add_argument("-s", "--skip-frames", type=int, default=30,
                help="# of skip frames between detections")
args = vars(ap.parse_args())

# initialising the class labels that the MobileNet SSD was trained to detect
CLASSES = ["background", "aeroplane", "bicycle", "bird", "boat",
           "bottle", "bus", "car", "cat", "chair", "cow", "diningtable",
           "dog", "horse", "motorbike", "person", "pottedplant", "sheep",
           "sofa", "train", "tvmonitor"]

# load the serialised model from the disk
print("[INFO] We are loading the model...")
net = cv2.dnn.readNetFromCaffe(args["prototxt"], args["model"])

# if video path was not specified, use the webcam reference
if not args.get("input", False):
    print("[INFO] We are starting the webcam video...")
    # usual the webcam is source 0 unless you are using more than one on your computer, change if needed
    vs = VideoStream(src=0).start()
    time.sleep(2.0)

    # else, grab a reference to the video file
else:
    print("[INFO] We are opening the video file...")
    vs = cv2.VideoCapture(args["input"])

# initialise the video writer and will instantiate it later if needed
writer = None

# initialise the frame dimensions and set them after the first frame has been read from the video
# put the values in cv2.VideoWriter
W = None
H = None

# initialise the centroid tracker, initialise a list to store the dlib correlation trackers, followed by a dictionary
# to map each unique object ID to a Trackable Object
ct = CentroidTracker(maxDisappeared=40, maxDistance=50)
trackers = []
trackableObjects = {}

# initialise the number of frames processed and the number of objects that moved up or down to 0
totalFrames = 0
totalDown = 0
totalUp = 0

# start the frames per second throughput estimator
fps = FPS().start()

# loop over the frames from the webcam
while True:
    # take the next frame and distinguish if we are reading from Video Capture or Video Stream
    frame = vs.read()
    frame = frame[1] if args.get("input", False) else frame

    # if we are viewing a video and did not grab a frame that is the end of the video
    if args["input"] is not None and frame is None:
        break

    # resize the frame to have max width of 500 pixels, this is to increase processing speed
    # convert the frame RGB from BGR for dlib
    # by default the video is in BGR format
    frame = imutils.resize(frame, width=500)
    rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)

    # set the frame dimensions if they are empty
    if W is None or H is None:
        (H, W) = frame.shape[:2]

    # if the video is being written to the disk, initialise the writer
    if args["output"] is not None and writer is None:
        fourcc = cv2.VideoWriter_fourcc(*"MJPG")
        writer = cv2.VideoWriter(args["output"], fourcc, 30,
                                 (W, H), True)

    # initialise the status with our list of bounding box that are retained by either the object detector
    # or the correlation trackers
    # status waiting means waiting for people to be detected
    status = "Waiting"
    rectangles = []

    # check if there is need to run a more computational taxing object detection method to help our tracker
    if totalFrames % args["skip_frames"] == 0:
        # set the status and initialise new object trackers
        # status detecting means we are actively detecting people using mobile net ssd
        status = "Detecting"
        trackers = []

        # convert the frame to a blob and pass the blob through the network and obtain the detections
        blob = cv2.dnn.blobFromImage(frame, 0.007843, (W, H), 127.5)
        net.setInput(blob)
        detections = net.forward()

        # loop over the detections
        for i in np.arange(0, detections.shape[2]):
            # get the probability associated with the prediction
            confidence = detections[0, 0, i, 2]

            # filter out the weaker detections by getting the minimum confidence
            if confidence > args["confidence"]:
                # get the index of the class label from the detections list
                index = int(detections[0, 0, i, 1])

                # if the class label is not person, ignore it
                if CLASSES[index] != "person":
                    continue

                # compute the x, y coordinates of the bounding box for the object
                box = detections[0, 0, i, 3:7] * np.array([W, H, W, H])
                (startX, startY, endX, endY) = box.astype("int")

                # make a dlib rectangle object from the bounding box coordinates and start the dlib correlation tracker
                tracker = dlib.correlation_tracker()
                rect = dlib.rectangle(startX, startY, endX, endY)
                tracker.start_track(rgb, rect)

                # add the tracker to the list of trackers so we can use it during skip frames
                trackers.append(tracker)

            # else, we should use the trackers rather than the detectors for high frame rates
    else:
        for tracker in trackers:
            # set the status to tracking
            status = "Tracking"

            # update the tracker and acquire the updated position
            tracker.update(rgb)
            pos = tracker.get_position()

            # the position of the object
            startX = int(pos.left())
            startY = int(pos.top())
            endX = int(pos.right())
            endY = int(pos.bottom())

            # add the coordinates of the bounding box to the rectangles list
            rectangles.append((startX, startY, endX, endY))

    # draw a horizontal line in the centre of the frame
    # checks the directions the moving objects are going either up or down
    cv2.line(frame, (0, H // 2), (W, H // 2), (0, 255, 255), 2)

    # use the centroid tracker to associate the old object centroids with the new ones
    objects = ct.update(rectangles)

    # loop over the tracker objects
    for (objectID, centroid) in objects.items():
        # check to see if a trackable object exists for the current object id
        to = trackableObjects.get(objectID, None)

        # if there is no trackable object, make one
        if to is None:
            to = TrackableObject(objectID, centroid)

        # else, there is a trackable object, determine its direction
        else:
            # the difference between current y coordinate centroid and the mean of the previous centroid
            # will determine the direction in which the object is moving in, negative for up positive for down
            y = [c[1] for c in to.centroids]
            direction = centroid[1] - np.mean(y)
            to.centroids.append(centroid)

            # check if object has been counted
            if not to.counted:
                # if the direction is negative and the centroid is above the center line, count the object
                if direction < 0 and centroid[1] < H // 2:
                    totalUp = totalUp + 1
                    to.counted = True

                #  if the direction is positive and the centroid is below the center line, count the object
                elif direction > 0 and centroid[1] < H // 2:
                    totalDown = totalDown + 1
                    to.counted = True

        # store the trackable object in the dictionary
        trackableObjects[objectID] = to

        # draw the ID and the centroid of the object in the frame
        text = "ID {}".format(objectID)
        cv2.putText(frame, text, (centroid[0] - 10, centroid[1] - 10), cv2.FONT_HERSHEY_COMPLEX, 0.5, (0, 255, 255, 0),
                    2)
        cv2.circle(frame, (centroid[0], centroid[1]), 4, (0, 255, 0), -1)

    #   a tuple of information that will be displayed in the frame
    frame_information = [
        ("Going Up", totalUp), ("Going Down", totalDown),
        ("Live Status", status)
    ]

    # loop over the tuple and draw on the frame
    for (i, (k, v)) in enumerate(frame_information):
        text = "{}: {}".format(k, v)
        cv2.putText(frame, text, (10, H - ((i * 20) + 20)), cv2.FONT_HERSHEY_DUPLEX, 0.6, (0, 255, 0), 2)

    # check if the frame is being written to disk
    if writer is not None:
        writer.write(frame)

    # show the output frame
    cv2.imshow("PEOPLE COUNTER", frame)
    key = cv2.waitKey(1) & 0xFF

    # if 'q' is pressed exit the loop
    if key == ord("q"):
        break

    totalFrames = totalFrames + 1
    fps.update()

# stop the timer and display FPS information
fps.stop()
print("[INFO] elapsed time: {:.2f}".format(fps.elapsed()))
print("[INFO] approx. FPS: {:.2f}".format(fps.fps()))

# check to see if we need to release the video writer pointer
if writer is not None:
    writer.release()

# if we are not using a video file, stop the camera video stream
if not args.get("input", False):
    vs.stop()

# otherwise, release the video file pointer
else:
    vs.release()

# close any open windows
cv2.destroyAllWindows()