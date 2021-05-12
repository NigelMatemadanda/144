<?php
session_start();
include "includes/connect.php";
$_SESSION['errorMessage'] = "";


// Store the data from the form
$_SESSION['bookings_id'] = $_POST['bookings_id'];
$_SESSION['guests_id'] = $_POST['guests_id'];

// echo "{$_POST['bookings_id']}<br>";
// echo "{$_POST['guests_id']}";
// echo "{$_POST['date_to']}";
// echo "{$_POST['date_from']}";
// echo "{$_POST['room']}";
// echo "{$_POST['id']}";


// Check if the username is unique
$query = "SELECT COUNT(bookings_id) FROM bookings WHERE bookings_id = '{$_POST['bookings_id']}'";

$result = mysqli_query ($con, $query);

$row = mysqli_fetch_array ($result);

$numOfUsers = $row['COUNT(bookings_id)'];

if ($numOfUsers != 1) {
    $_SESSION['errorMessage'] .= "<p> The booking ID is invalid</p>";
}
// if the error message is no longer empty
// return to the form

$query = "UPDATE bookings SET status_fk = '2' WHERE bookings_id = {$_POST['bookings_id']}";

if (mysqli_query ($con, $query)) {
    echo "Booking has been cancelled";
} else{
    echo mysqli_error($con);
}
