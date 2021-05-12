<ul class="navigation">
    <li><a href="index.php">Home</a></li>
    <?php
    if ($_SESSION['loggedin']) {
    ?>
    <li><a href="booking.php">Make a booking</a></li>
     <?php
    }
    ?>
    <li><a href="facilities.php">Facilities</a></li>
    <li><a href="dining.php">Dining</a></li>
    <li><a href="events.php">Events</a></li>
    <li><a href="spar_wellness.php">Spa & Wellness</a></li>
    <?php
    if ($_SESSION['loggedin']) {
    ?>
    <li><a href="basket.php">Basket</a></li>
    <?php
    }
    ?>
    <?php
    if ($_SESSION['loggedin']) {
    ?>
    <li><a href="profile.php">Profile</a></li>
    <?php
    }
    ?>
    <?php
    if (!$_SESSION['loggedin']) {
    ?>
    <li><a href="register.php">Register</a></li>
    <?php
    }
    ?>
    <?php
    if ($_SESSION['loggedin']) {
    ?>
    <li><a href="logout_process.php">Log out</a></li>
    <?php
    }
    ?>
</ul>

