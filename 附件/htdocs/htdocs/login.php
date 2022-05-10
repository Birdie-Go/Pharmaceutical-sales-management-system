<?php
    $link = mysqli_connect('localhost', 'root', '1234', '医药销售管理系统', '3306');
    if(!$link) {
        exit('数据库连接失败!');
    }
    $fname = $_POST["fname"];
    $password = $_POST["password"];
    $res = mysqli_query($link, "SELECT 类别
                                FROM 登录用户 
                                WHERE 用户名 = '$fname' AND 密码 = '$password'");
    $flag = 0;
    while ($row = mysqli_fetch_array($res)) {
        echo '登录成功';
        $flag = 1;
        $fp = fopen("login.txt", "w");
        fwrite($fp, $fname."\n");
        fwrite($fp, $password."\n");
        fwrite($fp, $row[0]."\n");
        fclose($fp);
        if ($row[0] == 1)
            echo '<meta http-equiv="refresh" content="0;url=main-staff.php">';
        else
            echo '<meta http-equiv="refresh" content="0;url=main-manager.php">';
    }
    if ($flag == 0) {
        echo "登录失败(账号或密码错误)";
        echo '<a href="index.html">返回</a>';
    }
    
?>