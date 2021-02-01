--Задание 2.
--Лучше выполнить сначала явное преобразование к формату даты.
--Можно сразу изменить только тип столбца, но в некоторых версиях mySQL может не сработать. 
--(Об этом скорее всего еще будут говорить на вебинаре).
--1. Приводим строку к нужному виду.
UPDATE users SET
	created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
	updated_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i');
--2. Выполняем изменение типа столбца (верно сделано). 
ALTER TABLE users CHANGE created_at created_at DATETIME;
ALTER TABLE users CHANGE updated_at updated_at DATETIME;


--Задание 3. 
--Команды лучше всегда выполнять в верхнем регистре для читаемости кода. 
--product - лучше указывать, как product_id (т.к. логика табличная предполагает, 
--что будет отдельная табличка с продукцией products, а в таблице складских запасов storehouses_products будет уже ссылка на первичный ключ по id).

--Решение может быть таким
SELECT*FROM storehouses_products 
ORDER BY value = 0, value; 
--value = 0 Здесь проверяется условие. Если value равно 0, то возвращается булево значение 1. Если не равно 0. 
--Затем происходит сортировка стандартная по возрастанию по результатм проверки условия. Сначала нули, затем единицы.

--ORDER BY VALUE DESC получается просто сортировка по убаванию. Но нам нужно чтобы положительные значения были по возрастанию.  
--WHERE `value` > 0 ORDER BY `value` asc.  Условие WHERE оставляет нам для дальнейшей сортировки только положительные значения, мы теряем все значения с нулем.  
--С WHERE в последнем варианте так не получится, так как сначала по условию мы выбираем значения, а потом сортируем.

--Агрегация.
--Задание 1.
--/Практическое задание теме «Агрегация данных»/ - Здесь какое задание? Вот это? "Подсчитайте средний возраст пользователей в таблице users."

--Здесь верно добавил столбец birthday. Не нужно создавать age, middle age, currentdate.
--Нужно с помощью математических функций посчитать возраст от сегодняшней даты. Сегодняшнюю дату не нужно сохранять в переменные (CurrentDate = CURRENTDATE()), как обычно в python. Просто воспользоваться функцией CURRENTDATE в запросе. Например так. Но есть и другие варианты.

SELECT AVG(
    (YEAR(CURRENT_DATE) - YEAR(birthday_at)) -                             
    (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday_at, '%m%d')) 
  ) AS average_age
FROM users;
