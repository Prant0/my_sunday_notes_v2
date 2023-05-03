<?php

//SELECT * FROM `wp_effu8c_posts` WHERE post_parent= 6739;

include_once 'db.php';

$sql = "SELECT * FROM `wp_effu8c_uwp_usermeta` WHERE user_id=".$_REQUEST['user_id'];

$result = $conn->query($sql);
$row = $result->fetch_assoc();
echo json_encode($row);


 ?>