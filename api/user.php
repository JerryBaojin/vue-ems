<?php
  header("Content-type:text/html,charset=utf8");
  $db=new PDO("mysql:host=192.168.20.104;dbname=dati","root","102098hchab");
  $datas=json_decode(file_get_contents("php://input"),true);
  if (isset($datas['action']) ){
    switch ($datas['action']) {
        case 'getUsers':
        //SELECT * FROM (users INNER JOIN table_user ON users.UID=table_user.UID) INNER JOIN scores_month ON users.UID=scores_month.UID

                $totalMonth=$db->query("select * from dati_record left join users on dati_record.openid=users.openid")->fetchAll(PDO::FETCH_ASSOC);

                echo json_encode($totalMonth);

        break;
        case 'getSysuser':
          $sql="select * from admin";
          $users=$db->query($sql)->fetchAll(PDO::FETCH_ASSOC);
          echo json_encode($users);
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
