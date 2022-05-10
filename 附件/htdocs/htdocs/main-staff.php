<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>医药销售管理系统</title>
  <meta name="keywords" content="">
  <meta name="description" content="">
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="apple-mobile-web-app-status-bar-style" content="black"> 
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="format-detection" content="telephone=no">
  <meta HTTP-EQUIV="pragma" CONTENT="no-cache"> 
  <meta HTTP-EQUIV="Cache-Control" CONTENT="no-store, must-revalidate"> 
  <meta HTTP-EQUIV="expires" CONTENT="0">
  <style>
    body{
      font: 16px arial,'Microsoft Yahei','Hiragino Sans GB',sans-serif;
      background-image: url(/image/back.png);
      background-size: cover;
    }
    h1{
      margin: 0;
      color:#1c6814;
      font-size: 45px;
    }
  </style>
</head>

<body>
	<h1 align="center">医药销售管理系统</h1>
    <?php
        $fp = fopen("login.txt", "r");
        $user = fgets($fp);
        $user = substr($user, 0, -1);
        $password = fgets($fp);
        $password = substr($password, 0, -1);
        $type = fgets($fp);
        fclose($fp);
        echo '<font style="color:#1c6814;font-size:15px;width:120px;position:absolute;left:1320px;top:22px">登录用户:'.$user.'</font>';
        echo '<a href="index.html" style="color:#1c6814;font-size:15px;position:absolute;left:1320px;top:40px">登出</a>';
    ?>  
    <font style='color:#ffffff;width:120px;height:50px;background-color:transparent;font-size:30px;position:absolute;left:650px;top:110px'>登记信息</font>
    <form action="" method="post" name="indexf">
		<input type="button" value="入库登记" name="inbut" style='color:#ffffff;width:500px;height:150px;background-color:#1c6814;font-size:50px;position:absolute;left:470px;top:220px' onClick="location.href = 'insert_warehouse.html'">
		<input type="button" value="销售登记" name="inbut" style='color:#ffffff;width:500px;height:150px;background-color:#1c6814;font-size:50px;position:absolute;left:470px;top:400px' onClick="location.href = 'insert_sale.html'">
		<input type="button" value="退货登记" name="inbut" style='color:#ffffff;width:500px;height:150px;background-color:#1c6814;font-size:50px;position:absolute;left:470px;top:580px' onClick="location.href = 'insert_return.html'">
    </form>
</body>
</html>
