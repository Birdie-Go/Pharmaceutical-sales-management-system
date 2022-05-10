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
    $sid = $_POST["sid"];
    $cid = $_POST["cid"];
    $bp = $_POST["bp"];
    $tp = $_POST["tp"];
    $im = $_POST["im"];
    $pm = $_POST["pm"];
    $discount = $_POST["discount"];
    $pac = $_POST["pac"];
    $bd = $_POST["bd"];
    $ddl = $_POST["ddl"];
    $sql = 'call 新增药品("'.$fname.'","'.$sid.'","'.$cid.'","'.$bp.'","'.$tp.'","'.$im.'","'.$pm.'","'.$discount.'","'.$pac.'","'.$bd.'","'.$ddl.'");';
    $res = mysqli_query($link, $sql);
    if ($res) {
      echo "添加成功!";
      if ($type == "1")
        echo '<meta http-equiv="refresh" content="1;url=main-staff.php">';
      else
        echo '<meta http-equiv="refresh" content="1;url=main-manager.php">';
    }  else {
        echo "添加失败!";
      if ($type == "1")
        echo '<a href="main-staff.php">返回</a>';
      else
        echo '<a href="main-manager.php">返回</a>';
    }
    
?>