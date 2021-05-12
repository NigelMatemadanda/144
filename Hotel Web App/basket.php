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
    <title>Basket</title>
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
    <form method="post" action="">

        <table>
            <tr>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Arrival Date</th>
                <th>Depature</th>
                <th>Room</th>
                <th>Price</th>
                <th>Status</th>
                <th>ID</th>
            </tr>
            <?php
            $query = "SELECT guests.firstname, guests.lastname, bookings.date_from, bookings.date_to, rooms.rooms_name, rooms.price, status_name, bookings.bookings_id
            from
            bookings
            JOIN status
            ON bookings.status_fk = status.status_id
            JOIN guests
            ON bookings.guests_fk = guests.guests_id
            JOIN rooms
            ON bookings.room_fk = rooms.rooms_id
            WHERE guests_fk = '{$_SESSION['id']}'";
            $result = mysqli_query ($con, $query);

            if ($result-> num_rows > 0) {
               while ($row = $result-> fetch_assoc()) {
                   echo "<tr><td>". $guests_row['firstname'] . "</td><td>" . $guests_row['lastname'] . "</td><td>" . $row['date_from']
                   . "</td><td>" . $row['date_to'] . "</td><td>" . $row['rooms_name']. "</td><td>" . $row['price']. "</td><td>" . $row['status_name'] .  "</td><td>" . $row['bookings_id'] . "</td></tr>";
               }
               echo "</table>";
            } else {
                echo "No bookings";
            }

            ?>


        </table>

    </form><br>
    <form method="post" action="basket_process.php">
        <ol>
            <li>
                <input type="hidden" name="guests_id" value="<?php echo $guests_row['guests_id']; ?>" >
            </li>
            <li>
                <label for="bookings_id">Enter ID to cancel booking</label>
                <input type="text" name="bookings_id" id="bookings_id" placeholder = "">
            </li>
            <li>
                <label for="submit">&nbsp;</label>
                <input type="submit" name="submit" value="Cancel booking">
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
