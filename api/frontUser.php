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
      $time=date("Y-m-d",time());
      $_sql="select times  from dati_record where openid=?";
      $_tempD=$db->prepare($_sql);
      $_tempD->execute(array($datas['uid']));
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
          "errorCode"=>203
        ));
        die;
      }
        $sql="select oid  from users where openid=? limit 1";
        $tempD=$db->prepare($sql);
        $tempD->execute(array($datas['uid']));
        $userInfo=$tempD->fetch(PDO::FETCH_ASSOC);
        if(!$userInfo){
          //检验用户身份真实性
          echo json_encode(array("erroCode"=>403));
          die;
        }

        $_datas=array(
        "openid"=>$datas['uid'],
        "money"=>0,
        "scores"=>0
        );
      $file = fopen("lock.txt","w+");

      if (flock($file,LOCK_EX)) {

          $sql="select * from sysconfig left join weChatHB ON weChatHB.id=sysconfig.id";
          $data=$db->query($sql)->fetch(PDO::FETCH_ASSOC);

          if ($data['model']==1) {
            if ($data['Left']<=0) {
              echo json_encode(array(
                'errorCode' => 204,
                "msg"=>"没钱啦!"
              ));
              releaseLock($file);
            }else{
              foreach ($datas['datas'] as $key => $value) {
                if ($value['res']==1 && $value['choosed']==$value['correct']) {
                  $_datas['scores']+=$data['scoreR'];
                }else{
                  $_datas['scores']+=$data['scoreW'];
                }
              }

              //查看是否达到分数线
              if ($_datas['scores']<= (int) $data['wLowWinner']) {
                  synsDates($db,$file,$_datas);
              }else{
                $_datas['money']=rand(1,$data['wMaxMoney']);
                if($data['Left']+$data['Grant']==$data['total']){ //检验数据是否一致
                    if($data['Left']<=10 || $data['Left']-$_datas['money']<0  ){
                        $_datas['money']=$data['Left'];
                    }
                    synsDates($db,$file,$_datas);
                }else{
                  //

                  releaseLock($file);
                  die(0);
                }
              }

            }
          }else{
            //普通模式  undefined methods

            synsDates($db,$file,$_datas);
          }
      }else{
        echo 123;
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

  function releaseLock($file){
    flock($file,LOCK_UN);
    fclose($file);
  }
  function synsDates($db,$file,$datas){

        $data=$datas;

        $data['money']=$data['money']*100;
        $resData=array(
          "status"=>"failed",
         "err_code_des"=>"未达到相应的分数!"
        );
        $isGetRewards=0;
        if ($data['money']!=0) {
          $isGetRewards=1;
          $arrDates=json_decode(callPay("http://weixin.scnjnews.com/wxpay/hongbao/action.php",$data),true);
          $resData=array(
          "status"=>$arrDates['result_code'],
          "err_code_des"=>$arrDates['err_code_des']
          );
        }

        $db->beginTransaction();
        try {
        //请求红包~~；
        //  $readMoney
        //`id`, `openid`, `result`, `times`, `scores`, `money`
        $_InserSqL="INSERT into dati_record (openid, result,times,scores,money,resData) values (?,?,?,?,?,?)";
        $cInsert=$db->prepare($_InserSqL);
        //  $cInsert->execute(array($datas['uid'],implode(",",$datas['Qid']),$datas['scores'],date("Y-m-d H-i-s",time()),count($datas['Qid']),$datas['type']));
        $cInsert->execute(array($datas['openid'],$isGetRewards,date("Y-m-d H-i-s",time()),$datas['scores'],$datas['money'],json_encode($resData,JSON_UNESCAPED_UNICODE)));
          if ($db->commit()) {
            $data=array(
              'errorCode' => 200,
              "money"=>$datas['money']
            );
          }else{
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

        if($resData['status']!='SUCCESS'){
          $data=array(
            'errorCode' => 504,
            "money"=>$datas['money'],
            "msg"=>$resData['err_code_des']
          );
        }
        echo json_encode($data,JSON_UNESCAPED_UNICODE);
        releaseLock($file);
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
