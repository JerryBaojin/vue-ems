<?php
  header("Content-type:text/html,charset=utf8");
  $db=new PDO("mysql:host=192.168.20.104;dbname=dati","root","102098hchab");
  $datas=json_decode(file_get_contents("php://input"),true);
  if (isset($datas['action']) ){
    switch ($datas['action']) {
      case 'getQuestions':

            $index=$datas['page'];
            $sql="select * from quiz  order by id desc ";
            $questions=$db->query($sql);
            $_resDates=array();
            while ($resDate=$questions->fetch(PDO::FETCH_ASSOC)) {
                $flag=false;
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
                $flag===false?$resDate['type']="单选":$resDate['type']="多选";
                array_push($_resDates,$resDate);
            }
            echo json_encode($_resDates);
        break;
      case 'update':
          if(strlen($datas['details']['correct'])==1){
            rconvertType($datas['details']['correct']);
          }elseif(strpos($datas['details']['correct'],",")) {
            $_date=explode(",",$datas['details']['correct']);
            foreach ($_date as $key => $value) {
              $_date[$key]=rconvertType($value);
            }
            $datas['details']['correct']=implode(",",$_date);
          }
          $sql="UPDATE `quiz` SET question=?,answer=?,correct=? WHERE (`id`=?)";
          $questions=$db->prepare($sql);
          $questions->execute(array($datas['details']['question'],$datas['details']['answer'],$datas['details']['correct'],$datas['details']['id']));
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
      case 'changeChecking':
          $db->beginTransaction();
          try {
            $sql="UPDATE quiz SET isChecked=0 where id=?";
            $update=$db->prepare($sql);
            foreach ($datas['ids'] as $key => $value) {
              $update->execute(array($value));
            }
            echo  $db->commit();
          } catch (PDOException $e) {
            $db->rollBack();
            echo 0;
          }
          break;
        break;
      default:
        # code...
        break;
    }

    # code...
  }

  if (!empty($_FILES) && $_FILES['file']['error']===0) {
    preg_match('/[^.]+$/',$_FILES['file']['name'],$result);
    if($result[0]!='csv'){
      echo 0;
      die();
    }
    $newName="upload/".uniqid().".".$result[0];
    if(move_uploaded_file($_FILES['file']['tmp_name'],$newName)){
      $__InsertSql="insert into quiz (question,answer,correct) values ";
      if (($handle = fopen($newName,"r")) !== FALSE) {
          while (($data = fgetcsv($handle,1000,",")) !== FALSE) {
          //
            foreach ( $data as $key => $value) {
             $data[$key]=iconv('gb2312','utf-8',$value);
            }

            $c=$data[3];
            rconvertType($c);
             $__InsertSql.="('{$data[1]}','{$data[2]}','$c'),";
          }

        echo $db->exec(substr($__InsertSql,0,strlen($__InsertSql)-1));

          fclose($handle);
      }
    }
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
