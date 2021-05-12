<?php
session_start();
include "includes/connect.php";
include "includes/functions.php";
include "includes/debug.php";
?>
<!doctype html>
<html>
<head>
    <title>Register Here</title>
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
    <form method="post" action="register_process.php">
        <ol>
            <li>
                <!-- <label for="usernmae">Choose a username</label> -->
                <input type="text" name="username" id="username" value="<?php echo $_SESSION['username']; ?>"placeholder = "Username">
            </li>
            <li>
                <!-- <label for="password">Choose a password</label> -->
                <input type="text" name="password" id="password" placeholder="Password">
            </li>
            <li>
                <!-- <label for="passwordC">Confirm your password</label> -->
                <input type="text" name="passwordC" id="passwordC" placeholder="Confirm password">
            </li>
            <li>
                <!-- <label for="firstname">Enter first name</label> -->
                <input type="text" name="firstname" id="firstname" value="<?php echo $_SESSION['firstname']; ?>" placeholder="First name">
            </li>
            <li>
                <!-- <label for="firstname">Enter last name</label> -->
                <input type="text" name="lastname" id="lastname" value="<?php echo $_SESSION['lastname']; ?>" placeholder= "Last name">
            </li>



            <li>
                <label for="gender">Gender</label>

            <ul>
            <li>&nbsp;</li>
            <?php
                $query = "SELECT * FROM genders";
                $result = mysqli_query ($con, $query);

                while ($row = mysqli_fetch_array ($result)) {
                    $isChecked = "";
                    // check if the style_id is in $_SESSION['danceStyle']
                    if ($_SESSION ['genders'] == $row['genders_id'])
                        // if it is add the word "checked" to the field
                        $isChecked = "checked";

                    echo
                    "<li>
                    <input
                    type=\"radio\"
                    name=\"gender\"
                    id=\"genders{$row['genders_id']}\"
                    value=\"{$row['genders_id']}\"
                    $isChecked>
                    {$row['genders_name']}
                    </li>\n";
                }
            ?>
            </ul>

            <li>
                <label for="submit">&nbsp;</label>
                <input type="submit" name="submit" value="Register">
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
