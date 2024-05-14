# Базы данных и SQL (семинары)
## Урок 6. SQL – Транзакции. Временные таблицы, управляющие конструкции, циклы

1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов. Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
```sql
DROP FUNCTION IF EXISTS sec_to_days;

DELIMITER //
CREATE FUNCTION sec_to_days(sec_inc INT)
	RETURNS CHAR(50) READS SQL DATA
	BEGIN
		DECLARE days INT;
		DECLARE hours INT;
		DECLARE minutes INT;
		DECLARE seconds INT;
		DECLARE str CHAR(50);
		SET days = TRUNCATE(sec_inc/(24*60*60),0);
		SET hours = TRUNCATE((sec_inc - days*24*60*60)/(60*60),0);
		SET minutes = TRUNCATE((sec_inc - days*24*60*60 - hours*60*60)/60,0);
		SET seconds = sec_inc - days*24*60*60 - hours*60*60-minutes*60;
        SET str = concat(days, ' days ',hours,' hours ', minutes, ' minutes ', seconds, ' seconds ');
        
    RETURN str;
    END //
DELIMITER ;
SELECT sec_to_days(123456); 
```

![](/pic/hw06_1.png)


2. Выведите только четные числа от 1 до 10. Пример: 2,4,6,8,10 

```sql
DROP FUNCTION IF EXISTS print_num;
DELIMITER //
CREATE FUNCTION print_num(num INT)
RETURNS CHAR(50) READS SQL DATA
BEGIN
	DECLARE counter INT;
	DECLARE result CHAR(50) DEFAULT "";
    SET counter = 0;

	WHILE counter < num DO
		SET counter = counter + 2;
        SET result = concat(result," ",counter);
	END WHILE;
RETURN result;
END //
DELIMITER ;
SELECT print_num(10); 
```

*Решение через процедуру*
```
DROP PROCEDURE IF EXISTS print_num;
DELIMITER //
CREATE PROCEDURE print_num(IN num INT)
BEGIN
  DECLARE counter INT DEFAULT 0;
  DECLARE result VARCHAR(50) DEFAULT "";

  WHILE counter < num DO
    SET counter = counter + 2;
    SET result = CONCAT(result, " ", counter);
  END WHILE;

  SELECT result;
END //
DELIMITER ;
```
Вызов:

```
CALL print_num(10);

```

![](/pic/hw06_2.png)

