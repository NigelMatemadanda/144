<?php
session_start();
include "includes/connect.php";
include "includes/functions.php";
include "includes/debug.php";

if ($_SESSION['loggedin']) {
    // get user data
    $query = "SELECT  firstname, lastname, email, gender, dob, address, city, postcode, mobile from guests WHERE guests_id = {$_SESSION['id']}";

    $result = mysqli_query($con, $query);

    $guests_row = mysqli_fetch_array ($result);

    $gender = $guests_row['gender'];

} else {
    header("Location: index.php");
}


?>
<!doctype html>
<html>
<head>
    <title>Profile</title>
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
    <h2>My Profile</h2>
    <div id="message">
        <?php
            echo $_SESSION['message'];
        ?>
    </div>
    <div class="form">
    <form method="post" action="profile_process.php">
        <ol>
            <li>
                <!-- <label for="firstname">First name</label> -->
                <input type="text" name="firstname" id="firstname" value="<?php echo $guests_row['firstname']; ?>"placeholder = "firstname">
            </li>
            <li>
                <!-- <label for="firstname">Last name</label> -->
                <input type="text" name="lastname" id="lastname" value="<?php echo $guests_row['lastname']; ?>"placeholder = "lastname">
            </li>
            <li>
                <!-- <label for="firstname">Email</label> -->
                <input type="text" name="email" id="email" value="<?php echo $guests_row['email']; ?>"placeholder = "email">
            </li>
            <li>
                <!-- <label for="firstname">D.O.B</label> -->
                <input type="text" name="dob" id="dob" value="<?php echo $guests_row['dob']; ?>"placeholder = "dob">
            </li>
            <li>
                <!-- <label for="firstname">Address</label> -->
                <input type="text" name="address" id="address" value="<?php echo $guests_row['address']; ?>"placeholder = "address">
            </li>
            <li>
                <!-- <label for="firstname">City</label> -->
                <input type="text" name="city" id="city" value="<?php echo $guests_row['city']; ?>"placeholder = "city">
            </li>
            <li>
                <!-- <label for="firstname">Postcode</label> -->
                <input type="text" name="postcode" id="postcode" value="<?php echo $guests_row['postcode']; ?>"placeholder = "postcode">
            </li>
            <li>
                <!-- <label for="firstname">Mobile</label> -->
                <input type="text" name="mobile" id="mobile" value="<?php echo $guests_row['mobile']; ?>"placeholder = "mobile">
            </li>


    <ul>
        <li>&nbsp;</li>
    <?php
        $query = "SELECT * FROM genders";
        $result = mysqli_query ($con, $query);

        while ($row = mysqli_fetch_array ($result)) {
                    $genderList[$row['genders_id']] = $row['genders_name'];
                }
                foreach ($genderList as $key => $value) {
                    if ($key == $gender) {
                        $genderChecked = "checked";
                    } else {
                        $genderChecked = "";
                    }
                    echo "<li>";
                        echo "<input type=\"radio\" id=\"$value\" name=\"gender\ value=\"$key\" $genderChecked>";
                        echo "<label for=\"$value\">$value</label>";
                        echo "</li>";
                }
    ?>
    </ul>

     <li>
            <li>
                <label for="submit">&nbsp;</label>
                <input type="submit" name="submit" value="Update Profile">
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
