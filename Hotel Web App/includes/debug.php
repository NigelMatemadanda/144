<?php

$debugOn = false;
$showTables = false;

/*
description: Checks if the page is connected toteh DB. Returns appropriate message
name: debugMessage
parm: the database connection object
return: A message specifying the connection status
*/

function debugMessage($con) {
	// check the connection
	if (!$con) {
		// If there is no connection show error message
		$msg = "<p>The site <strong>IS NOT</strong> connected to the database</p>\n";
		$msg .= "<p>Debugging errno: " . mysqli_connect_errno() . "</p>\n";
		$msg .= "<p>Debugging error: " . mysqli_connect_error() . "</p>\n";
	} else {
		// All good - Show a sucess message
		$msg = "<p>The site is connected to the database</p>\n";
	}

	// Check user status

	if ($_SESSION['loggedin']) {
		$msg .= "<p>The user is logged in</p>\n";
	} else {
		$msg .= "<p>The user <strong>IS NOT</strong> logged in</p>\n";
	}

	$msg .= "<p>The user ID is " . $_SESSION['id'] . "</p>\n";

	return $msg;

}



/*
description: Returns an array of table names
name: getTableNames
parm: the database connection object
return: An array of table names
*/

function getTableNames ($con) {
	// The query to select the table names
	$query = "SHOW TABLES";
	// Run the query
	$result = mysqli_query($con, $query);
	// Loop through to get the table names
	while ($row = mysqli_fetch_array($result)) {
		// Change "Tables_in_dance" to "Tables_in_yourDBName"
		$tables[] = $row['Tables_in_blue_moon'];
	}

	return $tables;
}

/*
description: Returns an array of table names
name: getTableNames
parm: the database connection object
parm: the table name
return: An array of table names
*/

function getFieldNames ($con, $tableName) {
	// The query to select the field names
	$query = "desc $tableName";
	// Run the query
	$result = mysqli_query($con, $query);
	// Loop through to get the field names
	while ($row = mysqli_fetch_array($result)) {
		$fields[] = $row['Field'];
	}

	return $fields;

}

/*
description: Creates a list of tables and fields
name: displayTables
parm: the database connection object
return: A string with the HTML list
*/

function displayTables ($con) {
	// Set the output to be an empty string
	$output = "";
	// Get the table names
	$tables = getTableNames ($con);
	// Loop through each of the tables
	foreach ($tables as $table) {
		// Get the field names
		$fields = getFieldNames ($con, $table);
		// Add the table name to the output string
		$output .= "<strong>$table</strong>\n";
		$output .= "<ul>\n";
		// Loop through the field names and add as list items
		foreach ($fields as $field) {
			$output .= "<li>$field</li>\n";
		}
		$output .= "</ul>\n";
	}

	return $output;
}
?>

