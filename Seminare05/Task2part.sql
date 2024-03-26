SELECT * FROM lesson05.academic_record;
-- Задача 1. Получить с помощью оконных функции: средний балл ученика 
-- наименьшую оценку ученика
-- наибольшую оценку ученика
-- сумму всех оценок ученика
-- количество всех оценок ученика
SELECT *, 
ROUND(AVG(grade) OVER w_name,2) AS "Средняя",
min(grade) OVER w_name AS "min",
max(grade) OVER w_name AS "max",
sum(grade) OVER w_name AS "sum",
count(grade) OVER w_name AS "count"
FROM academic_record
WINDOW w_name AS (PARTITION BY name);

-- Задача 2. Получить информацию об оценках 
-- Пети по физике по четвертям:  
-- текущая успеваемость 
-- оценка в следующей четверти
-- оценка в предыдущей четверти

SELECT *,
LEAD(grade,1,0) OVER w_quartal AS "next grade",
LAG(grade,1,0) OVER w_quartal AS "last grade" 
FROM academic_record 
WHERE name="ПЕТЯ" AND subject="физика"
WINDOW w_quartal AS (ORDER BY grade);

-- Задача 3. Для базы lesson_4 решите : 
-- создайте представление, в котором будут выводится все сообщения, 
-- в которых принимал участие пользователь с id = 1;

USE lesson_4;

CREATE OR REPLACE VIEW message_v AS
SELECT id,from_user_id, to_user_id,body 
FROM lesson_4.messages 
WHERE from_user_id=1 OR to_user_id=1; 

SELECT * FROM message_v;

-- найдите друзей у  друзей пользователя с id = 1 и поместите выборку в представление; 
-- (решение задачи с помощью CTE)

CREATE OR REPLACE VIEW friend_v AS
SELECT initiator_user_id ,target_user_id,status
FROM friend_requests 
WHERE (initiator_user_id=1 or target_user_id =1) and status="approved"; 
SELECT * FROM friend_v;



CREATE OR REPLACE VIEW friend_v AS
WITH friends AS (
	SELECT initiator_user_id as friend_id
	FROM friend_requests 
	WHERE target_user_id=1 and status="approved"
    UNION
	SELECT target_user_id as friend_id
	FROM friend_requests 
	WHERE initiator_user_id=1 and status="approved"
)
SELECT * FROM friends;

SELECT * FROM friend_v;

--  найдите друзей у  друзей пользователя с id = 1. 
-- (решение задачи с помощью представления “друзья”)

CREATE OR REPLACE VIEW friends_view2 AS
WITH friends AS (
	SELECT initiator_user_id as friend_id
	FROM friend_requests 
	WHERE target_user_id=1 and status="approved"
    UNION
	SELECT target_user_id as friend_id
	FROM friend_requests 
	WHERE initiator_user_id=1 and status="approved"
)
SELECT fr.initiator_user_id AS ffriend_id
FROM friends AS f 
JOIN friend_requests AS fr ON f.friend_id=fr.target_user_id
WHERE fr.initiator_user_id!=1 and status="approved"
UNION
SELECT fr.target_user_id AS ffriend_id
FROM friends AS f 
JOIN friend_requests AS fr ON f.friend_id=fr.initiator_user_id
WHERE fr.target_user_id!=1 and status="approved";

SELECT * FROM friends_view2;

CREATE OR REPLACE VIEW friend_v AS
SELECT fr.initiator_user_id
FROM friend_v AS f
JOIN lesson_4.friend_requests AS fr ON fr.target_user_id = f.friend_id
WHERE fr.initiator_user_id != 1 AND f.friend_id=1  AND fr.status = 'approved'
UNION
SELECT fr.target_user_id
FROM  friend_v AS f
JOIN  lesson_4.friend_requests AS fr ON fr.initiator_user_id = f.friend_id 
WHERE fr.target_user_id != 1  AND f.friend_id=1 AND  status = 'approved';

