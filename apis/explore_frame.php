<?php



//SELECT * FROM `wp_effu8c_posts` WHERE post_parent= 6739;

include_once 'db.php';

$sql = "SELECT * FROM `wp_effu8c_posts` INNER JOIN `wp_effu8c_postmeta` ON `wp_effu8c_postmeta`.`post_id`=`wp_effu8c_posts`.`ID` WHERE post_author !=0 AND post_author !=1 AND guid NOT LIKE '%.png' GROUP BY `wp_effu8c_postmeta`.`post_id` ORDER BY ID DESC;";
$result = $conn->query($sql);

$array = Array();

while($row = $result->fetch_assoc()) {
    $newsql = "SELECT guid, meta_value FROM `wp_effu8c_postmeta` INNER JOIN `wp_effu8c_posts` ON `wp_effu8c_posts`.`ID`=`wp_effu8c_postmeta`.`meta_value` WHERE post_id=".$row['ID']." AND meta_key='_thumbnail_id';";
    $childresult = $conn->query($newsql);
    $childrow = $childresult->fetch_assoc();
    $row['guid'] = $childrow['guid'];
    $array[] = $row;
}

echo json_encode($array);


 ?>