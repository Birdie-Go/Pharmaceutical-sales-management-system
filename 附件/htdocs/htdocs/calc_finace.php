<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <title>财务统计</title>
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

    </style>
</head>

<body>
  <h1 align="center" style="margin:0;color:#1c6814;font-size:45px;">医药销售管理系统</h1>
  <div class="content">
      <div>
           <font style='color:#ffffff;background-color:transparent;font-size:30px;position:absolute;left:650px;top:110px'>财务统计</font>
        <dl>
        <form action="" method="post" name="indexf">
        <p align="center" style='position:absolute;left:550px;top:170px'>
			查询日期：
			<input type="text" name="dat"><input type="submit" value="查询" name="selsub">
		</p>
		<table align="center" border="1px" cellpadding="0px" width="1200px" style='position:absolute;left:150px;top:220px'>
			<tr><th>数目</th><th>盈亏</th><th>支出</th><th>收入</th></tr>
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
                if ($type == "1")
                    echo '<input type="button" value="返回主界面" name="inbut" style="color:#ffffff;width:150px;height:50px;background-color:#1c6814;font-size:25px;position:absolute;left:1200px;top:110px" onClick="location.href = \'main-staff.php\'">';
                else
                    echo '<input type="button" value="返回主界面" name="inbut" style="color:#ffffff;width:150px;height:50px;background-color:#1c6814;font-size:25px;position:absolute;left:1200px;top:110px" onClick="location.href = \'main-manager.php\'">';
    
                $link = mysqli_connect('localhost', $user, $password, '医药销售管理系统', '3306');

				if(!$link) {
					exit('数据库连接失败!');
				}
                if (!empty($_POST["selsub"])) {
                    $dat = $_POST["dat"];
                    if (empty($dat))
                        $dat = "";
                    $sql = "CALL 财务统计('%".$dat."%');";
                    $res = mysqli_query($link, $sql);
                    while($row = mysqli_fetch_array($res)) {
                        echo '<tr align="center">';//居中
                        
                        echo "<td>$row[0]</td>";
                        echo "<td>$row[1]</td>";
                        echo "<td>$row[2]</td>";
                        echo "<td>$row[3]</td>";
                        echo '</tr>';
                    }
                }
			?>
		</table>
	</form>

      </div>
    </div> 
</body>

