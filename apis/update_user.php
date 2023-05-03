<?php



//SELECT * FROM `wp_effu8c_posts` WHERE post_parent= 6739;

include_once 'db.php';
//
$sql = "UPDATE `wp_effu8c_uwp_usermeta` SET `user_ip`='',`user_privacy`='',`tabs_privacy`='',`username`='".$_REQUEST['username']."',`first_name`='".$_REQUEST['first_name']."',`avatar_thumb`='',`banner_thumb`='',`display_name`='".$_REQUEST['display_name']."',`user_url`='',`bio`='".$_REQUEST['bio']."',`avatar`='',`banner`='',`old_password`='',`service_time`='".$_REQUEST['service_time']."',`church_address`='".$_REQUEST['church_address']."',`phone`='".$_REQUEST['phone']."',`last_name`='".$_REQUEST['last_name']."' WHERE `email` LIKE '".$_REQUEST['email']."'";
if($conn->query($sql) === TRUE){
    echo "1";
}else{
    echo "0";
}


 ?>