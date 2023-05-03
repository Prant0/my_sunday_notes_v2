<?php



//SELECT * FROM `wp_effu8c_posts` WHERE post_parent= 6739;

include_once 'db.php';

$sql = "SELECT * FROM `wp_effu8c_posts` WHERE post_parent= ".$_REQUEST['parent_id'];
$result = $conn->query($sql);

$array = Array();

while($row = $result->fetch_assoc()) {
    $array[] = $row;
}


$conn->close();
echo json_encode($array);


 ?>