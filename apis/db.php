<?php


$servername = "localhost";
$username = "data_mysunday";
$password = "himysunday@#2525";
$dbname = "data_mysunday";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

?>