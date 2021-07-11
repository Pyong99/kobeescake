<?php
include_once("dbconnect.php");
$email = $_POST['email'];
$prid = $_POST['prid'];
$op = $_POST['op'];
$cartqty = $_POST['cartqty'];

if ($op == "addcart") {
    $sqlupdatecarts = "UPDATE tbl_carts SET cartqty = cartqty +1 WHERE prid = '$prid' AND email = '$email'";
    if ($conn->query($sqlupdatecarts) === TRUE) {
        echo "success";
    } else {
        echo "failed";
    }
}
if ($op == "removecart") {
    if ($cartqty == 1) {
        echo "failed";
    } else {
        $sqlupdatecarts = "UPDATE tbl_carts SET cartqty = cartqty - 1 WHERE prid = '$prid' AND email = '$email'";
        if ($conn->query($sqlupdatecarts) === TRUE) {
            echo "success";
        } else {
            echo "failed";
        }
    }
}
?>