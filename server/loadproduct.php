<?php
include_once("dbconnect.php");
$prname = $_POST['name'];

if (isset($prname)){
    $sqlloadproducts = "SELECT * FROM tbl_products WHERE name LIKE '%$prname%' ORDER BY date DESC";
}
else{
    $sqlloadproducts= "SELECT * FROM tbl_products ORDER BY date DESC";
}
$result = $conn->query($sqlloadproducts);


if ($result->num_rows > 0){
    $response["products"] = array();
    while ($row = $result -> fetch_assoc()){
        $prlist = array();
        $prlist[prid] = $row['prid'];
        $prlist[name] = $row['name'];
        $prlist[flavour] = $row['flavour'];
        $prlist[description] = $row['description'];
        $prlist[price] = $row['price'];
        $prlist[rating] = $row['rating'];
        $prlist[date] = $row['date'];

        
        array_push($response["products"],$prlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>