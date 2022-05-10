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
    <font style='color:#ffffff;width:120px;height:50px;background-color:transparent;font-size:30px;position:absolute;left:200px;top:110px'>新增信息</font>
    <font style='color:#ffffff;width:120px;height:50px;background-color:transparent;font-size:30px;position:absolute;left:500px;top:110px'>查询信息</font>
    <font style='color:#ffffff;width:120px;height:50px;background-color:transparent;font-size:30px;position:absolute;left:800px;top:110px'>查看报表</font>
    <font style='color:#ffffff;width:120px;height:50px;background-color:transparent;font-size:30px;position:absolute;left:1100px;top:110px'>登记信息</font>
    <form action="" method="post" name="indexf">
    <input type="button" value="供应商" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:200px;top:210px' onClick="location.href = 'insert_supplier.html'">
		<input type="button" value="会员" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:200px;top:280px' onClick="location.href = 'insert_member.html'">
		<input type="button" value="药品" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:200px;top:350px' onClick="location.href = 'insert_drug.html'">
		<input type="button" value="用户注册" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:200px;top:420px' onClick="location.href = 'insert_user.html'">

    <input type="button" value="财务统计" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:500px;top:210px' onClick="location.href = 'calc_finace.php'">
		<input type="button" value="库存查询" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:500px;top:280px' onClick="location.href = 'query_warehouse.php'">
		<input type="button" value="入库查询" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:500px;top:350px' onClick="location.href = 'query_in.php'">
		<input type="button" value="财务查询" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:500px;top:420px' onClick="location.href = 'query_finace.php'">
		<input type="button" value="销售查询" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:500px;top:490px' onClick="location.href = 'query_sale.php'">
		<input type="button" value="退货查询" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:500px;top:560px' onClick="location.href = 'query_return.php'">
		<input type="button" value="供应商" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:500px;top:630px' onClick="location.href = 'query_supplier.php'">
		<input type="button" value="会员查询" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:500px;top:700px' onClick="location.href = 'query_member.php'">

		<input type="button" value="库存盘点" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:800px;top:210px' onClick="location.href = 'all_warehouse.php'">
		<input type="button" value="入库报表" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:800px;top:280px' onClick="location.href = 'report_in.php'">
		<input type="button" value="库存报表" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:800px;top:350px' onClick="location.href = 'report_warehouse.php'">
		<input type="button" value="财务报表" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:800px;top:420px' onClick="location.href = 'report_finace.php'">
		<input type="button" value="销售报表" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:800px;top:490px' onClick="location.href = 'report_sale.php'">
		<input type="button" value="退货记录" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:800px;top:560px' onClick="location.href = 'report_return.php'">
		<input type="button" value="员工信息" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:800px;top:630px' onClick="location.href = 'all_user.php'">
		<input type="button" value="收支记录" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:800px;top:700px' onClick="location.href = 'all_finace.php'">

		<input type="button" value="入库登记" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:1100px;top:210px' onClick="location.href = 'insert_warehouse.html'">
		<input type="button" value="销售登记" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:1100px;top:280px' onClick="location.href = 'insert_sale.html'">
		<input type="button" value="退货登记" name="inbut" style='color:#000000;width:120px;height:50px;background-color:transparent;font-size:25px;position:absolute;left:1100px;top:350px' onClick="location.href = 'insert_return.html'">
		
    <input type="button" value="系统维护" name="inbut" style='color:#ffffff;width:120px;height:50px;background-color:#1c6814;font-size:25px;position:absolute;left:1300px;top:700px' onClick="location.href = 'save.php'">
    </form>
</body>

</html>
