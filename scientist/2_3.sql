drop table product;


CREATE TABLE product (
  maker VARCHAR(15),
  model INTEGER,
  type VARCHAR(15)
);

INSERT INTO product (model, maker, type) 
SELECT model, 
    (SELECT CONCAT('Maker', FLOOR(RANDOM() * 1000))), 
    'pc' 
FROM pc;


INSERT INTO product (model, type) SELECT model, 'pc' FROM pc;


INSERT INTO product (model, type) SELECT model, 'laptop' FROM laptop;


INSERT INTO product (model, type) SELECT model, 'printer' FROM printer;

select * from product;

CREATE OR REPLACE FUNCTION random() RETURNS FLOAT AS 'SELECT pg_catalog.random()' LANGUAGE 'sql' IMMUTABLE;

SELECT * FROM pg_catalog.random();

update product
set maker = substring(md5(cast(random() as text)) from 1 for 5);


select * from product;


select model, price from printer order by price desc limit 15;

select avg(speed) from pc;

select maker,type from product where type = 'pc'and type != 'laptop';

INSERT INTO pc (code, model, speed, ram, hd, cd, price) SELECT model, 'printer' FROM printer;

INSERT INTO pc SELECT DISTINCT code + (SELECT COUNT(*) FROM pc),  model, speed, ram, hd, cd, price FROM pc;

INSERT INTO pc 
SELECT DISTINCT code + (SELECT COUNT(*) FROM pc), model, speed, ram, hd, cd, price 
FROM pc
LIMIT 15;

select * from pc;

SELECT *
FROM pc
WHERE (model, speed, ram, hd, cd, price)
IN (
    SELECT model, speed, ram, hd, cd, price
    FROM pc
    GROUP BY model, speed, ram, hd, cd, price
    HAVING COUNT(*) > 1
)
ORDER BY model, speed, ram, hd, cd, price;



SELECT model, speed, ram, hd, cd, price
FROM (
SELECT model, speed, ram, hd, cd, price,
ROW_NUMBER() OVER (PARTITION BY model, speed, ram, hd, cd, price ORDER BY model, speed, ram, hd, cd, price)
rn
FROM pc
) q1
where rn > 1;


delete from pc 
where model in (select model 
from (
Select model, 
ROW_NUMBER() OVER (PARTITION BY model, speed, ram, hd, cd, price ORDER by
model, speed, ram, hd, cd, price) rn 
from pc 
) q1
where rn > 1
);

select * from pc;

delete FROM pc
WHERE (model, speed, ram, hd, cd, price)
IN (
    SELECT model, speed, ram, hd, cd, price
    FROM pc
    GROUP BY model, speed, ram, hd, cd, price
    HAVING COUNT(*) > 1
);

select * from pc;

alter table printer
rename column color to color_type;

alter table printer 
alter column color_type type text;


SELECT * FROM PC 
WHERE price > 500 AND ram = 64
UNION
SELECT * FROM Laptop 
WHERE price > 500 AND ram = 64;




