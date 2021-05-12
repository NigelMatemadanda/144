<?php
session_start();
include "includes/connect.php";

$_SESSION['loggedin'] = false;
$_SESSION['id'] = 0;

if ($_POST['username'] != "" and $_POST['password'] != "") {

	$query = "SELECT guests_id, password FROM guests WHERE username = '{$_POST['username']}'";
	$result = mysqli_query ($con, $query);
	$row = mysqli_fetch_array ($result);


	// If the password from the form and the database match
	if ($row['password'] == $_POST['password']) {
	//echo "ok";
		// log the user include
		$_SESSION['loggedin'] = true;
		$_SESSION['id'] = $row['guests_id'];
	} else {
	//echo "BAD";
		// make sure the user is not logged in
		$_SESSION['loggedin'] = false;
		$_SESSION['id'] = 0;
	}

}

header("Location: index.php");
?>

