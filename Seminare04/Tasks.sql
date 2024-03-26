-- Задача 1: выбрать всех пользователей, 
-- указав их id, 
-- имя и 
-- фамилию, 
-- город и 
-- аватарку(используя вложенные запросы)

SELECT 
	id,
	concat(firstname," ",lastname) AS "USER",
    (SELECT hometown FROM profiles WHERE users.id = profiles.user_id) AS "City",
    (SELECT photo_id FROM profiles WHERE users.id = profiles.user_id) AS "Avatar_id",
    (SELECT filename FROM media WHERE id=
		Avatar_id) AS "Avatar"
FROM users;

-- Задача 2: выбрать фотографии (filename) 
-- пользователя с email: arlo50@example.org.ID 
-- типа медиа, 
-- соответствующий фотографиям неизвестен (используя вложенные запросы)
SELECT filename FROM media 
    WHERE user_id =(
    SELECT users.id FROM users 
    WHERE email = "arlo50@example.org"
    AND media_type_id=(SELECT id FROM media_types WHERE name_type LIKE'%Oto'));
    
-- Задача 3: выбрать id друзей пользователя с id = 1 (используя UNION)

SELECT target_user_id FROM friend_requests WHERE initiator_user_id=1 AND status LIKE "app%"
UNION
SELECT initiator_user_id FROM friend_requests WHERE target_user_id=1 AND status LIKE "app%";

-- Задача 4: выбрать всех пользователей, указав их 
-- id, 
-- имя и фамилию, 
-- город и 
-- аватарку(используя JOIN)

SELECT 
	u.id, 
    concat(u.firstname," ",u.lastname) AS user,
    p.hometown p_hometown, 
    m.filename m_filename
FROM users u 
	JOIN profiles p ON u.id= p.user_id
    LEFT JOIN media m ON p.photo_id=m.id;

-- Задача 5: Список медиафайлов пользователей с количеством лайков (используя JOIN)

SELECT  
	m.id, 
	m.filename,
    u.id,
    concat(u.firstname," ",u.lastname) AS user
    ,
    count(l.id) as "likes"
FROM media m 
LEFT JOIN likes l on m.id=l.media_id
JOIN users u ON u.id=m.user_id
GROUP BY m.id;

SELECT  
	media.id, 
	media.filename,
    users.id,
    concat(users.firstname," ",users.lastname) AS user,
    count(likes.id) as "likes"
FROM media 
LEFT JOIN likes on media.id = likes.media_id
JOIN users ON users.id = media.user_id
GROUP BY media.id
ORDER BY likes DESC;

-- Задача 6: Список медиафайлов пользователей, 
-- указав название типа медиа (id, filename, name_type)
-- (используя JOIN)

SELECT 
	media.id,
    filename,
    name_type
FROM media
LEFT JOIN media_types ON media.media_type_id=media_types.id
ORDER BY media.id;