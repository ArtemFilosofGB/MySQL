-- CROSS JOIN
SELECT * FROM users, messages;

SELECT * FROM users JOIN messages;

-- INNER JOIN
SELECT * FROM users u
INNER JOIN messages m 
WHERE u.id = m.from_user_id;

SELECT * FROM users u
JOIN messages m ON u.id=m.from_user_id;


-- LEFT JOIN
SELECT u.*, m.*  
FROM users u LEFT JOIN messages m ON u.id=m.from_user_id;

-- RIGHT  JOIN
SELECT u.*, m.*  FROM users u
RIGHT JOIN messages m ON u.id=m.from_user_id;

-- FULL JOIN 
SELECT u.*, m.*  FROM users u
LEFT JOIN messages m ON u.id=m.from_user_id
UNION 
SELECT u.*, m.*  FROM users u
RIGHT JOIN messages m ON u.id=m.from_user_id;