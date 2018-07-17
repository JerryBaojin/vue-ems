<?php

require_once __DIR__.'/../vendor/autoload.php';

use Gregwar\Captcha\CaptchaBuilder;

class validate
{

  public function seed(){
    header('Content-type: image/jpeg');
    $captcha = new CaptchaBuilder;
    $_SESSION['validateCode']=$captcha->getPhrase();
    $captcha
        ->build()
          ->output()
    ;
  }
  public function check($code,$params=null,$period=null,$uid=null){
    $res=array(
      "currentTimeChar"=>time(),
      "isAnswerd"=>0,
      "validateRes"=>0
    );
    if ($uid==0) {

    }
    if ($params && $uid) {
        if ($period) {
          list($start,$end)=json_decode($period);
        }


        $db=new PDO("mysql:host=192.168.20.104;dbname=datijw","root","102098hchab");
        $resDb=$db->prepare("select times from dati_record where uid=? and type = ?");
        $resDb->execute(array($uid,$params));
        $user_records=$resDb->fetchAll(PDO::FETCH_ASSOC);

        if (!empty($user_records)) {
          switch ($params) {
            case 'taoti':
                foreach ($user_records as  $value) {
                  $_currentDate=$value["times"];
                  if ($_currentDate<$end && $_currentDate>$start) {
                      $res['isAnswerd']=1;
                      break;
                  }
                }
              break;
            case 'single':
                  foreach ($user_records as $key => $value) {
                      $_currentDate=$value["times"];
                    if ($period) {
                      if ($_currentDate<$end && $_currentDate>$start) {
                          $res['isAnswerd']=1;
                          break;
                      }
                    }

                    if (date("Y-m-d",$_currentDate)==date("Y-m-d",$res['currentTimeChar'])) {
                        $res['isAnswerd']=1;
                        break;
                    }
                  }
              break;
            case 'muti':

                foreach ($user_records as $key => $value) {
                  if ($period) {
                    $_currentDate=$value["times"];
                    if ($_currentDate<$end && $_currentDate>$start) {
                        $res['isAnswerd']=1;
                        break;
                    }
                  }
                    $_currentDate=date("W",$value["times"]);
                  if ($_currentDate==date("W",$res['currentTimeChar'])) {
                      $res['isAnswerd']=1;
                      break;
                  }
                }
              break;

            default:
              # code...
              break;
          }

        }

    }

    if (isset($_SESSION['validateCode']) && $code==$_SESSION['validateCode']) {
            $res['validateRes']=1;
            $_SESSION['validateCode']=null;
      }
      //测试期间可以一直答题
        $res['isAnswerd']=0;
      echo json_encode($res);
  }
}

$getDates=$_GET;

$_validate=new validate();
if ($getDates['action']=="seed") {
  $_validate->seed();
}else{
  $_validate->check(@$getDates['code'],$getDates['params'],$getDates['period'],$getDates['uid']);
}
