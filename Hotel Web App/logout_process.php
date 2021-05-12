<?php
session_start();
// empty the session array
$_SESSION = array();
// Destroy the session	
session_destroy(); 	
// Navigate to some page
header('Location: index.php'); 
?>