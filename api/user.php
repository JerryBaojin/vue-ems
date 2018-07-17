<?php
  require_once "config.php";
  $dbClass = db::getInstance();
  $db=$dbClass->db;
  if (isset($datas['action']) ){
    switch ($datas['action']) {
        case 'getUsers':
        //SELECT * FROM (users INNER JOIN table_user ON users.UID=table_user.UID) INNER JOIN scores_month ON users.UID=scores_month.UID
          //id == uid
                $totalMonth=$db->query("select * from table_user left join users on table_user.id=users.uid")->fetchAll(PDO::FETCH_ASSOC);

                echo json_encode($totalMonth);

        break;
        case 'scoresgetUsers':
              $totalMonth=$db->query("select * from table_user left join users on table_user.id=users.uid")->fetchAll(PDO::FETCH_ASSOC);
              $allRecorad=$db->query("select * from dati_record")->fetchAll(PDO::FETCH_ASSOC);
              echo json_encode(array(
                "currentWeekMonday"=>strtotime(date("Y-m-d H:i:s",mktime(0, 0 , 0,date("m"),date("d")-date("w")+1,date("Y")))),
                "userInfo"=>$totalMonth,
                "dati_record"=>$allRecorad),JSON_UNESCAPED_UNICODE);
          break;
        case 'deleteUser':

        $db->beginTransaction();
        $sql="delete from admin WHERE id in (";


        $t=$datas['id'];
      if(in_array("1", $t)){
        echo 403;die;
      }
        try {

          $sql.=implode(",",$t);
          $sql.=")";
          $tempD=$db->prepare($sql);
          $tempD->execute();
            echo $tempD->rowCount();
            $dbClass->doRecord($datas['nowUserrole'],"删除id为".$t."管理员");
           $db->commit();
        } catch (PDOException $e) {
          $db->rollBack();
        }
          break;
        case 'add':
          $res=array(
            "code"=>500
          );
          //查看是否有重复的
          $sql="select id from admin where phone=? limit 1";
          $dz=$db->prepare($sql);
          $dz->execute(array($datas['phone']));
          if($dz->fetch(PDO::FETCH_ASSOC)){
            $res['code']=403;
          }else{
            $sql="INSERT INTO `admin` (`counter`, `role`, `phone`, `rTime`) VALUES (?,?,?,?)";
            $m=$db->prepare($sql);
            $m->execute(array($datas['counter'],$datas['role'],$datas['phone'],date("Y-m-d H-i-s",time())));
            $res['code']=201;
            $res['id']=$db->lastInsertId();
            $dbClass->doRecord($datas['nowUserrole'],"添加".$datas['counter']."管理员");
          }
          echo json_encode($res);
          break;

        case 'getSysuser':
          $sql="select * from admin";
          $users=$db->query($sql)->fetchAll(PDO::FETCH_ASSOC);
          echo json_encode($users);
          break;
          case 'editUser':
          $res=array(
            "code"=>500
          );
            $sql="UPDATE admin set counter=?,role=?,phone=?,rTime=? where id=?";
            $u=$db->prepare($sql);
            $u->execute(array($datas['counter'],$datas['role'],$datas['phone'],date("Y-m-d H-i-s",time()),$datas['id']));

            if($u->rowCount()){
              $res['code']=200;
              $dbClass->doRecord($datas['nowUserrole'],"修改".$datas['counter']."信息");
            }else{
              $res['code']=204;
            }
              echo json_encode($res);
            break;
      case 'update':
          $db->beginTransaction();
          $sql="UPDATE `users` SET status=1 WHERE (`id`=?) limit 1";

          try {
            foreach ($datas['id'] as $key => $value) {
                $tempD=$db->prepare($sql);
                $tempD->execute(array($value));
            }
              echo $db->commit();
          } catch (PDOException $e) {
            $db->rollBack();
          }
        break;
      case 'delete':

        $db->beginTransaction();
        $sql="delete from table_user where id in";
        $sql.="(".implode(",",$datas['id']).")";

        try {
            $db->query($sql);
            echo $db->commit();
             $dbClass->doRecord($datas['nowUserrole'],"删除了id为".implode(",",$datas['id'])."用户");
        } catch (PDOException $e) {
          echo 0;
            $db->rollBack();
        }



        # code...
        break;
    }

    # code...
  }

  if (!empty($_FILES)) {
    if($_FILES['file']['error']!==0){
      echo 300;
      die;
    }

    preg_match('/[^.]+$/',$_FILES['file']['name'],$result);
    if($result[0]!='csv'){
      echo 0;
      die();
    }
    $newName="upload/".uniqid().".".$result[0];
    if(move_uploaded_file($_FILES['file']['tmp_name'],$newName)){
      $__InsertSql="insert into table_user (name,phone,workUnit,role,InTime) values ";
      if (($handle = fopen($newName,"r")) !== FALSE) {
          $count=0;
          while (($data = fgetcsv($handle,1000,",")) !== FALSE) {
              $time=date("Y-m-d H-i-s",time());
            foreach ( $data as $key => $value) {
             $data[$key]=iconv('gb2312','utf-8',$value);
            }
            $count++;
             $__InsertSql.="('{$data[0]}','{$data[1]}','{$data[2]}','1','$time'),";
          }
          try {
            $db->beginTransaction();
            $_insetSQL=$db->prepare(substr($__InsertSql,0,strlen($__InsertSql)-1));
            $_insetSQL->execute();
            $db->commit();

           if ($_insetSQL->rowCount()) {
               $dbClass->doRecord($_SERVER['HTTP_TOKEN'],"添加了'{$count}'位用户");
               echo 1;
           } else{
             echo 0;
           }
          } catch (PDOException $e) {
              var_dump($e);
            $db->rollBack();

          }



          fclose($handle);
      }
    }
  }
