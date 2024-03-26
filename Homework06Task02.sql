-- Выведите только четные числа от 1 до 10. Пример: 2,4,6,8,10

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
