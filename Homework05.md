# Базы данных и SQL (семинары)
## Урок 5. SQL – оконные функции

1. Найти количество сообщений, отправленных каждым пользователей.
В зависимости от количества отправленных сообщений рассчитать ранг пользователей, первое место присвоив пользователю(ям) с наибольшим количеством отправленных сообщений.

Вывести полученный ранг, имя, фамилия, пользователя и кол-во отправленных сообщений. Выводимый список необходимо отсортировать в порядке возрастания ранга.

```

SELECT  DENSE_RANK() OVER (ORDER BY COUNT(m.id) DESC) AS rank_message,
u.firstname,
u.lastname ,
COUNT(m.id) AS cnt
FROM users u
LEFT JOIN messages m ON u.id = m.from_user_id
GROUP BY u.id
ORDER BY rank_message ASC;

```

2. Имеется база данных – социальная сеть.

База данных содержит сущности:
users – пользователи;
messages – сообщения;
friend_requests – заявки на дружбу;
communities – сообщества;
users_communities – пользователи сообществ;
media_types – типы медиа;
media – медиа;
likes – лайки;
profiles – профили пользователя.

У сущности «сообщения» имеются следующие поля(атрибуты):
id – идентификатор;
from_user_id – отправитель;
to_user_id – получатель;
body - содержимое;
created_at - дата отправки.

Получите список сообщений, отсортированных по возрастанию даты отправки.
Вычислите разность между соседними значениями дат отправки. Разности выразите в минутах.

Выведите идентификатор сообщения, дату отправки, дату отправки следующего сообщения и разницу даты отправки соседних сообщений.

```
SELECT id, created_at, LEAD(created_at) OVER(ORDER BY created_at) AS lead_time, TIMESTAMPDIFF (MINUTE, created_at, LEAD(created_at) OVER(ORDER BY created_at)) AS minute_lead_diff FROM messages;
```