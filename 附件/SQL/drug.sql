DROP DATABASE IF EXISTS 医药销售管理系统;
CREATE DATABASE 医药销售管理系统;
USE 医药销售管理系统;

CREATE TABLE `供应商`(
    供应商编号     INT AUTO_INCREMENT,
    供应商名称     VARCHAR(50) NOT NULL,
    联系人         VARCHAR(50) NOT NULL,
    联系方式       VARCHAR(50) NOT NULL,
    所在地         VARCHAR(50),
	PRIMARY KEY (`供应商编号`)
);

CREATE TABLE `药品`(
    药品编号    INT AUTO_INCREMENT,
    药品名称    VARCHAR(50) NOT NULL,
    生产批号    VARCHAR(50),
    产地        VARCHAR(50),
    所属类别    VARCHAR(50),
    进价        DECIMAL(10,2) NOT NULL,
    单价        DECIMAL(10,2) NOT NULL,
    会员折扣    DECIMAL(3,2) DEFAULT 1,
    库存        INT NOT NULL,
    包装规格    VARCHAR(50),
    生产日期    VARCHAR(50) NOT NULL,
    有效期      VARCHAR(50) NOT NULL,
	PRIMARY KEY (`药品编号`)
);

CREATE TABLE `会员`(
    会员编号      INT AUTO_INCREMENT,
    会员姓名      VARCHAR(50),
    联系方式      VARCHAR(50) NOT NULL,
	PRIMARY KEY (`会员编号`),
    INDEX `联系方式索引` (`联系方式`)
);

-- 类别为1代表员工，2代表经理
CREATE TABLE `登录用户`(
    用户编号         INT AUTO_INCREMENT,
    用户名           VARCHAR(50) NOT NULL UNIQUE,
    密码            VARCHAR(50) NOT NULL,
    类别            INT NOT NULL,
	PRIMARY KEY (`用户编号`),
    UNIQUE (`用户名`)
);

CREATE TABLE `经理`(
    经理编号      INT AUTO_INCREMENT,
	职位          VARCHAR(50) DEFAULT "经理",
    PRIMARY KEY (`经理编号`)
);

CREATE TABLE `员工`(
    员工编号      INT AUTO_INCREMENT,
    员工姓名      VARCHAR(50) NOT NULL,
    联系电话      VARCHAR(50) NOT NULL,
	PRIMARY KEY(员工编号)
);

CREATE TABLE `财政收支` (
	收支编号 INT AUTO_INCREMENT,
	数量			 INT,
	日期			 DATETIME NOT NULL,
	总额			 DECIMAL(10,2) NOT NULL,
	类型			 VARCHAR(50)  NOT NULL,
	PRIMARY KEY (`收支编号`)
);

