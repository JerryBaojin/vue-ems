<?php

/**
 * pdo 单例
 */
class db
{
  public $db;
  static private $_instance;
  function __clone()
  {
    # code...
  }
  private function __construct(){
    $this->db=new PDO("mysql:host=192.168.20.104;dbname=datijw","root","102098hchab");
  }
  static public function getInstance(){
    if (!self::$_instance instanceof self) {
        self::$_instance = new self();
    }
    return self::$_instance;
  }
   public function getLevels($uid,$newScores){
   //对等级作修改
   $db=$this->db;
   $newTagName="暂无称号!";
   $level=0;



      $scores_config=$db->query("select * from scores_config limit 1")->fetch(PDO::FETCH_ASSOC);
      $scores_level=json_decode($scores_config['socres_lv']);
      $ImgLists=json_decode($scores_config['socres_headPic'],true);

      $socres_name=json_decode($scores_config['socres_name']);
      $_currentScores=$db->query("select scores,level,levelImg from table_user where UID='$uid' limit 1")->fetch(PDO::FETCH_ASSOC);
      $_currentScores['scores']+=$newScores;

      //
      $resJson=array(
        "statusCode"=>203,
        "levelImg"=>$_currentScores['levelImg']
      );
      foreach ($scores_level as $key => $value) {

       if ($key==0) {

          if ($value>$_currentScores['scores']) {
            $resJson['statusCode']=203;
            $resJson['tag']="暂未获得称号";
           //啥都没有
          }
       }
       elseif($_currentScores['scores']>=$value && $key==3){
         $resJson['statusCode']=200;
         $resJson['levelImg']=$ImgLists["lv".$key];
         $resJson['tag']=$socres_name[3];

         break;
       }
       elseif($scores_level[$key]>$_currentScores['scores'] && $scores_level[$key-1]<=$_currentScores['scores']){

        //右>左
        //在此区间，划分等级
        $lv=intval(($value-$scores_level[$key-1])/10);//每个等级差值 10等分，intval 向下取整

        $beginPath=$scores_level[$key-1];//600

        for ($i=0; $i <10 ; $i++) {

          $beginArea=$beginPath;//值传递
          $beginArea+=$lv*$i;
          $tcompare=$beginPath+$lv*($i+1);

          if ($beginArea<=$_currentScores['scores'] && $tcompare>$_currentScores['scores']  ) {
            $resJson['statusCode']=200;
            $resJson['level']=$i+1;
            $resJson['levelImg']=$ImgLists["lv".$key];

            $resJson['tag']=$socres_name[$key-1];

            break 2;
          }
        }
       }
      }
(isset($resJson['level']) && $resJson['level']!=0 )? $resJson['tag'].=$resJson['level']."级":null;
//判断是否升级
$resJson['tag']!==$_currentScores['level']?$resJson['levelUp']=1:$resJson['levelUp']=0;

     return $resJson;
}
  public function doRecord($user,$action){
    $time=date("Y-m-d H-i-s",time());
    $sql="INSERT INTO `log` (`user`, `action`, `time`) VALUES (?,?,?)";

    $actor=$this->db->prepare($sql);
    $actor->execute(array($user,$action,$time));
    return $this->db->lastInsertId();
  }

}

$datas=json_decode(file_get_contents("php://input"),true);
