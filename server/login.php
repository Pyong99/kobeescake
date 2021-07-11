<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$password = sha1($_POST['password']);

$sqllogin = "SELECT * FROM tbl_users WHERE email = '$email' AND password = '$password' AND otp = '0'";
$result = $conn->query($sqllogin);

if ($result->num_rows > 0) {
    while ($row = $result ->fetch_assoc()){
     echo $data = "success,".$row["name"].",".$row["quantity"].",".$row["rating"].",".$row["credit"].",".$row["status"];
     
        
    }
}else{
    echo "failed";
}

?>
