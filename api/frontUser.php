<?php
  header("Content-type:text/html,charset=utf8");
  $db=new PDO("mysql:host=192.168.20.104;dbname=dati","root","102098hchab");
  $datas=json_decode(file_get_contents("php://input"),true);
  if (isset($datas['action']) ){
    switch ($datas['action']) {
      case 'queryExits':
        $sql="select id from dati_record where uid=? and type=? limit 1";
        $cInsert=$db->prepare($sql);
        $cInsert->execute(array($datas['uid'],$datas['type']));
        if($cInsert->fetch(PDO::FETCH_ASSOC)){
          echo 1;
        }else{
          echo 0;
        }
        break;
      case 'getQuestions':
            if($datas['tag']=="single"){
              $sql="select * from quiz  order by rand() limit 1";
            }else{
              $configsql="select * from sysconfig limit 1";
              $res=$db->query($configsql);
              $config=$res->fetch(PDO::FETCH_ASSOC);
              if($config['delivery']=='true'){
                if($config['combine']=='随机组卷'){
                  $sql="select * from quiz  order by rand() limit {$config['timu']}";
                }else{
                  $sql="select * from quiz where isChecked=1 limit {$config['timu']}";
                }
              }else{
                //前台或后台数据丢失同步
                $sql="select * from quiz  order by rand() limit 1";
              }
            }


            $questions=$db->query($sql);
            $_resDates=array();
            while ($resDate=$questions->fetch(PDO::FETCH_ASSOC)) {
                $flag=false;
                $resDate['correctType']=$resDate['correct'];
                if(strlen($resDate['correct'])==1){
                  lconvertType($resDate['correct']);
                }elseif(strpos($resDate['correct'],",")) {
                  $flag=true;
                  $_dates=explode(",",$resDate['correct']);
                  foreach ($_dates as $key => $value) {
                    $_dates[$key]=lconvertType($value);
                  }

                  $resDate['correct']=implode(",",$_dates);
                }
                // $flag===false?$resDate['type']="单选":$resDate['type']="多选";
                array_push($_resDates,$resDate);
            }
            echo json_encode($_resDates);
        break;
      case 'saveQinfos':
        $db->beginTransaction();
        try {
          $_InserSqL="INSERT into dati_record (uid,Qid,result,times,counts,type) values(?,?,?,?,?,?)";
          $cInsert=$db->prepare($_InserSqL);
          $cInsert->execute(array($datas['uid'],implode(",",$datas['Qid']),$datas['scores'],date("Y-m-d H-i-s",time()),count($datas['Qid']),$datas['type']));
          echo  $db->commit();

        } catch (PDOException $e) {
          echo 0;
          $db->rollBack();
        }


        break;
      case 'auth':
        $sql="select headImg,nickname  from users where openid=? limit 1";
        $tempD=$db->prepare($sql);
        $tempD->execute(array($datas['openid']));
        $userInfo=$tempD->fetch(PDO::FETCH_ASSOC);
        $msg="";
        if(!$userInfo){
          $msg=array("erroCode"=>100);
        }else{
          $sql="select pwd,UID  from table_user where phone=? limit 1";
          $tempT=$db->prepare($sql);
          $tempT->execute(array($datas['phone']));
          $pwd=$tempT->fetch(PDO::FETCH_ASSOC);

          if(!$pwd){
            $msg=array("erroCode"=>101);
          }else{
            if($pwd['pwd']!=$datas['pwd']){
              $msg=array("erroCode"=>102);
            }else{
              $sql="UPDATE users SET uid ='{$pwd['UID']}' where openid = '{$datas['openid']}'";
              if($db->query($sql)){
                $msg=array(
                  "erroCode"=>200,
                  "uid"=>$pwd['UID']
                );
              }else{
                $msg=array("erroCode"=>103);
              }
            }
          }
        }
        echo json_encode($msg);

        break;
        case 'authCount':
        $sql="select id  from users where UID=? limit 1";
        $tempD=$db->prepare($sql);
        $tempD->execute(array($datas['UID']));
        $userInfo=$tempD->fetch(PDO::FETCH_ASSOC);
          break;
      case 'wxuser':
          $sql="select *  from users where openid=? limit 1";
          $tempD=$db->prepare($sql);
          $tempD->execute(array($datas['openid']));
          $userInfo=$tempD->fetch(PDO::FETCH_ASSOC);

          if(!$userInfo){
            echo 100;
            die;
          }
        break;
      case 'recordTypes':
            $db->beginTransaction();
            try {
              $sql="UPDATE quiz SET isChecked=1 where id=?";
              $update=$db->prepare($sql);
              foreach ($datas['datas'] as $key => $value) {
                $update->execute(array($value));
              }
              echo  $db->commit();
            } catch (PDOException $e) {
              $db->rollBack();
              echo 0;

            }
              break;
      case 'getUserInfo':
        $sql="select * from table_user left join users on table_user.UID=users.uid where table_user.UID=? limit 1";
        $info=$db->prepare($sql);
        $info->execute(array($datas['uid']));
        echo json_encode($info->fetch(PDO::FETCH_ASSOC));
        break;
        # code...
        case 'checkpwd':
            $sql="select id  from table_user where UID=? and pwd=? limit 1";
            $tempT=$db->prepare($sql);
            $tempT->execute(array($datas['uid'],$datas['pwd']));
            $pwd=$tempT->fetch(PDO::FETCH_ASSOC);
            if(!$pwd){
              echo 101;
            }else{
              echo 100;
            }
        break;
        case 'updatepwd':
            $sql="select id  from table_user where UID=? and pwd=? limit 1";
            $tempT=$db->prepare($sql);
            $tempT->execute(array($datas['uid'],$datas['pwd']));
            $pwd=$tempT->fetch(PDO::FETCH_ASSOC);
            if(!$pwd){
              echo 101;
              die;
            }
            $updateSql="update table_user set pwd=? where UID=?";
            $__update=$db->prepare($updateSql);
            if($__update->execute(array($datas['pwd1'],$datas['uid']))){
              echo 200;
            }else{
              echo 102;
            }

          break;
      case 'viewScores':

        $id=$datas['uid'];
        $index=$datas['index'];
        $sql="select * from dati_record where uid='$id' limit $index,10";
        $q=$db->query($sql);
        // $res->execute(array($datas['uid'],'5'));
        echo json_encode($q->fetchAll(PDO::FETCH_ASSOC));
        break;
      case 'getRank':
        $sql="select table_user.name,table_user.scores,users.headImg from table_user left join users on table_user.UID=users.uid ORDER BY scores desc";
        $res=$db->prepare($sql);
        $res->execute(array());
        echo json_encode($res->fetchAll(PDO::FETCH_ASSOC));
        break;
    }

    # code...
  }

  function lconvertType(&$data){
    switch ($data) {
        case '1':
        $data="A";
        break;
        case '2':
        $data="B";
        break;
        case '3':
        $data="C";
        break;
        case '4':
        $data="D";
        break;
        case '5':
        $data="E";
        break;
    }
    return $data;
  }

  function rconvertType(&$data){
    switch ($data) {
        case 'A':
        $data="1";
        break;
        case 'B':
        $data="2";
        break;
        case 'C':
        $data="3";
        break;
        case 'D':
        $data="4";
        break;
        case 'E':
        $data="5";
        break;
    }
    return $data;
}
