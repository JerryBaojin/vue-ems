<?php

  require_once "config.php";
  $dbClass = db::getInstance();
  $db=$dbClass->db;

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
            $resJson=array(
              "code"=>500
            );
            $configsql=null;
              $datas['tag']=='taoti'?$configsql="select * from moduletest limit 1":$configsql="select * from sysconfig limit 1";
              $res=$db->query($configsql);
              $config=$res->fetch(PDO::FETCH_ASSOC);
              if($config['sysstatus']=="关闭"){
                echo json_encode($resJson);die;
              }
              $qType='';
              $config['qType']=="默认"?$qType='qType=qType':$qType="qType='{$config['qType']}'";

                if($config['combine']=='random'){
                  $types=array(
                    $config['qType'] => $config['timu'],
                  );
                      getResult($db,mutiTypes($types,$db,"qType"),$resJson);
                }elseif($config['combine']=='manchoose'){
                  $sql="select * from quiz where isChecked=1 limit {$config['timu']}";
                  getResult($db,$sql,$resJson);
                }elseif($config['combine']=='manmade'){
                  //according  to types of question
                  //等待优化
                  $types=json_decode($config['types'],true);
                  /*
                  $all=$db->query("select id,question,answer,correct,qType,types  from quiz  where qType='$qType' ");
                  var_dump($all->fetchAll(PDO::FETCH_ASSOC));*/
                  try {
                      getResult($db,mutiTypes($types,$db,"types",$config['qType']),$resJson);
                  } catch (Exception $e) {
                        getResult($db,mutiTypes($types,$db),$resJson);
                  }
                }
            echo json_encode($resJson);
        break;
      case 'userRegist':
         $msg=array(
           "code"=>200
         );
         $str = $datas['nickname'];
         if(!preg_match('/^[\x{4e00}-\x{9fa5}]+$/u', $str)>0){
           $msg['code']=199;
           echo json_encode($msg);die;
         }

        $strs=$db->query("SELECT filter from sysconfig limit 1")->fetch(PDO::FETCH_ASSOC);
        $filter_datas=explode(",",$strs['filter']);
        //过滤昵称
        $isValidated=true;
        foreach ($filter_datas as $key => $value) {
          if(preg_match("/{$datas['nickname']}/",$value)){
            $isValidated=false;
            break;
          }
        }
        if (!$isValidated) {
          $msg['code']=404;
        }else{
          $uid=0;
          //若传过来的数据不存在name字段 则插入一条 并将插入返回的ID
          $db->beginTransaction();
          $msg=null;
          $InTime=date("Y-m-d H-i-s",time());
          try {
            if (!@$datas['name']) {

              $Insert=$db->prepare("insert into table_user (phone,InTime) values (?,?)");

              $Insert->execute(array($datas['phone'],$InTime));
              $datas['UID']=$db->lastInsertId();

            }else{
              $datas['UID']=$datas['id'];
            }
            $uid=$datas['UID'];

            $sync=$db->prepare("update table_user as t1,users as t2 set t1.dirName=?,t1.uid=?,t2.uid=? where t1.phone=? and t2.openid=?");
            $sync->execute(array($datas['nickname'],$uid,$uid,$datas['phone'],$datas['openid']));
            if ($sync->rowCount()) {
              $userInfo=array(
                "uid"=>$uid,
                "headImg"=>$datas['headImg'],
                "nickname"=>$datas['nickname']
              );
              $msg['code']=201;
              $msg['infos']=$userInfo;
            }else {
              $msg['code']=0;
            }
            $db->commit();
          } catch (PDOException $e) {
              $db->rollBack();
              $msg['code']=0;
          }


        }
        echo json_encode($msg);
        # code...
        break;
      case 'saveQinfos':
        //validate  已对答题的次数做了验证，因此直接跳过即可
        $cTime=date("Y-m-d H-i-s",$datas['timeChar']);
        $data=array(
          "errorCode"=>400
        );
        $configsql="select * from sysconfig limit 1";
        $res=$db->query($configsql);
        $config=$res->fetch(PDO::FETCH_ASSOC);
        if($config['sysstatus']=="关闭"){
          echo json_encode($data);die;
        }

        $configsql="select id from dati_record where uid='{$datas['uid']}' and times='$cTime' limit 1";
        $resA=$db->query($configsql);
        $_re=$resA->fetch(PDO::FETCH_ASSOC);
        if ($_re) {
          $data["errorCode"]=403;
          echo json_encode($data);die;
        }
        $db->beginTransaction();
        try {
          //获取当前等级
        $lvInfos=$dbClass->getLevels($datas['uid'],$datas['scores']);
        if ($lvInfos['statusCode']==200) {
          $sql="UPDATE  table_user set levelImg='{$lvInfos['levelImg']}',level='{$lvInfos['tag']}' where UID='{$datas['uid']}'";

        }else{
          $sql="UPDATE  table_user set levelImg='',level='' where UID='{$datas['uid']}'";
        }
        $db->query($sql);
        $_InserSqL="INSERT into dati_record (openid, times,counts,uid,type,scores) values (?,?,?,?,?,?)";
        $cInsert=$db->prepare($_InserSqL);

        $cInsert->execute(array($datas['openid'],$datas['timeChar'],$datas['_qCounts'],$datas['uid'],$datas['_qTypes'],$datas['scores']));

        if ($db->lastInsertId()) {
          $db->commit();
          $data=array(
            "lvInfos"=>$lvInfos,
            'errorCode' => 200
          );
        }else{
          $db->rollBack();
          $data=array(
            'errorCode' => 500,
          );
        }

        } catch (PDOException $e) {
          $db->rollBack();
          $data=array(
            'errorCode' => 500,
          );
        }


        echo json_encode($data);


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
      case 'getCode':
        $str="0123456789";
        $code='';
        for ($i=0; $i <4 ; $i++) {
          $code.=$str[mt_rand(0,strlen($str)-1)];
        }
      //   $res=get("http://utf8.sms.webchinese.cn/?Uid=hsoon&Key=bb04711f76e2adfe1eba&smsMob={$datas['phone']}&smsText=您的验证码是:{$code}");
          $_SESSION['validate-code']=$code;
             echo json_encode(array(
                 'msg'=>1,//$res,
                 'code' =>$code//$code ,
             ));
            break;
            case 'AdmingetCode':
              $ext=$db->prepare("select id from admin where phone =? limit 1");
              $ext->execute(array($datas['phone']));
              $infos=$ext->fetch(PDO::FETCH_ASSOC);
            if (!$infos) {
              echo 403;die;
            }
              $str="0123456789";
              $code='';
              for ($i=0; $i <4 ; $i++) {
                $code.=$str[mt_rand(0,strlen($str)-1)];
              }
            //   $res=get("http://utf8.sms.webchinese.cn/?Uid=hsoon&Key=bb04711f76e2adfe1eba&smsMob={$datas['phone']}&smsText=您的验证码是:{$code}");
            $_SESSION['validate-code']=$code;
               echo json_encode(array(
                   'msg'=>1,//$res,
                   'code' =>$code//$code ,
               ));
          break;
      case 'authPhone':
        $str="0123456789";
        $code='';
        for ($i=0; $i <4 ; $i++) {
          $code.=$str[mt_rand(0,strlen($str)-1)];
        }

      //  $res=get("http://utf8.sms.webchinese.cn/?Uid=hsoon&Key=bb04711f76e2adfe1eba&smsMob={$datas['phone']}&smsText=您的验证码是:{$code}");

        $sql="select * from users left join  table_user  on users.uid=table_user.UID where table_user.phone=? or users.openid=? limit 1";
        $userInfo=$db->prepare($sql);
        $userInfo->execute(array($datas['phone'],$datas['openid']));

        echo json_encode(array(
            'msg'=>1,//$res,
            'code' =>$code,//$code ,
            "userinfo"=>$userInfo->fetch(PDO::FETCH_ASSOC)
        ));
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

        case 'updateDirName':
        $str = $datas['pwd1'];
        if(!preg_match('/^[\x{4e00}-\x{9fa5}]+$/u', $str)>0){

          echo 199;die;
        }

       $strs=$db->query("SELECT filter from sysconfig limit 1")->fetch(PDO::FETCH_ASSOC);
       $filter_datas=explode(",",$strs['filter']);
       //过滤昵称

       foreach ($filter_datas as $key => $value) {
         if(preg_match("/$str/",$value)){

           echo 198;die;
         }
       }

            $sql="select id  from table_user where UID=? limit 1";
            $tempT=$db->prepare($sql);
            $tempT->execute(array($datas['uid']));
            $pwd=$tempT->fetch(PDO::FETCH_ASSOC);
            if(!$pwd){
              echo 101;
              die;
            }
            $updateSql="update table_user set dirName=? where UID=?";
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
        $sql="select * from dati_record where uid='$id' order by id desc limit $index,10 ";
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


    function seedProduct($count,&$idList,$id_side){
        if (count(array_unique($idList))<$count) {
          $nowDate=mt_rand($id_side['1'],$id_side['0']);
            array_push($idList,$nowDate);
            seedProduct($count,$idList,$id_side);
        }
    }
    function mutiTypes($types,$db,$typec,$specialCharType=null){

      if (is_array($types)) {
          $idList='';
        foreach ($types as $key => $value) {
          //先讲所有ID准备好
          $key=='judge'?$key='jungle':null;
          if ($specialCharType) {
            # code...
          }
          if ($specialCharType) {
              $specialCharType=='默认'?$sql="select id from quiz ":$sql="select id from quiz where qtype='$specialCharType'";
          }else{
            $key=='默认'?$sql="select id from quiz ":$sql="select id from quiz where $typec='$key'";
          }

          //获取到当前类型的所有ID
          $id_side=$db->query($sql);
          if(!$id_side){
            throw new Exception("types counts error");
            return true;
          }
          $id_side=$id_side->fetchAll(PDO::FETCH_ASSOC);

          //随机数ID生成

          for ($i=0; $i <$value ; $i++) {
            count($id_side)==1?$index=0:$index=mt_rand(0,(count($id_side)-1));
              $idList.=",".$id_side[$index]['id'];
              array_splice($id_side,$index,1);
          }
        }
        $idList=substr($idList,1);
        $idList2="id,".$idList;

        $sql="select * from quiz where id in ($idList)  order by field($idList2) ";
        return $sql;
      }


    }

  function callPay($url,$data){
      $postUrl = $url;
      $curlPost = $data;
      $ch = curl_init();//初始化curl
      curl_setopt($ch, CURLOPT_URL,$postUrl);//抓取指定网页
      curl_setopt($ch, CURLOPT_HEADER, 0);//设置header
       curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);//关闭ssl验证
      curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//要求结果为字符串且输出到屏幕上
      curl_setopt($ch, CURLOPT_POST, 1);//post提交方式
      curl_setopt($ch, CURLOPT_POSTFIELDS, $curlPost);
      $data = curl_exec($ch);//运行curl
      curl_close($ch);
      return $data;
  }
  function getResult($db,$sql,&$res){

    $questions=$db->query($sql);
    $_resDates=array();
    while ($resDate=$questions->fetch(PDO::FETCH_ASSOC)) {
        $flag=false;
        $resDate['correctType']=$resDate['correct'];
        if(strlen($resDate['correct'])==1){
          lconvertType($resDate['correct']);
        }elseif(strpos($resDate['correct']
        ,",")) {
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
    $res=array(
      "code"=>200,
      "data"=>$_resDates
    );

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
