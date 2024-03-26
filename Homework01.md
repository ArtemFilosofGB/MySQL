# Базы данных и SQL (семинары)

## Урок 1. Установка СУБД, подключение к БД, просмотр и создание таблиц

1. Имеется таблица (сущность) с мобильными телефонами mobile_phones.
У сущности имеются следующие поля(атрибуты):
id – идентификатор;
product_name – название;
manufacturer – производитель;
product_count – количество;
price – цена.
Необходимо вывести идентификатор, название, производителя, количество и цену для мобильных телефонов, у которых производитель «Samsung».

```
SELECT * FROM mobile_phones WHERE manufacturer = "Samsung"
```

2. Имеется таблица (сущность) с мобильными телефонами mobile_phones.
У сущности имеются следующие поля(атрибуты):
id – идентификатор;
product_name – название;
manufacturer – производитель;
product_count – количество;
price – цена.
Необходимо вывести название, производителя и цену для мобильных телефонов, у которых количество больше чем 2.

```
SELECT product_name, manufacturer, price
FROM mobile_phones 
WHERE product_count>2
```

3. Создайте таблицу (сущность) с мобильными телефонами mobile_phones. При создании необходимо использовать DDL-команды.
Перечень полей (атрибутов):
id – числовой тип, автоинкремент, первичный ключ;
product_name – строковый тип, обязательный к заполнению;
manufacturer – строковый тип, обязательный к заполнению;
product_count – числовой тип, беззнаковый;
price – числовой тип, беззнаковый.
Используя CRUD-операцию INSERT, наполните сущность mobile_phones данными:

product_name	manufacturer	product_count	price
iPhone X	Apple	156	76000
iPhone 8	Apple	180	51000
Galaxy S9	Samsung	21	56000
Galaxy S8	Samsung	124	41000
P20 Pro	Huawei	341	36000

Решение:

```
CREATE TABLE itresume9807467.mobile_phones 
(id SERIAL PRIMARY KEY, 
 product_name CHARACTER VARYING(30),
 manufacturer CHARACTER VARYING(30),
 product_coun INTEGER, 
 price INTEGER) 

	
INSERT INTO itresume9807467.mobile_phones VALUES 
(1, 'iPhone X', 'Apple', 156, 76000),
(2, 'iPhone 8', 'Apple', 180, 51000),
(3, 'Galaxy S9', 'Samsung', 21, 56000),
(4, 'Galaxy S8', 'Samsung', 124, 41000),
(5, 'P20 Pro', 'Huawei', 341, 36000);

SELECT * FROM itresume9807467.mobile_phones
```
