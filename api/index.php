<?php
  $db=new PDO("mysql:host=192.168.20.104;dbname=weixin","root","102098hchab");
  if (isset($_POST['action'])) {
      $index=$_POST['page'];
      $sql="select * from quiz limit $index,10";
      $questions=$db->query($sql);
      $db->execute();
      $Res=$questions->fetchAll(PDO::FETCH_ASSOC);
      echo json_encode($res);
    # code...
  }
