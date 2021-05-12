<?php
session_start();
include "includes/connect.php";
$_SESSION['errorMessage'] = "";


// Store the data from the form
$_SESSION['username'] = $_POST['username'];
$_SESSION['password'] = $_POST['password'];
$_SESSION['firstname'] = $_POST['firstname'];
$_SESSION['lastname'] = $_POST['lastname'];
$_SESSION['gender'] = $_POST['gender'];


//Check the fields are not empty
if ($_POST['username'] == "")
    $_SESSION['errorMessage'] .= "<p>You must enter a username</p>";
if ($_POST['password'] == "")
    $_SESSION['errorMessage'] .= "<p>You must enter a password</p>";
if ($_POST['passwordC'] == "")
    $_SESSION['errorMessage'] .= "<p>You must confrim your password</p>";
if ($_POST['firstname'] == "")
    $_SESSION['errorMessage'] .= "<p>You must enter a firstname</p>";
if ($_POST['lastname'] == "")
    $_SESSION['errorMessage'] .= "<p>You must enter a lastname</p>";

// Check the passwords match
if ($_POST['password'] != $_POST['passwordC'])
    $_SESSION['errorMessage'] .= "<p>Your password does not match</p>";

// Check if the username is unique
$query = "SELECT COUNT(username) FROM guests WHERE username = '{$_POST['username']}'";

$result = mysqli_query ($con, $query);

$row = mysqli_fetch_array ($result);

$numOfUsers = $row['COUNT(username)'];

if ($numOfUsers != 0) {
    $_SESSION['errorMessage'] .= "<p> Please choose another username</p>";
}

// if the error message is no longer empty
// return to the form
if ($_SESSION['errorMessage'] != "") {
    header("Location: register.php");
} else {
    $query = "INSERT INTO guests (username, password, firstname, lastname, gender)
    VALUES (
    '{$_POST['username']}',
    '{$_POST['password']}',
     '{$_POST['firstname']}',
     '{$_POST['lastname']}',
     '{$_POST['gender']}'
    )";
}


if (mysqli_query ($con, $query)) {
    echo "New record created successfully";
} else{
    echo mysqli_error($con);
}
?>
