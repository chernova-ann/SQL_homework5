USE shop;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
   id SERIAL PRIMARY KEY,
   name VARCHAR(255), 
   birthday_at DATE, 
   created_at VARCHAR(150),
   updated_at VARCHAR(150)
 );
 
SELECT*FROM users;

INSERT INTO users (id, name, birthday_at) VALUES 
   (1, 'Ann', '1981-10-23'),
   (2, 'Valeriy', '1973-11-25'),
   (3, 'Konstantin', '1985-12-10'),
   (4, 'Vera', '1990-01-07'),
   (5, 'Nadejda', '1994-02-03'),
   (6, 'Lubov', '1993-03-05'),
   (7, 'Petr', '2000-09-17'),
   (8, 'Ivan', '2005-08-17'),
   (9, 'Pavel', '1999-07-07'),
   (10, 'Matvei', '1999-06-12');

 -- 1) ����� � ������� users ���� created_at � updated_at ��������� ��������������. 
 -- ��������� �� �������� ����� � ��������. 
UPDATE users SET 
   created_at = CURRENT_TIMESTAMP,
   updated_at = CURRENT_TIMESTAMP;
  
-- 2)������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� 
-- ���������� �������� � ������� "20.10.2017 8:10". ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.
ALTER TABLE users MODIFY created_at DATETIME, MODIFY updated_at DATETIME;

DESC users;

-- 3) � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 0, ���� ����� ���������� 
-- � ���� ����, ���� �� ������ ������� ������. ���������� ������������� ������ ����� �������, 
-- ����� ��� ���������� � ������� ���������� �������� value. ������, ������� ������ ������ ���������� � �����, ����� ���� �������.

SELECT * FROM storehouses_products;
DESC storehouses_products;

INSERT INTO storehouses_products (id) VALUES  (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

UPDATE storehouses_products SET
    storehouse_id = FLOOR(1 + (RAND()*3)),
    product_id = FLOOR(1 + (RAND()*10)),
    value = FLOOR(1 + (RAND()*50));

INSERT INTO storehouses_products VALUES
    (11, 3, 1, 0, NOW(), NOW()),
    (12, 2, 2, 0, NOW(), NOW()),
    (13, 3, 1, 1, NOW(), NOW());

SELECT * FROM storehouses_products ORDER BY CASE 
    WHEN value = 0 THEN '������ ��� � �������'
    ELSE value
    END;


-- 4) �� ������� users ���������� ������� �������������, ���������� � ������� � ���. 
-- ������ ������ � ���� ������ ���������� �������� ('may', 'august').

SELECT*FROM users;

SELECT * FROM users WHERE DATE_FORMAT(birthday_at,'%M') = 'may' OR DATE_FORMAT(birthday_at, '%M') = 'august';
SELECT * FROM users WHERE DATE_FORMAT(birthday_at,'%M') IN ('may', 'august');

-- 5) �� ������� catalogs ����������� ������ ��� ������ �������. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- ������������ ������ � �������, �������� � ������ IN.

TRUNCATE catalogs;

INSERT INTO catalogs VALUES
  (DEFAULT, '����������'),
  (DEFAULT, '���.�����'),
  (DEFAULT, '����������'),
  (DEFAULT, '���� �������'),
  (DEFAULT, '������� �����'),
  (DEFAULT, '����������� ������');
 
SELECT * FROM catalogs;
 
SELECT * FROM catalogs WHERE id IN (5, 1, 2); 

SELECT*FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);

-- ��������� ������.

-- 1) ����������� ������� ������� ������������� � ������� users

SELECT*FROM users;

SELECT AVG(
    (YEAR(CURRENT_DATE) - YEAR(birthday_at)) -                             
    (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday_at, '%m%d')) 
  ) AS average_age
FROM users;

-- 2) ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. ������� ������, ��� ���������� ��� ������ �������� ����,
-- � �� ���� ��������.

SELECT*FROM users;

SELECT id, birthday_at, DAYOFWEEK(CONCAT(YEAR(NOW()),'-',MONTH(birthday_at),'-',DAYOFMONTH(birthday_at))) AS day_of_week FROM users;

SELECT COUNT(*) AS quantity FROM 
(SELECT DAYOFWEEK(CONCAT(YEAR(NOW()),'-',MONTH(birthday_at),'-',DAYOFMONTH(birthday_at))) AS day_of_week FROM users) AS quantity 
WHERE day_of_week = 2;


-- 3) ����������� ������������ ����� � ������� �������.

SELECT value FROM storehouses_products;
SELECT EXP(SUM(LOG(ABS(value)))) AS multiplied FROM storehouses_products; # ��� �������, ��� ��� �������� ������ ����.

 



 