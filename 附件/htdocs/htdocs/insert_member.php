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
    $phone = $_POST["phone"];
    $sql = 'call 新增会员("'.$fname.'","'.$phone.'");';
    $res = mysqli_query($link, $sql);
    if ($res) {
      echo "注册成功!";
      if ($type == "1")
        echo '<meta http-equiv="refresh" content="1;url=main-staff.php">';
      else
        echo '<meta http-equiv="refresh" content="1;url=main-manager.php">';
    } else {
        echo "注册失败!";
      if ($type == "1")
        echo '<a href="main-staff.php">返回</a>';
      else
        echo '<a href="main-manager.php">返回</a>';
    }
    
?>