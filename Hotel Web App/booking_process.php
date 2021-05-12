<?php
session_start();
include "includes/connect.php";
$_SESSION['errorMessage'] = "";


// Store the data from the form
$_SESSION['firstname'] = $_POST['firstname'];
$_SESSION['lastname'] = $_POST['lastname'];
$_SESSION['date_to'] = $_POST['date_to'];
$_SESSION['date_from'] = $_POST['date_from'];
$_SESSION['room'] = $_POST['room'];
$_SESSION['menu'] = $_POST['menu'];
$_SESSION['guests_id'] = $_POST['guests_id'];
$_SESSION['services'] = $_POST['services'];

// echo "{$_POST['firstname']}";
// echo "{$_POST['lastname']}";
// echo "{$_POST['date_to']}";
// echo "{$_POST['date_from']}";
// echo "{$_POST['room']}";
// echo "{$_POST['id']}";



//Check the fields are not empty
if ($_POST['date_to'] == "")
    $_SESSION['errorMessage'] .= "<p>Enter Arrival date</p>";
if ($_POST['date_from'] == "")
    $_SESSION['errorMessage'] .= "<p>Enter Depature date</p>";
if ($_POST['room'] == "")
    $_SESSION['errorMessage'] .= "<p>Select a room</p>";


$originalDateTo = $_POST['date_to'];
$originalDateFrom = $_POST['date_from'];
// echo $originalDateFrom."<br>";
// echo $originalDateTo."<br>";
$originalDateTo = strtotime($originalDateTo);
$originalDateFrom = strtotime($originalDateFrom);
$originalDateTo = date('Y-m-d', $originalDateTo);
$originalDateFrom = date('Y-m-d', $originalDateFrom);

// echo $originalDateFrom."<br>";
// echo $originalDateTo."<br>";
// echo "{$_POST['guests_id']}";


// Check if the room is free
$query = "SELECT COUNT(bookings.room_fk) FROM bookings WHERE bookings.date_from >= \"$originalDateFrom\" AND bookings.date_to <= \"$originalDateTo\" AND bookings.room_fk = '{$_POST['room']}'";

$result = mysqli_query ($con, $query);

$row = mysqli_fetch_array ($result);

$numOfOccurence = $row['COUNT(bookings.room_fk)'];

// echo $numOfOccurence;

if ($numOfOccurence != 0) {
    $_SESSION['errorMessage'] .= "<p> The room is booked on selected date</p>";
}
$status = '1';

// if the error message is no longer empty
// return to the form
if ($_SESSION['errorMessage'] != "") {
    header("Location: booking.php");
} else {
    $query = "INSERT INTO bookings (guests_fk, date_from, date_to, menu_fk, status_fk, services_fk, room_fk)
    VALUES (
    '{$_SESSION['id']}',
    '$originalDateFrom',
    '$originalDateTo',
    '{$_POST['menu']}',
    '$status',
    '{$_POST['services']}',
    '{$_POST['room']}'
    )";
}


if (mysqli_query ($con, $query)) {
    echo "Booking made successfully";
} else{
    echo mysqli_error($con);
}
?>
