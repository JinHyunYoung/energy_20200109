<?php
/*
 * jQuery File Upload Plugin PHP Example 5.14
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */
include_once "../../../../conf/default.php";
@include_once("./JSON.php");

if( !function_exists('json_encode') ) {
    function json_encode($data) {
        $json = new Services_JSON();
        return( $json->encode($data) );
    }
}

@ini_set('gd.jpeg_ignore_warning', 1);

$ym = date('ym', time());

$data_dir = PATH_UPLOAD_ROOT.'editor/uploaded/'.$ym.'/';
$data_url = URL_UPLOAD_ROOT.'editor/uploaded/'.$ym.'/';

@mkdir($data_dir, 0777);
@chmod($data_dir, 0777);

if(!function_exists('ft_nonce_is_valid')){
    include_once('../../../editor.lib.php');
}

$is_editor_upload = true;

if( isset($_GET['_nonce']) && ft_nonce_is_valid( $_GET['_nonce'] , 'smarteditor' ) ){
    $is_editor_upload = true;
}

if( $is_editor_upload ) {

    require('UploadHandler.php');
    $options = array(
        'upload_dir' => $data_dir,
        'upload_url' => $data_url,
        // This option will disable creating thumbnail images and will not create that extra folder.
        // However, due to this, the images preview will not be displayed after upload
        'image_versions' => array()
    );

    $upload_handler = new UploadHandler($options);

} else {
    echo json_encode(array('files'=>array('0'=>array('error'=>'정상적인 업로드가 아닙니다.'))));
    exit;
}
