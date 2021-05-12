<div class="logo_container">
	<h1>Hotel<span>Blue Moon</span></h1>
</div>

<div id="logInForm">
	<?php
	if (!$_SESSION['loggedin']) {
	?>
	<form method="post" action="login_process.php">
		<input type="text" id="username" name="username" placeholder="username">
		<input type="password" id="password" name="password" placeholder="password">
		<input type="submit" id="submit" name="submit" value="Log In">
	</form>
	<?php
	}
	?>
</div>
<?php if ($debugOn) echo "<div id=\"debug\">\n" . debugMessage($con) . "</div>\n"; ?>
