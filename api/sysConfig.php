<?php
  require_once "config.php";

  $dbClass = db::getInstance();
  $db=$dbClass->db;
  if (isset($datas['action']) ){
    switch ($datas['action']) {

      case 'EditSysConfig':

          $sql="UPDATE moduleTest set combine=?,perconunter=?,sysstatus=?,timu=?,type=?,types=?,qType=?,period=? where id=1";
          $_upup=$db->prepare($sql);
          echo  $_upup->execute(array($datas['data']['combine'],$datas['data']['perconunter'],$datas['data']['sysstatus'],$datas['data']['timu'],$datas['data']['type'],json_encode($datas['data']['types']),$datas['data']['qType'],json_encode($datas['data']['period'])));
          $dbClass->doRecord($datas['nowUserrole'],"修改了套题测试配置");
        break;

      case  'getConfig':
            $sql="select * from moduleTest limit 1";
            $res=$db->query($sql)->fetch(PDO::FETCH_ASSOC);
            $_sql="select * from quiz_config ";
            $_res=$db->query($_sql)->fetch(PDO::FETCH_ASSOC);

            $res['qTypeList']=$_res['types'];
            echo json_encode($res);
        break;
      case  'frontgetConfig':
          $sql="select * from moduleTest limit 1";
          $res=$db->query($sql);
          $dates=$res->fetch(PDO::FETCH_ASSOC);

          echo json_encode($dates);
        break;
      default:
        # code...
        break;
    }

    # code...
  }
