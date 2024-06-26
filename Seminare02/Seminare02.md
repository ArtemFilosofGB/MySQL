# Базы данных и SQL (семинары)
## Урок 2. SQL – создание объектов, простые запросы выборки

# Select

```sql
SELECT * FROM univer.teachers WHERE name LIKE 'K%';

SELECT * FROM univer.teachers;
```

# INSERT INTO

```sql
INSERT INTO `univer`.`dept_salory` (`name`, `dept`, `salary`) 
VALUES ('Anna', 'IT', '7000'),
('Anton', 'Marketing', '9500'),
('Dima', 'IT', '6000'),
('Maxs', 'Accounting', NULL);
```

Practice

```sql
SELECT * FROM univer.dept_salory
WHERE salary>6000;

SELECT * FROM univer.dept_salory
WHERE dept!='IT';
```

# CREATE TABLE

```sql
#CREATE SCHEMA seminare02;
USE seminare02;

DROP TABLE IF EXISTS movies ;#удаление таблицы перед созданием

CREATE TABLE movies (
id SERIAL,		#BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE == SERIAL
title VARCHAR(50) NOT NULL,
title_eng VARCHAR(50),
year_movie YEAR NOT NULL,
count_min INT,
storyline TEXT);

SELECT * FROM movies;
```

# DROP TAB

```sql
- жанры
DROP TABLE IF EXISTS genres;
CREATE TABLE genres (
id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
name VARCHAR(100) NOT NULL
);
```

```sql
- актеры
DROP TABLE IF EXISTS actors;
CREATE TABLE actors (
id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
firstname VARCHAR(100) NOT NULL ,
lastname VARCHAR(100) COMMENT 'Фамилия' -- COMMENT на случай, если имя неочевидное
);
```

```sql
- наполнение данными
INSERT INTO movies (title, title_eng, year_movie, count_min, storyline)
VALUES
('Игры разума', 'A Beautiful Mind', 2001, 135, 'От всемирной известности до греховных глубин — все это познал на своей шкуре Джон Форбс Нэш-младший. Математический гений, он на заре своей карьеры сделал титаническую работу в области теории игр, которая перевернула этот раздел математики и практически принесла ему международную известность. Однако буквально в то же время заносчивый и пользующийся успехом у женщин Нэш получает удар судьбы, который переворачивает уже его собственную жизнь.'),
('Форрест Гамп', 'Forrest Gump', 1994, 142, 'Сидя на автобусной остановке, Форрест Гамп — не очень умный, но добрый и открытый парень — рассказывает случайным встречным историю своей необыкновенной жизни. С самого малолетства парень страдал от заболевания ног, соседские мальчишки дразнили его, но в один прекрасный день Форрест открыл в себе невероятные способности к бегу. Подруга детства Дженни всегда его поддерживала и защищала, но вскоре дороги их разошлись.'),
('Иван Васильевич меняет профессию', NULL, 1998, 128,'Инженер-изобретатель Тимофеев сконструировал машину времени, которая соединила его квартиру с далеким шестнадцатым веком - точнее, с палатами государя Ивана Грозного. Туда-то и попадают тезка царя пенсионер-общественник Иван Васильевич Бунша и квартирный вор Жорж Милославский. На их место в двадцатом веке «переселяется» великий государь. Поломка машины приводит ко множеству неожиданных и забавных событий...'),
('Назад в будущее', 'Back to the Future', 1985, 116, 'Подросток Марти с помощью машины времени, сооружённой его другом-профессором доком Брауном, попадает из 80-х в далекие 50-е. Там он встречается со своими будущими родителями, ещё подростками, и другом-профессором, совсем молодым.'),
('Криминальное чтиво', 'Pulp Fiction', 1994, 154, NULL);
```

```sql
/*Переименовать сущность movies в cinema.

Добавить сущности cinema новый атрибут status_active (тип BIT) 
и атрибут genre_id после атрибута title_eng.

Удалить атрибут status_active сущности cinema. 

Удалить сущность actors из базы данных

Добавить внешний ключ на атрибут genre_id сущности cinema 
и направить его на атрибут id сущности genres.

Очистить сущность genres от данных и обнулить автоинкрементное  поле.*/

RENAME TABLE movies TO cinema;

ALTER TABLE cinema 
ADD COLUMN  status_active BIT DEFAULT b'1',
ADD genre_id BIGINT UNSIGNED AFTER title_eng;

ALTER TABLE cinema 
DROP COLUMN status_active;

DROP TABLE actors;

ALTER TABLE cinema 
ADD FOREIGN KEY (genre_id) REFERENCES genres(id);

ALTER TABLE cinema 
DROP FOREIGN KEY cinema_ibfk_1;

TRUNCATE TABLE genres; # Очистить сущность genres от данных и обнулить автоинкрементное  поле

```

```sql
/*Задача 3. Выведите id, название фильма
и категорию фильма, 
согласно следующего перечня: 
Д- Детская, 
П – Подростковая, 
В – Взрослая, Не указана*/

SELECT 
	id AS "Номер Фильма", 
	title AS "Название", 
	CASE age_category 
		WHEN "Д" THEN "Детская"
        WHEN "П" THEN "Подростковая"
        WHEN "В" THEN "Взрослая"
        ELSE "Неизвестно"
	END AS "Категория"
FROM seminare02.cinema;
```

```sql
-- добавим поле возрастная категория фильмов
ALTER TABLE cinema
ADD COLUMN age_category CHAR(1);

-- присвоение фильмам категорий 
UPDATE cinema SET age_category='П' WHERE id=1;
UPDATE cinema SET age_category='Д' WHERE id=4;
UPDATE cinema SET age_category='В' WHERE id=5;
```

```sql
/*Задача 4. 
Выведите id, 
название фильма, 
продолжительность, 
тип в зависимости от продолжительности (с использованием CASE).

До 50 минут -  Короткометражный фильм
От 50 минут до 100 минут  -  Среднеметражный фильм
Более 100 минут  -  Полнометражный фильм
Иначе  - Не определено*/

SELECT * FROM cinema;

SELECT 
	id AS "Номер Фильма", 
	title AS "Название", 
	CASE 
		WHEN count_min < 50 THEN "Короткометражный фильм"
        WHEN count_min BETWEEN 50 AND 100 THEN "Среднеметражный фильм"
        WHEN count_min > 100 THEN "Полнометражный фильм"
        ELSE "Неизвестно"
	END AS "Длительность"
FROM seminare02.cinema;
```

```sql
-- изменение продолжительности фильмов 
UPDATE cinema SET count_min = 88 WHERE id=2;
UPDATE cinema SET count_min = NULL WHERE id=3;
UPDATE cinema SET count_min = 34 WHERE id=4;

```

```sql
SELECT 
	id AS "Номер Фильма", 
	title AS "Название",
    count_min AS "Длительность",
    IF(count_min<50,"Короткий метр",
		IF(count_min BETWEEN 50 AND 100,"Среднеметражный фильм",
			IF(count_min>100,"Полнометражный фильм","Неизвестно")
			)
		) AS "Длительность"
FROM cinema;
```