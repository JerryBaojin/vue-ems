<?php
  require_once "config.php";
  $dbClass = db::getInstance();
  $db=$dbClass->db;
  if (isset($datas['action']) ){
    switch ($datas['action']) {
      case 'doRecord':
              $dbClass->doRecord($datas['nowUserrole'],$datas['msg']);
        break;
      case 'updateQuizConfig':
        $datas=json_encode($datas['moreDate'],JSON_UNESCAPED_UNICODE);
        $db->query("UPDATE `quiz_config` SET `types`='$datas' WHERE (`id`='1')");
        $dbClass->doRecord($datas['nowUserrole'],"新增了".$datas['msg']."分类");

        # code...
        break;
      case 'getQuizConfig':
        $sql="select * from quiz_config";
      echo json_encode($db->query($sql)->fetch(PDO::FETCH_ASSOC));
        break;
      case 'getQuestions':
            $index=$datas['page'];
            $sql="select * from quiz  order by id desc ";
            $questions=$db->query($sql);
            $_resDates=array();
            while ($resDate=$questions->fetch(PDO::FETCH_ASSOC)) {

                if(strlen($resDate['correct'])==1){
                  lconvertType($resDate['correct']);
                }elseif(strpos($resDate['correct'],",")) {

                  $_dates=explode(",",$resDate['correct']);
                  foreach ($_dates as $key => $value) {
                    $_dates[$key]=lconvertType($value);
                  }

                  $resDate['correct']=implode(",",$_dates);
                }

                $resDate['types']=="single"?$resDate['type']="单选":($resDate['types']=="muti"?$resDate['type']="多选":$resDate['type']="判断");
                array_push($_resDates,$resDate);
            }
            echo json_encode($_resDates);
        break;
      case 'update':
          // if(strlen($datas['details']['correct'])==1){
          //   rconvertType($datas['details']['correct']);
          // }elseif(strpos($datas['details']['correct'],",")) {
          //   $_date=explode(",",$datas['details']['correct']);
          //   foreach ($_date as $key => $value) {
          //     $_date[$key]=rconvertType($value);
          //   }
          //   $datas['details']['correct']=implode(",",$_date);
          // }
          $sql="UPDATE `quiz` SET question=?,answer=?,correct=? WHERE (`id`=?)";
          $questions=$db->prepare($sql);
          $questions->execute(array($datas['details']['question'],$datas['details']['answer'],$datas['details']['correct'],$datas['details']['id']));
        break;
      case 'delete':

        $db->beginTransaction();
        $sql="delete from quiz where id in (?)";
        try {

            $tempD=$db->prepare($sql);
             $tempD->execute(array(implode(",",$datas['details'])));

             $db->commit();
             echo $tempD->rowCount();
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
            $sql="UPDATE quiz SET isChecked='{$datas['status']}' where id=?";
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
    $currentType=unicode_decode($_SERVER['HTTP_QTYPES']);

    $newName="upload/".uniqid().".".$result[0];
    if(move_uploaded_file($_FILES['file']['tmp_name'],$newName)){
      $__InsertSql="insert into quiz (question,answer,correct,types,qType) values ";
      if (($handle = fopen($newName,"r")) !== FALSE) {
        $counter=0;
          while (($data = fgetcsv($handle,1000,",")) !== FALSE) {


            foreach ( $data as $key => $value) {
             $data[$key]=iconv('gb2312','utf-8',$value);
            }
            if ($data[1]=='' || $data[0]=='题目') {
            	continue;
            }
            $counter++;
              //          var_dump($data[3]);
              if(preg_match("/正确|错误/",$data[1]))
              {
                $type="jungle";
              }elseif (strlen($data['2'])==1) {
                $type="single";
              }else{
                $type="muti";
              }
  
             //$__InsertSql.="('{$data[1]}','{$data[2]}','$c'),";
             //$Q="###A.{$data[1]}###B.{$data[2]}###C.{$data[3]}";
             $__InsertSql.="('{$data[0]}','{$data[1]}','{$data[2]}','$type','$currentType'),";
          }
          try {
            $db->beginTransaction();
            $_insetSQL=$db->prepare($__InsertSql);
            $_insetSQL->execute();
            $db->commit();

           if ($_insetSQL->rowCount()) {
               $dbClass->doRecord($_SERVER['HTTP_TOKEN'],"添加了'{$counter}'道题");
               echo 1;
           } else{

                echo 0;
           }
          } catch (PDOException $e) {

            $db->rollBack();

          }
        echo $db->exec(substr($__InsertSql,0,strlen($__InsertSql)-1));

          fclose($handle);
      }
    }
  }

  function unicode_decode($name)
  {
      // 转换编码，将Unicode编码转换成可以浏览的utf-8编码
      $pattern = '/([\w]+)|(\\\u([\w]{4}))/i';
      preg_match_all($pattern, $name, $matches);
      if (!empty($matches))
      {
          $name = '';
          for ($j = 0; $j < count($matches[0]); $j++)
          {
              $str = $matches[0][$j];
              if (strpos($str, '\\u') === 0)
              {
                  $code = base_convert(substr($str, 2, 2), 16, 10);
                  $code2 = base_convert(substr($str, 4), 16, 10);
                  $c = chr($code).chr($code2);
                  $c = iconv('UCS-2', 'UTF-8', $c);
                  $name .= $c;
              }
              else
              {
                  $name .= $str;
              }
          }
      }
      return $name;
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
