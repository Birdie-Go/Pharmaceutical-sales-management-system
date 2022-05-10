<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <title>销售查询</title>
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
           <font style='color:#ffffff;background-color:transparent;font-size:30px;position:absolute;left:650px;top:110px'>销售查询</font>
        <dl>
        <form action="" method="post" name="indexf">
        <p align="center" style='position:absolute;left:450px;top:170px'>
			药名：
			<input type="text" name="fname">
            日期：
			<input type="text" name="dat">
            <input type="submit" value="查询" name="selsub">
		</p>
		<table align="center" border="1px" cellpadding="0px" width="1200px" style='position:absolute;left:150px;top:220px'>
			<tr><th>销售编号</th><th>药品编号</th><th>药品名称</th><th>单价</th><th>数量</th><th>总额</th><th>会员折扣</th><th>日期</th><th>会员姓名</th><th>员工姓名</th></tr>
			<?php
                $fp = fopen("login.txt", "r");
                $user = fgets($fp);
                $user = substr($user, 0, -1);
                $password = fgets($fp);
                $password = substr($password, 0, -1);
                $type = fgets($fp);
                fclose($fp);
                if ($type == "1")
                    echo '<input type="button" value="返回主界面" name="inbut" style="color:#ffffff;width:150px;height:50px;background-color:#1c6814;font-size:25px;position:absolute;left:1200px;top:110px" onClick="location.href = \'main-staff.php\'">';
                else
                    echo '<input type="button" value="返回主界面" name="inbut" style="color:#ffffff;width:150px;height:50px;background-color:#1c6814;font-size:25px;position:absolute;left:1200px;top:110px" onClick="location.href = \'main-manager.php\'">';
                echo '<font style="color:#1c6814;font-size:15px;width:120px;position:absolute;left:1320px;top:22px">登录用户:'.$user.'</font>';
                echo '<a href="index.html" style="color:#1c6814;font-size:15px;position:absolute;left:1320px;top:40px">登出</a>';

                $link = mysqli_connect('localhost', $user, $password, '医药销售管理系统', '3306');

				if(!$link) {
					exit('数据库连接失败!');
				}
                if (!empty($_POST["selsub"])) {
                    $dat = '%'.$_POST["dat"].'%';
                    $fname = '%'.$_POST["fname"].'%';
                    $sql = "CALL 销售查询('".$fname."','".$dat."');";
                    $res = mysqli_query($link, $sql);
                    while($row = mysqli_fetch_array($res)) {
                        echo '<tr align="center">';//居中
                        
                        echo "<td>$row[0]</td>";
                        echo "<td>$row[1]</td>";
                        echo "<td>$row[2]</td>";
                        echo "<td>$row[3]</td>";
                        echo "<td>$row[4]</td>";
                        echo "<td>$row[5]</td>";
                        echo "<td>$row[6]</td>";
                        echo "<td>$row[7]</td>";
                        echo "<td>$row[8]</td>";
                        echo "<td>$row[9]</td>";
                        echo '</tr>';
                    }
                }
			?>
		</table>
	</form>

      </div>
    </div> 
</body>

