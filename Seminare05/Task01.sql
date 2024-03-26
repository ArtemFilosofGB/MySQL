USE seminare03;

SELECT * FROM staff;
-- 1. Вывести список всех сотрудников и указать место в рейтинге по зарплатам

SELECT *, DENSE_RANK() OVER
(ORDER BY salary DESC) AS rang_salary
FROM staff;

-- 2. Вывести список всех сотрудников и указать место в рейтинге по зарплатам, 
-- но по каждой должности

SELECT *, DENSE_RANK() OVER
(PARTITION BY post ORDER BY salary DESC) AS post_part
FROM staff;

-- 3. Найти самых высокооплачиваемых сотрудников по каждой должности

SELECT * FROM
(SELECT *, DENSE_RANK() OVER
	(PARTITION BY post ORDER BY salary DESC) AS post_part
FROM staff) AS sal_list
WHERE post_part = 1 
ORDER BY salary;

-- 4. Вывести список всех сотрудников, 
-- отсортировав по зарплатам в порядке убывания 
-- и указать на сколько процентов ЗП меньше, чем у сотрудника со следующей (по значению) зарплатой

SELECT *, 
LEAD(salary,1,0) OVER(ORDER BY salary DESC) AS ord_sal,
CONCAT(ROUND((LEAD(salary,1,0) OVER(ORDER BY salary DESC)-salary)*100/salary,2),"%") AS "ЗП меньше"
FROM staff;

-- CUME_DIST()
-- DENSE_RANK()
-- FIRST_VALUE()
-- LAG()
-- LAST_VALUE()
-- LEAD()
-- NTH_VALUE()
-- NTILE()
-- PERCENT_RANK()
-- RANK()
-- ROW_NUMBER()


-- Вывести всех сотрудников, сгруппировав по должностям и рассчитать:
	-- общую сумму зарплат для каждой должности
	-- процентное соотношение каждой зарплаты от общей суммы по должности
	-- среднюю зарплату по каждой должности 
	-- процентное соотношение каждой зарплаты к средней зарплате по должности 
-- Вывести список всех сотрудников и указать место в рейтинге по зарплатам, 
-- но по каждой должности

SELECT *,
SUM(salary) OVER post_w AS "сумму зарплат",
ROUND(salary*100/SUM(salary) OVER post_w) AS "ЗП% от общей ЗП по долж",
ROUND(AVG(salary) OVER post_w) AS "Средняя",
ROUND(salary*100/AVG(salary) OVER post_w) AS "ЗП% к Средней",
DENSE_RANK() OVER(ORDER BY salary DESC) AS "Рейтинг"
FROM staff
WINDOW post_w AS (PARTITION BY post);

SELECT * FROM staff
ORDER BY post;

SELECT *,
SUM(salary) OVER post_w AS "сумму зарплат",
ROUND(salary*100/SUM(salary) OVER post_w) AS "ЗП% по долж",
ROUND(AVG(salary) OVER post_w) AS "Средняя",
ROUND(salary*100/AVG(salary) OVER post_w) AS "ЗП% к Средней",
DENSE_RANK() OVER(post_w ORDER BY salary DESC) AS "место в рейтинге"
FROM staff
WINDOW post_w AS (PARTITION BY post);


