<?php


include_once 'db.php';

$sql = "SELECT * FROM `wp_effu8c_posts` WHERE post_type LIKE 'envira' AND post_status='publish' ORDER BY post_title ASC;";
$result = $conn->query($sql);

$array = Array();

while($row = $result->fetch_assoc()) {
    $array[] = $row;
}


$conn->close();
echo json_encode($array);

?>