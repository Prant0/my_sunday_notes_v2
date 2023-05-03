<?php



//SELECT * FROM `wp_effu8c_posts` WHERE post_parent= 6739;

include_once 'db.php';

$sql = "SELECT `wp_effu8c_users`.`ID`,`wp_effu8c_uwp_usermeta`.`first_name`,`wp_effu8c_uwp_usermeta`.`last_name`,`wp_effu8c_uwp_usermeta`.`avatar_thumb`, `wp_effu8c_uwp_usermeta`.`bio` FROM `wp_effu8c_users` INNER JOIN `wp_effu8c_uwp_usermeta` ON `wp_effu8c_uwp_usermeta`.`user_id`=`wp_effu8c_users`.`ID` WHERE `wp_effu8c_users`.`display_name` LIKE '%".$_REQUEST['search']."%' OR `wp_effu8c_uwp_usermeta`.`bio` LIKE '%".$_REQUEST['search']."%';";
$result = $conn->query($sql);
$array = Array();
while($row = $result->fetch_assoc()) {
    $array[] = $row;
}
$conn->close();
echo json_encode($array);


 ?>