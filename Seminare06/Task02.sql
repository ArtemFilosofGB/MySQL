-- Задача 2.  
-- Создание функции, вычисляющей коэффициент популярности пользователя 
-- (по заявкам на дружбу – таблица friend_requests)
SELECT * FROM lesson_4.friend_requests;

DROP FUNCTION IF EXISTS top_users;

DELIMITER //
CREATE FUNCTION top_users(find_id INT)
	RETURNS FLOAT READS SQL DATA

	BEGIN
    DECLARE rq_from INT;
    DECLARE rq_to INT;
    SET rq_to = (SELECT COUNT(*) FROM friend_requests WHERE target_user_id = find_id);
    SET rq_from = (SELECT COUNT(*) FROM friend_requests WHERE initiator_user_id = find_id);
    
    RETURN rq_to/rq_from;
    END //
DELIMITER ;

SELECT top_users(1);