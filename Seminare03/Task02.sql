-- 1. Выведите уникальные (неповторяющиеся) значения полей "name"
SELECT DISTINCT firstname FROM seminare03.staff;

-- 2. Выведите первые две первые записи из таблицы
SELECT * FROM seminare03.staff LIMIT 2;

/*3. Пропустите первые 4 строки ("id" = 1, "id" = 2,"id" = 3,"id" = 4) и
извлеките следующие 3 строки ("id" = 5, "id" = 6, "id" = 7)*/
SELECT * FROM seminare03.staff 
WHERE id in (5,6,7);

SELECT * FROM seminare03.staff ORDER BY id LIMIT 4,3;


/*4*. Пропустите две последнии строки (где id=12, id=11) и извлекаются
следующие за ними 3 строки (где id=10, id=9, id=8)*/
SELECT * FROM seminare03.staff ORDER BY id DESC LIMIT 2,3;
