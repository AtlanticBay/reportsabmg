<?php
// Add password checks here if you want
if(isset($_POST['username'])) {
  $_SESSION['username'] = $_POST['username'];
  header("Location: index.php");
  exit;
}
include("../../templates/default/html/login_page.twig")
?>