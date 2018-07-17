<?php
$dDates=(array)json_decode(file_get_contents("php://input"));

switch ($dDates['act']) {
  case 'JSSDK':
  require_once "jssdk.php";
   $jssdk = new JSSDK("wx6f1fa092a4f5e263","51eb6b33ee16bfa2e213c037f9d4c4f8");
   $signPackage = $jssdk->GetSignPackage();
 	$x=array(
 		"signPackage"=>$signPackage
 	);
   echo json_encode($x);
   return false;


}
echo json_encode($preparArray);

 ?>
