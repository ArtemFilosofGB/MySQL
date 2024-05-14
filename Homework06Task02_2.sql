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

CALL print_num(10);