<?php
/**
 * PHPExcel
 *
 * Copyright (C) 2006 - 2013 PHPExcel
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 *
 * @category   PHPExcel
 * @package    PHPExcel
 * @copyright  Copyright (c) 2006 - 2013 PHPExcel (http://www.codeplex.com/PHPExcel)
 * @license    http://www.gnu.org/licenses/old-licenses/lgpl-2.1.txt	LGPL
 * @version    ##VERSION##, ##DATE##
 */

/** Error reporting */
error_reporting(E_ALL);
ini_set('display_errors', TRUE);
ini_set('display_startup_errors', TRUE);
date_default_timezone_set('Europe/London');

if (PHP_SAPI == 'cli')
	die('This example should only be run from a Web Browser');

/** Include PHPExcel */
require_once 'excel/Classes/PHPExcel.php';


// Create new PHPExcel object

$db=new PDO("mysql:host=192.168.20.104;dbname=dati","root","102098hchab");
$sql="select * from table_user left join users on table_user.UID=users.uid";
// $datas=array(
//   array("a"=>1),
//   array("a"=>2),
//   array("a"=>9),
//   array("a"=>5),
//   array("a"=>3),
// );
// var_dump(arsort($datas),$datas);
// return false;
 $_GET['type']==''||$_GET['type']==1?$filterTag="scores":$filterTag=$_GET['type'];
try {
  $questions=$db->query($sql);
  $totalMonth=$db->query("select * from scores_month")->fetchAll(PDO::FETCH_ASSOC);
  $combineArray=array();
  $_resDates=$questions->fetchAll(PDO::FETCH_ASSOC);
  foreach ($_resDates as $key => &$v) {
      if($filterTag=='scores'){
        $v['tag']="当前月";
      }else{
          $v['tag']=$filterTag;
          foreach ($totalMonth as $value) {
            $_resDates[$key]['monthCount']=array();
            if($value['UID']==$v['UID'] && $value['month']==$filterTag){
              $v['scores']=$value['scoress'];
            }
          }
      }
  }
  unset($v);
  ExportExcel($_resDates);
    return false;
} catch (PDOException $e) {
  echo 0;
}

function ExportExcel($dataSource){

  $objPHPExcel = new PHPExcel();
  try {



  $objPHPExcel->getProperties()->setCreator("Maarten Balliauw")
  							 ->setLastModifiedBy("Maarten Balliauw")
  							 ->setTitle("Office 2007 XLSX Test Document")
  							 ->setSubject("Office 2007 XLSX Test Document")
  							 ->setDescription("Test document for Office 2007 XLSX, generated using PHP classes.")
  							 ->setKeywords("office 2007 openxml php")
  							 ->setCategory("Test result file");
  // Add some tag
  $objPHPExcel->setActiveSheetIndex(0)
              ->setCellValue('A1', 'id')
              ->setCellValue('B1', 'UID')
              ->setCellValue('C1', '姓名')
              ->setCellValue('D1', '微信昵称')
              ->setCellValue('E1', '激活时间')
              ->setCellValue('F1', '当前统计时间')
              ->setCellValue('G1', '积分')
              ->setCellValue('H1', '排名');
  foreach ($dataSource as $key => $value) {
    $index=strval($key+2);
    $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue('A'.$index, $value['id'])
                ->setCellValue('B'.$index, $value['UID'])
                ->setCellValue('C'.$index, $value['name'])
                ->setCellValue('D'.$index, $value['nickname'])
                ->setCellValue('E'.$index, $value['RegistTime'])
                ->setCellValue('F'.$index, $value['tag'])
                ->setCellValue('G'.$index, $value['scores'])
                ->setCellValue('H'.$index, "第".($key+1)."名");
  }


  // Rename worksheet
  define("NAME",uniqid());
  $objPHPExcel->getActiveSheet()->setTitle(NAME);
  // Set active sheet index to the first sheet, so Excel opens this as the first sheet
  $objPHPExcel->setActiveSheetIndex(0);

  // Redirect output to a client’s web browser (Excel5)
  header('Content-Type: application/vnd.ms-excel');
  header('Content-Disposition: attachment;filename='.NAME.".xls");
  header('Cache-Control: max-age=0');
  // If you're serving to IE 9, then the following may be needed
  header('Cache-Control: max-age=1');

  // If you're serving to IE over SSL, then the following may be needed
  header ('Expires: Mon, 26 Jul 1997 05:00:00 GMT'); // Date in the past
  header ('Last-Modified: '.gmdate('D, d M Y H:i:s').' GMT'); // always modified
  header ('Cache-Control: cache, must-revalidate'); // HTTP/1.1
  header ('Pragma: public'); // HTTP/1.0

  $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
  $objWriter->save('php://output');
} catch (PHPExcel_Exception $e) {
  var_dump($e);
}
}
