<?php
    $fp = fopen("login.txt", "r");
    $user = fgets($fp);
    $user = substr($user, 0, -1);
    $password = fgets($fp);
    $password = substr($password, 0, -1);
    $type = fgets($fp);
    fclose($fp);

    $link = mysqli_connect('localhost', $user, $password, '医药销售管理系统', '3306');
    if(!$link) {
        exit('数据库连接失败!');
    }
    $fname = $_POST["fname"];
    $password = $_POST["password"];
    $tp = $_POST["tp"];
    $realname = $_POST["realname"];
    $phone = $_POST["phone"];
    $sql = 'call 用户注册("'.$fname.'","'.$password.'","'.$tp.'","'.$realname.'","'.$phone.'");';
    $res = mysqli_query($link, $sql);
    $com = "mysqladmin -u".$fname." -p1234 password ".$password;
    exec($com, $out, $return_val);
    if ($res) {
      echo "添加成功!<br>";
      if ($return_val != 0) {
        echo "设置密码失败!cmd权限不足!<br>默认密码1234。<br>";
        echo "请在cmd执行以下命令修改密码:<br>";
        echo $com."<br>";
        if ($type == "1")
          echo '<a href="main-staff.php">返回</a>';
        else
          echo '<a href="main-manager.php">返回</a>';
      } else {
        if ($type == "1")
          echo '<meta http-equiv="refresh" content="1;url=main-staff.php">';
        else
          echo '<meta http-equiv="refresh" content="1;url=main-manager.php">';
      }
    }  else {
      echo("错误描述: " . mysqli_error($link));
      if ($type == "1")
        echo '<a href="main-staff.php">返回</a>';
      else
        echo '<a href="main-manager.php">返回</a>';
    }
    
?>