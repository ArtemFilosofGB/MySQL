-- Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов. 
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

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


