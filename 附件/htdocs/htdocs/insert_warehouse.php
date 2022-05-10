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
    $mid = $_POST["mid"];
    $pid = $_POST["pid"];
    $num = $_POST["num"];
    $sid = $_POST["sid"];
    $sql = 'call 入库登记("'.$mid.'","'.$pid.'","'.$num.'","'.$sid.'");';
    $res = mysqli_query($link, $sql);
    if ($res) {
      echo "入库成功!";
      if ($type == "1")
        echo '<meta http-equiv="refresh" content="1;url=main-staff.php">';
      else
        echo '<meta http-equiv="refresh" content="1;url=main-manager.php">';
    }  else {
      echo("错误描述: " . mysqli_error($link));
      if ($type == "1")
        echo '<a href="main-staff.php">返回</a>';
      else
        echo '<a href="main-manager.php">返回</a>';
    }
    
?>