CREATE TABLE `登录`(
    员工编号 INT NOT NULL,
    用户编号 INT NOT NULL,
    PRIMARY KEY (`员工编号`,`用户编号`),
    FOREIGN KEY (`员工编号`) REFERENCES `医药销售管理系统`.`员工` (`员工编号`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (`用户编号`) REFERENCES `医药销售管理系统`.`登录用户` (`用户编号`)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE `晋升`(
    员工编号 INT NOT NULL,
    经理编号 INT NOT NULL,
    PRIMARY KEY (`员工编号`,`经理编号`),
    FOREIGN KEY (`员工编号`) REFERENCES `医药销售管理系统`.`员工` (`员工编号`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (`经理编号`) REFERENCES `医药销售管理系统`.`经理` (`经理编号`)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE `可供应`(
    药品编号 INT NOT NULL,
    供应商编号 INT NOT NULL,
    PRIMARY KEY (`药品编号`,`供应商编号`),
    FOREIGN KEY (`药品编号`) REFERENCES `医药销售管理系统`.`药品` (`药品编号`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (`供应商编号`) REFERENCES `医药销售管理系统`.`供应商` (`供应商编号`)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE `操作员` (
    收支编号 INT NOT NULL,
    员工编号 INT NOT NULL,
    PRIMARY KEY (`收支编号`),
    FOREIGN KEY (`收支编号`) REFERENCES `医药销售管理系统`.`财政收支` (`收支编号`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`员工编号`) REFERENCES `医药销售管理系统`.`员工` (`员工编号`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE  `销售` (
    收支编号 INT NOT NULL,
    会员编号 INT NOT NULL,
    PRIMARY KEY (`收支编号`),
    FOREIGN KEY (`收支编号`) REFERENCES `医药销售管理系统`.`财政收支` (`收支编号`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`会员编号`) REFERENCES `医药销售管理系统`.`会员` (`会员编号`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    INDEX `收支编号索引` (`收支编号`)
);

CREATE TABLE `退货` (
    收支编号 INT NOT NULL,
    会员编号 INT NOT NULL,
    销售编号 INT NOT NULL UNIQUE,
    PRIMARY KEY (`收支编号`),
    FOREIGN KEY (`收支编号`) REFERENCES `医药销售管理系统`.`财政收支` (`收支编号`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`会员编号`) REFERENCES `医药销售管理系统`.`会员` (`会员编号`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY ( `销售编号`) REFERENCES `医药销售管理系统`. `销售` (`收支编号`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    INDEX `收支编号索引` (`收支编号`)
);

CREATE TABLE `商品`(
	收支编号 INT NOT NULL,
    药品编号 INT NOT NULL,
    PRIMARY KEY (`收支编号`,`药品编号`),
    FOREIGN KEY (`收支编号`) REFERENCES `医药销售管理系统`.`财政收支` (`收支编号`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`药品编号`) REFERENCES `医药销售管理系统`.`药品` (`药品编号`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    INDEX `收支编号索引` (`收支编号`)
);

DROP PROCEDURE IF EXISTS 新增供应商;
delimiter //
CREATE PROCEDURE 新增供应商 (IN name varchar(50),
                       IN chargeman varchar(50),
                       IN phone varchar(50),
                       IN address varchar(50))
BEGIN
    INSERT INTO 供应商 (供应商名称, 联系人, 联系方式, 所在地) VALUES(name, chargeman, phone, address);
END//
delimiter ;

DROP PROCEDURE IF EXISTS 新增会员;
delimiter //
CREATE PROCEDURE 新增会员 (IN name varchar(50),
                       IN phone varchar(50))
BEGIN
    INSERT INTO 会员 (会员姓名, 联系方式) VALUES(name, phone);
END//
delimiter ;

DROP PROCEDURE IF EXISTS 新增药品;
delimiter //
CREATE PROCEDURE 新增药品 (IN name varchar(50),
                       IN sid varchar(50),
                       IN cid INT,
                       IN bp varchar(50),
                       IN type varchar(50),
                       IN im varchar(50),
                       IN pm varchar(50),
                       IN discount DECIMAL(3,2),
                       IN pac varchar(50),
                       IN bd varchar(50),
                       IN ddl varchar(50))
BEGIN
    INSERT INTO 药品 (药品名称 , 生产批号, 产地, 所属类别, 进价, 单价, 会员折扣, 库存, 包装规格, 生产日期, 有效期) VALUES(name, cid, bp, type, im, pm, discount, 0, pac, bd, ddl);
    SET @mid = 0 ;
    SELECT MAX(药品编号) INTO @mid FROM 药品;
    INSERT INTO 可供应 (药品编号,供应商编号) VALUES ( @mid,sid) ;
END//
delimiter ;


DROP PROCEDURE IF EXISTS 新增登录用户;
delimiter //
CREATE PROCEDURE 新增登录用户 (IN name varchar(50),
                       IN pw varchar(50),
                       IN type INT,
                       IN realname varchar(50),
                       IN phone varchar(50))
BEGIN
	INSERT INTO 登录用户 (用户名, 密码, 类别) VALUES(name, pw, type);
    SET @id = 0 , @pid = 0 ;
	SELECT 用户编号 INTO @id FROM 登录用户 WHERE 用户名 = name ;
    INSERT INTO 员工 (员工姓名, 联系电话) VALUES(realname, phone);
	SELECT MAX(员工编号) INTO @pid FROM 员工 ;
    INSERT INTO 登录 (员工编号, 用户编号) VALUES(@pid , @id);
    IF type = 2 THEN
    	INSERT INTO 经理 (职位) VALUES("经理");
        Set @ma_id = 0 ;
        SELECT MAX(经理编号) INTO @ma_id FROM 经理 ;
        INSERT INTO 晋升 (经理编号,员工编号) VALUES(@ma_id,@pid);
    END IF;
END//
delimiter ;

DROP PROCEDURE IF EXISTS 用户注册;
delimiter //
CREATE PROCEDURE 用户注册 (IN name varchar(50),
                       IN pw varchar(50),
                       IN type INT,
                       IN realname varchar(50),
                       IN phone varchar(50))
BEGIN
    call 新增登录用户(name,pw,type,realname,phone) ;
    create user 'temp'@'localhost' identified by '1234';
    update mysql.user set user = name where user ='temp';
    FLUSH PRIVILEGES; 
END//
delimiter ;


DROP PROCEDURE IF EXISTS 入库登记;
delimiter //
CREATE PROCEDURE 入库登记 (IN mid INT,
                       IN pid INT,
                       IN num INT,
                       IN gid INT)
BEGIN
    SET @mid_if = 0 , @per_if = 0 , @gid_if = 0 , @inn = 0 ;
    SELECT count(*) ,进价 INTO @mid_if, @inn FROM 药品 WHERE 药品编号 = mid group by 药品编号;
    SELECT count(*) INTO @per_if FROM 员工 WHERE 员工编号 = pid GROUP BY 员工编号 ;
    SELECT count(*) INTO @gid_if FROM 供应商 WHERE 供应商编号 = gid GROUP BY 供应商编号 ;
    IF num <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '入库数量不合理' ;
    ELSEIF @mid_if = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '该药品不存在' ;
    ELSEIF @per_if = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '该员工编号不存在' ;
    ELSEIF @gid_if = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '该供应商不存在' ;
    ELSE
        INSERT INTO 财政收支 (数量, 日期, 总额, 类型) VALUES(num, NOW(), @inn * num *(-1) , '入库');
        SET @id = 0 ; 
        SELECT MAX(收支编号) INTO @id FROM 财政收支;
        UPDATE 药品 SET 库存 = 库存+num where 药品.药品编号= mid ;
        INSERT INTO 商品 (药品编号, 收支编号) VALUES(mid, @id);
        INSERT INTO 操作员 (员工编号, 收支编号) VALUES(pid, @id);

    END IF;
END//
delimiter ;

DROP PROCEDURE IF EXISTS 销售登记;
delimiter //
CREATE PROCEDURE 销售登记 (IN mid INT,
                       IN pid INT,
                       IN num INT,
                       IN gid INT)
BEGIN
    SET @inn = 0 ,@dis = 0 , @have = 0 ,@gid_if = 0 , @mid_if = 0 ,@per_if = 0 ;
	SELECT 单价, 会员折扣 , 库存 , count(*) INTO @inn, @dis , @have , @mid_if FROM 药品 WHERE 药品编号 = mid GROUP BY 药品编号 ;
    SELECT count(*) INTO @gid_if FROM 会员 WHERE 会员编号 = gid GROUP BY 会员编号 ;
    SELECT count(*) INTO @per_if FROM 员工 WHERE 员工编号 = pid GROUP BY 员工编号 ;
    IF @have < num THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '库存不足' ;
    ELSEIF @gid_if = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '会员编号不存在' ;
    ELSEIF @mid_if = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '药品编号不存在' ;
    ELSEIF @per_if = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '员工编号不存在' ;
    ELSE
        INSERT INTO 财政收支 (数量, 日期, 总额, 类型) VALUES(num, NOW(), @dis * num * @inn, '销售');
        SET @id = 0 ;
        SELECT MAX(收支编号) INTO @id FROM 财政收支;
        UPDATE 药品 SET 库存 = 库存-num where 药品.药品编号= mid ;
        INSERT INTO 商品 (药品编号, 收支编号) VALUES(mid, @id);
        INSERT INTO 操作员 (员工编号, 收支编号) VALUES(pid, @id);
        INSERT INTO 销售 (会员编号, 收支编号) VALUES(gid, @id);
    END IF ;
END//
delimiter ;

DROP PROCEDURE IF EXISTS 退货登记;
delimiter //
CREATE PROCEDURE 退货登记 (IN sid INT,
                      IN pid INT)
BEGIN
    SET @exist_if = 0 ,@mid = 0 ,@num = 0 ,@tot = 0 ,@per_if = 0 ,@unique_if = 0 ,@gid=0 ;
    SELECT count(*),会员编号 INTO @exist_if , @gid FROM 销售 WHERE 收支编号 = sid GROUP BY 收支编号 ; -- 检查是否有此销售记录
    SELECT count(*) INTO @unique_if FROM 退货 WHERE 销售编号 = sid GROUP BY 销售编号 ; -- 检查是否退货过
    SELECT count(*) INTO @per_if FROM 员工 WHERE 员工编号 = pid GROUP BY 员工编号 ; -- 检查是否有此员工编号

    IF @exist_if <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '不存在此销售记录' ;
    ELSEIF @per_if = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '员工编号不存在' ;
    ELSEIF @unique_if >= 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '该销售已退货' ;
    ELSE
        SELECT 药品编号 INTO @mid FROM 商品 WHERE 收支编号 = sid;
        SELECT 数量,总额 INTO @num ,@tot FROM 财政收支 WHERE 收支编号 = sid;
        INSERT INTO 财政收支 (数量 , 日期 , 总额, 类型 ) VALUES( @num, NOW(), @tot, '退货');
        SET @id = 0 ;
        SELECT 	MAX(收支编号) INTO @id FROM 财政收支;
        UPDATE 药品 SET 库存 = 库存+@num where 药品.药品编号= @mid ;
        INSERT INTO 退货 (会员编号 , 销售编号 , 收支编号) VALUES( @gid , sid , @id);
        INSERT INTO 商品 (药品编号 , 收支编号) VALUES( @mid, @id);
        INSERT INTO 操作员 (员工编号 , 收支编号) VALUES( pid, @id);
        
    END IF ;
END//
delimiter ;

DROP VIEW IF EXISTS 库存盘点; 
CREATE VIEW 库存盘点 AS
    SELECT distinct 药品.*, 供应商.供应商名称, 供应商.联系人, 供应商.联系方式
    FROM 药品 natural join 可供应 natural join 供应商
    order by 药品.药品编号;

DROP VIEW IF EXISTS 入库报表; 
CREATE VIEW 入库报表 AS
    SELECT 财政收支.收支编号, 药品名称, 供应商名称, 员工姓名, 数量, 日期, 总额 ,财政收支.类型
    FROM 财政收支 , 商品 natural join 药品 natural join 可供应 natural join 供应商 , 操作员 natural join 员工 
    where 财政收支.收支编号 = 商品.收支编号
      and 财政收支.收支编号 = 操作员.收支编号
    order BY  收支编号, 财政收支.日期;


-- 加个可以查看当时库存的。
DROP VIEW IF EXISTS 库存报表; 
CREATE VIEW 库存报表 AS
    SELECT 财政收支.收支编号,财政收支.类型, 药品.药品编号, 药品.药品名称, 财政收支.数量 as 交易数量, 财政收支.日期 , 员工.员工姓名
    FROM 财政收支 , 商品 natural join 药品 natural join 可供应 natural join 供应商 , 操作员 natural join 员工
    where 财政收支.收支编号 = 商品.收支编号
      and 财政收支.收支编号 = 操作员.收支编号
        order BY 财政收支.日期 , 收支编号;

DROP VIEW IF EXISTS 财务报表; 
CREATE VIEW 财务报表 AS
    SELECT 财政收支.收支编号, 财政收支.类型, 药品.药品编号, 药品.药品名称, 财政收支.数量, 财政收支.总额, 财政收支.日期, 药品.库存, 员工.员工姓名
    FROM 财政收支 , 商品 natural join 药品 natural join 可供应 natural join 供应商 , 操作员 natural join 员工
    WHERE 财政收支.收支编号 = 商品.收支编号
    	AND 财政收支.收支编号 = 操作员.收支编号 
        order BY 财政收支.收支编号;

DROP VIEW IF EXISTS 收支记录;
CREATE VIEW 收支记录 AS
    SELECT 财政收支.收支编号,类型, 药品名称, 数量, 总额, 日期
    FROM 财政收支 , 商品 natural join 药品 natural join 可供应 natural join 供应商
    WHERE 财政收支.收支编号 = 商品.收支编号
        order BY 财政收支.收支编号;

DROP VIEW IF EXISTS 销售报表; 
CREATE VIEW 销售报表 AS
    SELECT 销售.收支编号 , 药品.药品编号, 药品名称, 单价, 数量, 会员折扣, 总额, 日期 , 会员姓名, 员工姓名
    FROM 财政收支 , 商品 natural join 药品 , 操作员 natural join 员工 , 会员 natural join 销售
    WHERE 财政收支.收支编号 = 商品.收支编号
    	AND 财政收支.收支编号 = 操作员.收支编号 
        AND 财政收支.收支编号 = 销售.收支编号 
        order BY 财政收支.收支编号;

-- 删掉了退货编号
DROP VIEW IF EXISTS 退货记录;
CREATE VIEW 退货记录 AS
    SELECT 财政收支.收支编号, 退货.销售编号, 药品名称, 数量, 总额, 日期, 会员姓名, 员工姓名
    FROM 财政收支 , 商品 natural join 药品 , 操作员 natural join 员工 ,会员 natural join 退货
    WHERE 财政收支.收支编号 = 商品.收支编号
    	AND 财政收支.收支编号 = 操作员.收支编号 
        AND 财政收支.收支编号 = 退货.收支编号 
        order BY 财政收支.收支编号;

DROP VIEW IF EXISTS 员工信息;
CREATE VIEW 员工信息 AS
    SELECT 用户名, 员工.*
    FROM 员工 NATURAL JOIN 登录 NATURAL JOIN 登录用户;

DROP PROCEDURE IF EXISTS 财务统计;
delimiter //
CREATE PROCEDURE 财务统计 (IN date_limit varchar(50))
BEGIN
    SELECT
    	COUNT(*) AS `数目`,
    	SUM(`总额`) AS `盈亏`, 
    	(SELECT sum(`总额`) FROM `财政收支` WHERE `总额` < 0 AND `日期` LIKE date_limit) AS `支出`, 
    	(SELECT sum(`总额`) FROM `财政收支` WHERE `总额` >= 0 AND `日期` LIKE date_limit) AS `收入` 
    FROM `财政收支` WHERE `日期` LIKE date_limit;
END//
delimiter ;

DROP PROCEDURE IF EXISTS 库存查询;
delimiter //
CREATE PROCEDURE 库存查询 (IN name_drug varchar(50))
BEGIN
    SELECT distinct 药品名称 as 药品名称, 供应商名称, 生产批号, 产地, 所属类别, 单价, 会员折扣, 库存, 有效期
    FROM 商品 natural join 药品 natural join 可供应 natural join 供应商
    WHERE `药品名称` LIKE name_drug order by 药品编号;
END//
delimiter ;

DROP PROCEDURE IF EXISTS 入库查询;
delimiter //
CREATE PROCEDURE 入库查询 (IN name_drug varchar(50), IN date_limit varchar(50))
BEGIN
    SELECT 财政收支.收支编号, 药品名称, 供应商名称, 员工姓名, 数量, 日期, 总额 
    FROM 财政收支 , 商品 natural join 药品 natural join 可供应 natural join 供应商 , 操作员 natural join 员工 
    where 财政收支.收支编号 = 商品.收支编号
      and 财政收支.收支编号 = 操作员.收支编号
      and 药品名称 LIKE name_drug
      and 日期 LIKE date_limit
      and 类型 = "入库"
    order BY 财政收支.日期 , 收支编号;
END//
delimiter ;

DROP PROCEDURE IF EXISTS 财务查询;
delimiter //
CREATE PROCEDURE 财务查询 (IN name_drug varchar(50), IN date_limit varchar(50))
BEGIN
    SELECT 财政收支.收支编号, 类型, 药品.药品编号, 药品名称, 数量, 总额, 日期, 员工姓名
    FROM 财政收支 , 商品 natural join 药品 natural join 可供应 natural join 供应商 , 操作员 natural join 员工 
    WHERE `药品名称` LIKE name_drug
        AND `日期` LIKE date_limit
    	AND 财政收支.收支编号 = 商品.收支编号
        AND 财政收支.收支编号 = 操作员.收支编号
        order BY 收支编号;
END//
delimiter ;

DROP PROCEDURE IF EXISTS 销售查询;
delimiter //
CREATE PROCEDURE 销售查询 (IN name_drug varchar(50), IN date_limit varchar(50))
BEGIN
    SELECT 财政收支.收支编号, 药品.药品编号, 药品名称, 单价, 数量, 会员折扣, 总额, 日期 , 会员姓名, 员工姓名
    FROM 财政收支 , 商品 natural join 药品 natural join 可供应 natural join 供应商 , 操作员 natural join 员工 , 销售 natural join 会员
    WHERE `药品名称` LIKE name_drug
        AND `日期` LIKE date_limit
    	AND 财政收支.收支编号 = 销售.收支编号
    	AND 财政收支.收支编号 = 商品.收支编号
        AND 财政收支.收支编号 = 操作员.收支编号
        order BY 收支编号;
END//
delimiter ;

DROP PROCEDURE IF EXISTS 退货查询;
delimiter //
CREATE PROCEDURE 退货查询 (IN name_drug varchar(50), IN date_limit varchar(50))
BEGIN
    SELECT 财政收支.收支编号, 退货.销售编号, 药品名称, 数量, 总额, 日期, 会员姓名, 员工姓名
    FROM 财政收支 , 商品 natural join 药品 natural join 可供应 natural join 供应商 , 操作员 natural join 员工 , 退货 natural join 会员
    WHERE `药品名称` LIKE name_drug
        AND `日期` LIKE date_limit
    	AND 财政收支.收支编号 = 退货.收支编号
    	AND 财政收支.收支编号 = 商品.收支编号
        AND 财政收支.收支编号 = 操作员.收支编号
        order BY 收支编号;
END//
delimiter ;

-- 查询基本信息
DROP PROCEDURE IF EXISTS 供应商查询;
delimiter //
CREATE PROCEDURE 供应商查询 (IN name varchar(50))
BEGIN
    SELECT 供应商.*, 药品名称, 单价, 会员折扣, 数量, 总额, 日期
    FROM 财政收支 , 商品 natural join 药品 natural join 可供应 natural join 供应商
    WHERE 供应商名称 LIKE name
    	AND 财政收支.收支编号 = 商品.收支编号 
        order BY 供应商编号;
END//
delimiter ;

DROP PROCEDURE IF EXISTS 会员查询;
delimiter //
CREATE PROCEDURE 会员查询 (IN phone varchar(50))
BEGIN
    SELECT 会员.*, 药品名称, 单价, 会员折扣, 数量, 总额, 日期, 员工姓名
    FROM 财政收支 , 商品 natural join 药品 natural join 可供应 natural join 供应商,操作员 natural join 员工 , 销售 natural join 会员
    WHERE `会员`.`联系方式` = phone
    	AND 财政收支.收支编号 = 销售.收支编号
    	AND 财政收支.收支编号 = 商品.收支编号
        AND 财政收支.收支编号 = 操作员.收支编号
        order BY 会员编号;
END//
delimiter ;

DROP TRIGGER IF EXISTS 药品更新限制;
delimiter //
CREATE TRIGGER 药品更新限制 BEFORE UPDATE ON 药品
for each ROW
BEGIN
    IF new.库存 < 0 THEN
    	DELETE FROM 药品
    	WHERE 药品编号 = new.药品编号;  
    END IF;
END //
delimiter ;

DROP TRIGGER IF EXISTS 药品入库限制;
delimiter //
CREATE TRIGGER 药品入库限制 BEFORE INSERT ON 药品
for each ROW
BEGIN
    IF new.库存 < 0 OR new.单价 < 0 OR new.进价 < 0 OR new.会员折扣 > 1 OR new.会员折扣 < 0 THEN
    	DELETE FROM 药品
    	WHERE 药品编号 = new.药品编号;
    END IF;
END //
delimiter ;