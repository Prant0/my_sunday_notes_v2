<?php

include_once 'db.php';

$sql = "SELECT post_author FROM `wp_effu8c_posts` WHERE ID=".$_REQUEST['post_id'];
$result = $conn->query($sql);
$row=$result->fetch_assoc();

$rowObject = new stdClass();

$authorId = $row['post_author'];
$sql = "SELECT display_name FROM `wp_effu8c_users` WHERE ID=".$authorId;
$result = $conn->query($sql);
$row=$result->fetch_assoc();

$display_name =$row['display_name'];

$sql="SELECT * FROM `wp_effu8c_uwp_usermeta` WHERE user_id=".$authorId;
$result = $conn->query($sql);

while($row = $result->fetch_assoc()) {
    $rowObject=$row;
}

$rowObject['display_name']=$display_name;

$sql="SELECT * FROM `wp_effu8c_postmeta` WHERE post_id=".$_REQUEST['post_id'];
$result = $conn->query($sql);
$datarow = new stdClass();
while($row = $result->fetch_assoc()) {
    $key = $row['meta_key'];
    $datarow->$key=$row['meta_value'];
}
$rowObject['data'] =$datarow; 


echo json_encode($rowObject);


 ?>