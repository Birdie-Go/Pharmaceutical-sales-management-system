<?php
    $filename=date("Y-m-d_H-i-s")."-"."Backup".".sql";
    $tmpFile = (dirname(__FILE__))."\\".$filename;
    $sql = "mysqldump -uroot -p1234 --default-character-set=utf8 --all-databases > ".$tmpFile;
    exec($sql, $out, $return_val);
    if ($return_val == 0)  {
        echo "备份成功!";
        echo '<meta http-equiv="refresh" content="1;url=main-manager.php">';
    } else {
        echo "备份失败!cmd权限不足!<br>";
        echo "请手动在cmd中输入如下命令:<br>";
        echo $sql."<br>";
        echo '<a href="main-manager.php">返回</a>';
    }
?>