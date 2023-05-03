<?php



//SELECT * FROM `wp_effu8c_posts` WHERE post_parent= 6739;

include_once 'db.php';
//
$sql = "UPDATE `wp_effu8c_uwp_usermeta` SET `first_name`='".$_REQUEST['first_name']."',`display_name`='".$_REQUEST['display_name']."',`bio`='".$_REQUEST['bio']."',`service_time`='".$_REQUEST['service_time']."',`church_address`='".$_REQUEST['church_address']."',`phone`='".$_REQUEST['phone']."',`last_name`='".$_REQUEST['last_name']."' WHERE `user_id` = '".$_REQUEST['user_id']."'";
if($conn->query($sql) === TRUE){
    echo "1";
}else{
    echo "0";
}


 ?>