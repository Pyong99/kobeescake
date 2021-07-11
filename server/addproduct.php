<?php
include_once("dbconnect.php");
$product_name = $_POST['name'];
$product_flavour = $_POST['flavour'];
$product_description = $_POST['description'];
$product_price = $_POST['price'];
$encoded_string = $_POST["encoded_string"];

$sqlinsert = "INSERT INTO tbl_products(name,flavour,description,price,status) VALUES('$product_name','$product_flavour','$product_description','$product_price','1')";
if ($conn->query($sqlinsert) === TRUE){
    $decoded_string = base64_decode($encoded_string);
    $filename = mysqli_insert_id($conn);
    $path = '../images/product/'.$filename.'.jpg';
    $is_written = file_put_contents($path, $decoded_string);
    echo "success";
}else{
    echo "failed";
}

?>