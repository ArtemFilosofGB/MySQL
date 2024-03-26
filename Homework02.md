Базы данных и SQL (семинары)
Урок 2. SQL – создание объектов, простые запросы выборки

1. Имеется таблица (сущность) с мобильными телефонами mobile_phones.
У сущности имеются следующие поля(атрибуты):
id – идентификатор;
product_name – название;
manufacturer – производитель;
product_count – количество;
price – цена.

Сущность mobile_phones имеет следующие записи:
| id | product_name | manufacturer | product_count | price | | --- | ------------ | ------------ | ------------- | ----- | | 1 | iPhone X | Apple | 156 | 76000 | | 2 | iPhone 8 | Apple | 180 | 51000 | | 3 | Galaxy S9 | Samsung | 21 | 56000 | | 4 | Galaxy S8 | Samsung | 124 | 41000 | | 5 | P20 Pro | Huawei | 341 | 36000 |

Создайте таблицу (сущность) с заказами manufacturer. При создании необходимо использовать DDL-команды.
Перечень полей (атрибутов):
id – числовой тип, автоинкремент, первичный ключ;
name – строковый тип;

Используя CRUD-операцию INSERT, наполните сущность manufacturer в соответствии с данными, имеющимися в атрибуте manufacturer сущности mobile_phones.

```sql
DROP TABLE IF EXISTS itresume9807467.manufacturer;
CREATE TABLE itresume9807467.manufacturer (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	name VARCHAR(100) NOT NULL);
  


INSERT INTO itresume9807467.manufacturer (name)
VALUES 
('Apple'),
('Samsung'),
('Huawei');


SELECT * FROM itresume9807467.manufacturer;

```

2. Статусы количества мобильных телефонов (в зависимости от количества): меньше 100 – «little»; от 100 до 300 – «many»; больше 300 – «lots».

Необходимо вывести название, производителя и статус количества для мобильных телефонов.

```sql
SELECT 
  product_name,
  manufacturer,
  CASE 
    WHEN product_count<100 THEN "little"
    WHEN product_count BETWEEN 100 AND 300 THEN "many"
    WHEN product_count>300 THEN "lots"
    END AS product_count 
FROM mobile_phones
```
3. Создайте для сущности mobile_phones внешний ключ manufacturer_id (идентификатор производителя), направленный на атрибут id сущности manufacturer. Установите каскадное обновление - CASCADE, а при удалении записи из сущности manufacturer – SET NULL.

Используя CRUD-операцию UPDATE обновите данные в атрибуте manufacturer_id сущности mobile_phones согласно значений, имеющихся в атрибуте manufacturer.

Удалите атрибут manufacturer из сущности mobile_phones.

Выведите идентификатор, название и идентификатор производителя сущности mobile_phones.
```sql
-- Добавление внешнего ключа в таблицу mobile_phones
ALTER TABLE mobile_phones
ADD COLUMN manufacturer_id BIGINT,
ADD CONSTRAINT fk_manufacturer
    FOREIGN KEY (manufacturer_id)
    REFERENCES manufacturers(id)
    ON UPDATE CASCADE ON DELETE SET NULL;

-- Обновление значения manufacturer_id в таблице mobile_phones на основе поля manufacturer
UPDATE mobile_phones SET manufacturer_id = 1 WHERE manufacturer = 'Apple';
UPDATE mobile_phones SET manufacturer_id = 2 WHERE manufacturer = 'Samsung';
UPDATE mobile_phones SET manufacturer_id = 3 WHERE manufacturer = 'Huawei';

-- Удаление атрибута manufacturer из таблицы mobile_phones
ALTER TABLE mobile_phones
DROP COLUMN manufacturer;

-- Вывод id, product_name и manufacturer_id из таблицы mobile_phones
SELECT id, product_name, manufacturer_id FROM mobile_phones;
```

4. Имеется таблица (сущность) с заказами orders.
У сущности имеются следующие поля(атрибуты):
id – идентификатор;
mobile_phones_id – идентификатор мобильного телефона;
order_status - статус.

id	mobile_phones_id	order_status
1	1	OPEN
2	1	OPEN
3	1	CLOSED
4	4	OPEN
5	4	CANCELLED
Подробное описание статусов заказа:
OPEN – «Order is in open state» ;
CLOSED - «Order is closed»;
CANCELLED - «Order is cancelled»

Необходимо вывести идентификатор и подробное описание статуса заказа.

```sql
SELECT id,      
  CASE order_status
          WHEN 'OPEN' THEN 'Order is in open state'
          WHEN  'CLOSED' THEN 'Order is closed'
          WHEN 'CANCELLED' THEN 'Order is cancelled'
          END AS order_status
FROM orders;
```