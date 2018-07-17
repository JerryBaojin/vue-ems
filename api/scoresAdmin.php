<?php
  require_once "config.php";
  $dbClass = db::getInstance();
  $db=$dbClass->db;

  if (isset($datas['action']) ){
    switch ($datas['action']) {
      case 'getConfig':
        $sql="select * from scores_config limit 1";
        $res=$db->query($sql)->fetch(PDO::FETCH_ASSOC);
        echo json_encode($res);
        break;
      case 'setConfig':
      $user=$datas['nowUserrole'];
    $datas=$datas['datas'];

        $sql="UPDATE scores_config set socres_lv=?,socres_name=?,socres_headPic=? where id =?";
        $q=$db->prepare($sql);
        if($q->execute(array($datas['socres_lv'],$datas['socres_name'],$datas['socres_headPic'],$datas['id']))){
          echo 200;
          $dbClass->doRecord($user,"更新了积分设置!");
        }else{
          echo 400;
        }

        break;
    }
}
if (!empty($_FILES)) {
  if($_FILES['lv']['error']!==0){
    echo 300;
    die;
  }
  preg_match('/[^.]+$/',$_FILES['lv']['name'],$result);

  if($_FILES['lv']['type']!='image/jpeg' && $_FILES['lv']['type']!='image/png'){
    echo 0;
    die();
  }
  $newName="upload/img/".uniqid().".".$result[0];
  if(move_uploaded_file($_FILES['lv']['tmp_name'],$newName)){
    echo json_encode(
      array(
        $_GET['x'],
        $newName
      )
      ) ;
  }
}
