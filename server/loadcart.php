<?php
include_once("dbconnect.php");
$email = $_POST['email'];

$sqlloadcarts = "SELECT * FROM tbl_carts INNER JOIN tbl_products ON tbl_carts.prid = tbl_products.prid WHERE tbl_carts.email = '$email'";

$result = $conn->query($sqlloadcarts);

if ($result->num_rows > 0) {
    $response["cart"] = array();
    while ($row = $result->fetch_assoc()) {
        $productlist[prid] = $row['prid'];
        $productlist[prname] = $row['name'];
        $productlist[prtype] = $row['flavour'];
        $productlist[prprice] = $row['price'];
        $productlist[prrating] = $row['rating'];
        $productlist[cartqty] = $row['cartqty'];
        $productlist[prqty] = $row['status'];
        array_push($response["cart"], $productlist);
    }
    echo json_encode($response);
} else {
    echo "nodata";
}

?>