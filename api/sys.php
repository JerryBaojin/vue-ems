<?php
  require_once "config.php";

  $dbClass = db::getInstance();
  $db=$dbClass->db;
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
          $res=array(
            "code"=>500
          );
          if (isset($_SESSION['validate-code'])) {

            if ($_SESSION['validate-code']==$datas['data']['password']) {
              //$_SESSION
              $_SESSION['validate-code']=null;
              $sql="select * from admin  where phone='{$datas['data']['username']}' limit 1";
              $questions=$db->query($sql);
              $userInfo=$questions->fetch(PDO::FETCH_ASSOC);
              //
              $userCount=$db->query("select count(id) from table_user")->fetch(PDO::FETCH_ASSOC);
              $datiCount=$db->query("select count(id) from dati_record")->fetch(PDO::FETCH_ASSOC);
              if ($userInfo) {
                $res['code']=200;
                $res['info']=$userInfo;
                $res['counterNumber']=array($datiCount['count(id)'],$userCount['count(id)']);
                $res['login_time']=date("Y-m-d H-i-s",time());
                $dbClass->doRecord($userInfo['counter'],"登录系统!");
              }else{
                    $res['code']=404;
              }
            }else{
              $res['code']=403;
            }
          }

              echo json_encode($res);
          break;
      case 'changePWD':
            $pwd=$datas['newpwd'];
            $sql="UPDATE admin set pwd=? where id=1";
            $questions=$db->prepare($sql);
            echo $questions->execute(array($pwd));
        break;
      case 'qUser':
          $sql="select headImg,nickname  from users where openid=? limit 1";
          $tempD=$db->prepare($sql);
          $tempD->execute(array($datas['openid']));
          $userInfo=$tempD->fetch(PDO::FETCH_ASSOC);
          $msg="";
          if(!$userInfo){
            $msg=array("erroCode"=>100);
          }else{
            $time=date("Y-m-d",time());
            $_sql="select times  from dati_record where openid=?";
            $_tempD=$db->prepare($_sql);
            $_tempD->execute(array($datas['openid']));
            $_recording=$_tempD->fetchAll(PDO::FETCH_ASSOC);
            $flag=false;
            foreach ($_recording as $key => $value) {
              if(explode(" ",$value['times'])[0]==$time){
                //存在当前答题时间
                $flag=true;
              }
            }
            if ($flag) {
              echo json_encode(array(
                "errorCode"=>204
              ));
            }else{
              echo json_encode(array(
                "errorCode"=>200,
                "datas"=>$userInfo
              ));
            }

          }
        break;
      case 'EditSysConfig':

          $sql="UPDATE sysconfig set combine=?,conunter=?,perconunter=?,sysstatus=?,timu=?,type=?,filter=?,types=?,qType=?,period=?,ScoresConfig=? where id=1";
          $_upup=$db->prepare($sql);
          echo  $_upup->execute(array($datas['data']['combine'],$datas['data']['conunter'],$datas['data']['perconunter'],$datas['data']['sysstatus'],$datas['data']['timu'],$datas['data']['type'],htmlspecialchars($datas['data']['filter'],ENT_QUOTES),json_encode($datas['data']['types']),$datas['data']['qType'],json_encode($datas['data']['period']),json_encode($datas['data']['ScoresConfig'])));
            $dbClass->doRecord($datas['nowUserrole'],"修改了系统通用设置");
        break;
      case 'getLog':
          $sql="select * from log order by id desc";
          $res=$db->query($sql)->fetchAll(PDO::FETCH_ASSOC);
          echo json_encode($res);
        break;
      case  'getConfig':
            $sql="select * from sysconfig limit 1";
            $res=$db->query($sql)->fetch(PDO::FETCH_ASSOC);
            $_sql="select * from quiz_config ";
            $_res=$db->query($_sql)->fetch(PDO::FETCH_ASSOC);

            $res['qTypeList']=$_res['types'];
            echo json_encode($res);
        break;
      case  'frontgetConfig':
          $sql="select * from sysconfig limit 1";
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
