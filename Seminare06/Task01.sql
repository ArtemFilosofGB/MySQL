-- Задача 1.  Создайте процедуру, которая выберет для одного пользователя 5 пользователей 
-- в случайной комбинации, которые удовлетворяют хотя бы одному критерию:
-- 1) из одного города 
-- 2) состоят в одной группе
-- 3) друзья друзей
USE lesson_4;
UPDATE `lesson_4`.`profiles` 
SET `hometown` = 'Adriannaport'
WHERE `user_id` < '4';

UPDATE `lesson_4`.`profiles` 
SET `hometown` = 'Adriannaport' 
WHERE (`user_id` = '4');

DROP PROCEDURE IF EXISTS find_user;

DELIMITER //
CREATE PROCEDURE find_user(find_id INT)
	BEGIN
    WITH
		friends AS (
        SELECT initiator_user_id AS f_id FROM friend_requests 
        WHERE status='approved' AND target_user_id = find_id
        UNION
        SELECT target_user_id AS f_id FROM friend_requests 
        WHERE status='approved' AND initiator_user_id=find_id
	)
--     SELECT user_id FROM profiles
-- 	WHERE hometown=(SELECT hometown FROM profiles WHERE user_id = find_id)
-- Общий город
	SELECT pr2.user_id  
    FROM profiles as pr1 
    JOIN profiles pr2 ON pr1.hometown=pr2.hometown
    WHERE pr1.user_id = find_id AND pr2.user_id <> find_id
    UNION
-- Состоят в обной ггруппе
    SELECT uc2.user_id 
    FROM users_communities AS uc1
    JOIN users_communities AS uc2 ON uc1.community_id=uc2.community_id
    WHERE uc1.user_id = find_id AND uc2.user_id <> find_id
    UNION
-- Друзья друзей
    SELECT fr_rq.target_user_id FROM friends
    JOIN friend_requests AS fr_rq ON friends.f_id = fr_rq.initiator_user_id
    WHERE fr_rq.status = 'approved' AND fr_rq.target_user_id <> find_id
    UNION
	SELECT fr_rq.initiator_user_id FROM friends
    JOIN friend_requests AS fr_rq ON friends.f_id = fr_rq.target_user_id
    WHERE fr_rq.status = 'approved' AND fr_rq.initiator_user_id <> find_id
    ORDER BY rand()
    LIMIT 5
        
        ;
    END//
DELIMITER ;

CALL find_user(1);

-- SELECT user_id,hometown FROM profiles WHERE hometown = find_town LIMIT 5
