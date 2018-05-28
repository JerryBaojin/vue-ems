<?php
  $db=new PDO("mysql:host=192.168.20.104;dbname=dati","root","102098hchab");

  function https_request($url,$data="")
  {
      $ch=curl_init();
      curl_setopt($ch, CURLOPT_URL, $url);//请求地址
      curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//文件流
      curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);//关闭ssl验证
      if ($data) {
          curl_setopt($ch, CURLOPT_POST, 1);
          curl_setopt($ch,CURLOPT_HEADER,0);
          curl_setopt($ch, CURLOPT_POSTFIELDS, $data);//
      }
      $request=curl_exec($ch);//执行
      $tempArr=json_decode($request,TRUE);
     if (is_array($tempArr)) {
          return $tempArr;
      }
      else
      {
          return $request;
      }
      curl_close($ch);
  }

define("APPPATH","http://localhost:8080/dati/#/front/login");
    //do getting getUserInfo
    $appid="wx0d40a4492d506bb2";
    $appsecret="01fc4f89cc9c84f4be14f4bf85190ae5";
    $url="http://wx1.scnjnews.com/dati/api";
    $uri="$url/useropenid.php";
    $scope='snsapi_base';
    $urlb="https://open.weixin.qq.com/connect/oauth2/authorize?appid=$appid&redirect_uri=$uri&response_type=code&scope=$scope&state=STATE#wechat_redirect";
  if(!@$_GET['code']){
    header("Location:$urlb");
    exit;
  }

$code=$_GET['code'];
$ass="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=$appid&secret=$appsecret";//全局
$c=https_request($ass);
$access=$c['access_token'];//获取全局acess_token

//未关注
$op="https://api.weixin.qq.com/sns/oauth2/access_token?appid=$appid&secret=$appsecret&code=$code&grant_type=authorization_code";
$oppp=https_request($op);

$access_token=$oppp["access_token"];
$openid=$oppp['openid'];

$wonderExit=$db->query("select openid from users where openid='$openid' limit 1");
  if($wonderExit->fetch()){
    $redirectHref=APPPATH."?openid=$openid";
    header("Location:$redirectHref");
    exit();
  }

$sc="https://api.weixin.qq.com/cgi-bin/user/info?access_token=$access&openid=$openid";
$userinfo=https_request($sc);
$subscribe=$userinfo['subscribe'];//根据全局acess_token获取信息，如果用户未关注则获取不来详细情况；
if ($subscribe==0) {
$test="https://api.weixin.qq.com/sns/userinfo?access_token=$access_token&openid=$openid&lang=zh_CN ";
$userinfo=https_request($test);
}

  try {
    //emutor datas
    $db->beginTransaction();
    $openid=$openid;
    $nickname=$userinfo['nickname'];
    $headimg=$userinfo['headimgurl'];
    $timestamp=date("Y-m-d H-i-s",time()).rand(1000,10000);

    $sql="INSERT into users  (`openid`,`nickname`,`headimg`,`RegistTime`) values ('','$openid','$nickname','$headimg','$timestamp')";
    $q=$db->exec($sql);
    $res=$db->commit();
    if($res){
      $redirectHref=APPPATH."?openid=$openid";
      header("Location:$redirectHref");
      exit();
    }
  } catch (PDOException $e) {
     die ("Error!: " . $e->getMessage() . "<br/>");
  }



?>
