<?php
  header("Content-type:text/html,charset=utf8");
  $db=new PDO("mysql:host=192.168.20.104;dbname=dati","root","102098hchab");
  $datas=json_decode(file_get_contents("php://input"),true);
  if (isset($datas['action']) ){
    switch ($datas['action']) {
      case 'checkPWD':
            $pwd=$datas['o'];
            $sql="select pwd from admin limit 1";
            $questions=$db->query($sql);
            if($questions->fetch(PDO::FETCH_ASSOC)['pwd']==$pwd){
              echo 1;
            }else{
              echo 0;
            }
        break;
        case 'login':
              $_newCount=$datas['data'];
              $sql="select * from admin  limit 1";
              $questions=$db->query($sql);
              $validateDates=$questions->fetch(PDO::FETCH_ASSOC);
              $res=array(
                "statusCode"=>200
              );
              $validateDates['counter']!=$_newCount['username']?$res['statusCode']=400:null;
              $validateDates['pwd']!=$_newCount['password']?$res['statusCode']=403:null;
              echo json_encode($res);
          break;
      case 'changePWD':
            $pwd=$datas['newpwd'];
            $sql="UPDATE admin set pwd=? where id=1";
            $questions=$db->prepare($sql);
            echo $questions->execute(array($pwd));
        break;
      case 'EditSysConfig':
          $sql="UPDATE sysconfig set combine=?,conunter=?,perconunter=?,delivery=?,timu=? where id=1";
          $_upup=$db->prepare($sql);

          $datas['data']['delivery']?$_bool="true":$_bool="false";
        echo  $_upup->execute(array($datas['data']['combine'],$datas['data']['conunter'],$datas['data']['perconunter'],$_bool,$datas['data']['timu']));
        break;

      case  'getConfig':
            $sql="select * from sysconfig limit 1";
            $res=$db->query($sql);
            echo json_encode($res->fetch(PDO::FETCH_ASSOC));
        break;
      default:
        # code...
        break;
    }

    # code...
  }
