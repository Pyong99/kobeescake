<?php
$servername = "localhost";
$username   = "pyongcom_kobeescakeadmin";
$password   = "TZGN4!bCXHba";
$dbname     = "pyongcom_kobeescakedb";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection Failed: " . $conn->connect_error);
}
?>