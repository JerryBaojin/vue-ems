<?php
  header("Content-type:text/html,charset=utf8");
  $db=new PDO("mysql:host=192.168.20.104;dbname=dati","root","102098hchab");
  $datas=json_decode(file_get_contents("php://input"),true);
  if (isset($datas['action']) ){
    switch ($datas['action']) {
      case 'getUsers':
      //SELECT * FROM (users INNER JOIN table_user ON users.UID=table_user.UID) INNER JOIN scores_month ON users.UID=scores_month.UID
            $sql="select * from table_user left join users on table_user.UID=users.uid";
            try {
              $questions=$db->query($sql);
              $totalMonth=$db->query("select * from scores_month")->fetchAll(PDO::FETCH_ASSOC);
              $combineArray=array();
              $_resDates=$questions->fetchAll(PDO::FETCH_ASSOC);
              foreach ($_resDates as $key => $v) {
                foreach ($totalMonth as $value) {
                  $_resDates[$key]['monthCount']=array();
                  if($value['UID']==$v['UID']){
                      $_resDates[$key]['monthCount'][]=$value;
                  }
                }
              }

              echo json_encode($_resDates);
            } catch (PDOException $e) {
              echo 0;
            }
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
        $sql="delete from quiz where id =?";
        try {
          foreach ($datas['details'] as $key => $value) {
            $tempD=$db->prepare($sql);
             $tempD->execute(array($value));
          }
            echo $db->commit();
        } catch (PDOException $e) {
          $db->rollBack();
        }

        # code...
        break;

        # code...
        break;
    }

    # code...
  }
