<?php
session_start();
include "includes/connect.php";
include "includes/functions.php";
$_SESSION['errorMessage'] = "";


// Store the data from the form
$_SESSION['email'] = $_POST['email'];
$_SESSION['firstname'] = $_POST['firstname'];
$_SESSION['lastname'] = $_POST['lastname'];
$_SESSION['gender'] = $_POST['gender'];
$_SESSION['dob'] = $_POST['dob'];
$_SESSION['address'] = $_POST['address'];
$_SESSION['city'] = $_POST['city'];
$_SESSION['postcode'] = $_POST['postcode'];
$_SESSION['mobile'] = $_POST['mobile'];


// //Check the fields are not empty
// if ($_POST['firstname'] == "")
//     $_SESSION['errorMessage'] .= "<p>Please provide a firstname</p>";
// if ($_POST['lastname'] == "")
//     $_SESSION['errorMessage'] .= "<p>lease provide a lastname</p>";

$firstname = filter_var($_POST['firstname'], FILTER_SANITIZE_STRING);
$lastname = filter_var($_POST['lastname'], FILTER_SANITIZE_STRING);
$email = filter_var($_POST['email'], FILTER_SANITIZE_STRING);
$address = filter_var($_POST['address'], FILTER_SANITIZE_STRING);
$city = filter_var($_POST['city'], FILTER_SANITIZE_STRING);
$postcode = filter_var($_POST['postcode'], FILTER_SANITIZE_STRING);


$firstname = trimInput($firstname, 20);
$lastname = trimInput($lastname, 20);
$email = trimInput($email, 50);
$address = trimInput($address, 50);
$postcode = trimInput($postcode, 20);


$query = "UPDATE guests
SET firstname= '$firstname',
lastname= '$lastname',
city='$city',
postcode= '$postcode',
email= '$email',
address= '$address',
dob='{$_POST['dob']}',
mobile='{$_POST['mobile']}'
WHERE guests_id= {$_SESSION['id']}";
if (mysqli_query ($con, $query)) {
    echo "Profile updated successfully";
} else{
    echo mysqli_error($con);
}



?>
