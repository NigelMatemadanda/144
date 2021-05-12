<?php
session_start();
include "includes/connect.php";
include "includes/functions.php";
include "includes/debug.php";
if ($_SESSION['loggedin']) {
    // get user data
    $query = "SELECT  firstname, lastname, guests_id from guests WHERE guests_id = {$_SESSION['id']}";

    $result = mysqli_query($con, $query);

    $guests_row = mysqli_fetch_array ($result);
}
?>
<!doctype html>
<html>
<head>
    <title>Book a room</title>
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
    <div id="ErrorMessage">
        <?php
            echo $_SESSION['errorMessage'];
        ?>
    </div>
    <div class="form">
    <form method="post" action="booking_process.php">
        <ol>
            <li>
                <input type="hidden" name="guests_id" value="<?php echo $guests_row['guests_id']; ?>" >
            </li>
            <li>
                <!-- <label for="firstname">Enter first name</label> -->
                <input type="text" name="firstname" id="firstname" value="<?php echo $guests_row['firstname']; ?>"placeholder = "firstname">
            </li>
            <li>
                <!-- <label for="firstname">Enter last name</label> -->
                <input type="text" name="lastname" id="lastname" value="<?php echo $guests_row['lastname']; ?>"placeholder = "lastname">
            </li>
            <li>
                <!-- <label for="usernmae">Arrival Date</label> -->
                <input type="date" name="date_from" id="date_from" placeholder = "Arrival Date">
            </li>
            <li>
                <!-- <label for="password">Depature Date</label> -->
                <input type="date" name="date_to" id="date_to" placeholder="Depature Date">
            </li>



            <li>
                <select name="room" id= "room">
                <option>Select room</option>
            <?php
            $query = "SELECT * FROM rooms";
            $result = mysqli_query ($con, $query);

            while ($row = mysqli_fetch_array ($result)) {
                        $roomsList[$row['rooms_id']] = $row['rooms_name'];
                    }
                    foreach ($roomsList as $key => $value) {
                        echo "<option value=\"$key\" $roomsList >$value</option>";

                    }

            ?>
            </select>
            </li>
            <li>
                <select name="menu" id= "menu">
                <option>Select menu</option>
            <?php
            $query = "SELECT * FROM menu";
            $result = mysqli_query ($con, $query);

            while ($row = mysqli_fetch_array ($result)) {
                        $menuList[$row['menu_id']] = $row['menu_name'];
                    }
                    foreach ($menuList as $key => $value) {
                        echo "<option value=\"$key\" $menuList >$value</option>";

                    }

            ?>
            </select>
            <li>
                <select name="services" id= "services">
                <option>Select services</option>
            <?php
            $query = "SELECT * FROM services";
            $result = mysqli_query ($con, $query);

            while ($row = mysqli_fetch_array ($result)) {
                        $servicesList[$row['services_id']] = $row['services_name'];
                    }
                    foreach ($servicesList as $key => $value) {
                        echo "<option value=\"$key\" $servicesList >$value</option>";

                    }

            ?>
            </select>
            </select>
            </li>
            <li>
                <label for="submit">&nbsp;</label>
                <input type="submit" name="submit" value="Book Now">
            </li>
        </ol>
    </form>
    </div>
</main>

<footer>
    <?php include "includes/footer.php"; ?>
</footer>

</div> <!-- End of Wrapper -->

</body>
</html>
