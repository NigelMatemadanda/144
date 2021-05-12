<?php
session_start();
include "includes/connect.php";
include "includes/functions.php";
include "includes/debug.php";
?>
<!doctype html>
<html>
<head>
    <title>Hotel Blue Moon</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimun-sclae=1.0">
    <link rel="stylesheet" href="styles/main.css">
</head>

</body>

<div id="wrapper">

<header>
    <?php include "includes/header.php"; ?>
</header>

<nav>
    <?php include "includes/nav.php"; ?>
</nav>

<main>
    <img src="./media/2.jpg" alt="Hotel Image">
</main>

<footer>
    <?php include "includes/footer.php"; ?>
</footer>

</div> <!-- End of Wrapper -->

</body>
</html>
