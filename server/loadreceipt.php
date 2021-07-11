<?php
include_once("dbconnect.php");
$email = $_POST['email'];

$sql = "SELECT * FROM tbl_receipts WHERE email LIKE '%$email%'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $receipt['receipt'] = array();
    while ($row = $result->fetch_assoc()) {
        $receiptlist['receiptid'] = $row['receiptid'];
        $receiptlist['amount'] = $row['amount'];
        $receiptlist['date'] = $row['date'];
        array_push($receipt['receipt'], $receiptlist);
    }
    echo json_encode($receipt);
} else {
    echo "nodata";
}

?>