<?php
echo md5('TrtR3#ArvSxfePLoHJ#rzNF7');
if(wp_check_password('$P$BKaXFtd0mjZkx2Xkts0s2zMCkvkscA/', 'TrtR3#ArvSxfePLoHJ#rzNF7', 1))
{
    echo "<br> Correct password ";
}
else{
    echo "<br> Incorrect password ";
}

//INSERT INTO `wp_effu8c_users`(`user_login`, `user_pass`, `user_nicename`, `user_email`, `user_url`, `user_registered`, `user_activation_key`, `user_status`, `display_name`) VALUES ('')



// $user_id = wp_insert_user(array(
//     'user_login'=>$restRequest->get_param('username'),
//     'user_pass'=>$restRequest->get_param('password'),
//     'user_nicename'=>$restRequest->get_param('nicename'),
//     'user_email'=>$restRequest->get_param('email'),
//     'user_url'=>$restRequest->get_param('url'),
//     'user_activation_key'=>$restRequest->get_param('activation_key'),
//     'user_status'=>$restRequest->get_param('status'),
//     'display_name'=>$restRequest->get_param('display_name')
// ));



//Update Record
// 'bio'=>$restRequest->get_param('bio'),
// 'avatar'=>$restRequest->get_param('avatar'),
// 'banner'=>$restRequest->get_param('banner'),
// 'old_password'=>$restRequest->get_param('old_password'),
// 'service_time'=>$restRequest->get_param('service_time'),
// 'church_address'=>$restRequest->get_param('church_address'),
// 'phone'=>$restRequest->get_param('phone'),


$insert = $wpdb->insert($table_name, array(
    'user_id'=>$user_id,
    'user_ip'=>"0",
    'user_privacy'=>"",
    'tabs_privacy'=>"",
    'username'=>$restRequest->get_param('username'),
    'email'=>$restRequest->get_param('email'),
    'first_name'=>$restRequest->get_param('first_name'),
    'avatar_thumb'=>$restRequest->get_param('avatar_thumb'),
    'banner_thumb'=>$restRequest->get_param('banner_thumb'),
    'display_name'=>$restRequest->get_param('display_name'),
    'user_url'=>$restRequest->get_param('user_url'),

    'avatar'=>$restRequest->get_param('avatar'),
    'banner'=>$restRequest->get_param('banner'),
    'old_password'=>$restRequest->get_param('old_password'),
    'last_name'=>$restRequest->get_param('last_name'),
    
));










$user_id = wp_insert_user(array(
    'user_login'=>$restRequest->get_param('username'),
    'user_pass'=>$restRequest->get_param('password'),
    'user_nicename'=>$restRequest->get_param('nicename'),
    'user_email'=>$restRequest->get_param('email'),
    'user_url'=>$restRequest->get_param('url'),
    'user_activation_key'=>$restRequest->get_param('activation_key'),
    'user_status'=>$restRequest->get_param('status'),
    'display_name'=>$restRequest->get_param('display_name')
));

$additionalData = array(
        'user_id'=>$user_id,
        'user_ip'=>"0",
        'user_privacy'=>"",
        'tabs_privacy'=>"",
        'username'=>$restRequest->get_param('username'),
        'email'=>$restRequest->get_param('email'),
        'first_name'=>$restRequest->get_param('first_name'),
        'avatar_thumb'=>$restRequest->get_param('avatar_thumb'),
        'banner_thumb'=>$restRequest->get_param('banner_thumb'),
        'display_name'=>$restRequest->get_param('display_name'),
        'user_url'=>$restRequest->get_param('url'),

        'last_name'=>$restRequest->get_param('last_name'));

if($user_id>0){
     $table_name = $wpdb->prefix . 'uwp_usermeta';

    $insert = $wpdb->insert($table_name,$additionalData );
    
    return $insert;
}else{
    return "Error";
}

?>