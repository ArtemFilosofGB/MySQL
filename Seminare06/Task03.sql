-- Задача 3.  
-- Необходимо перебрать всех пользователей и тем пользователям, 
-- у которых дата рождения меньше определенной даты 
-- обновить дату  рождения на  сегодняшнюю дату.  (реализация с помощью цикла)
DROP PROCEDURE date_check;
DELIMITER //
CREATE PROCEDURE date_check(b_date DATE)
BEGIN
  DECLARE max_id INT;
  SET max_id = (SELECT max(user_id) FROM profiles);

  WHILE max_id > 0 DO
 -- SELECT max_id;
	  IF (b_date<(SELECT birthday FROM profiles WHERE user_id =max_id)) THEN
		UPDATE profiles SET birthday = NOW() WHERE user_id =max_id;
			
	  END IF;
    
    SET max_id = max_id - 1;
  END WHILE;
END //
DELIMITER ;

CALL date_check('1982-01-01');