/* Домашнее задание по модулю
В рамках задания Вам необходимо сделать выборку данных с помощью запросов
SQL. Получите результирующее множество из БД (рисунок 6) в соответствии с задан-
ными условиями выборки, сортировки, группировки данных: */

-- 1. Выведите авторов, имеющихся в базе.
SELECT name
FROM author
GROUP BY name;

-- 2. Найдите всех авторов с инициалами «С. А.». Автор в базе определяется так: И. О. Фамилия
SELECT name
FROM author
WHERE name LIKE 'С. А.%';

-- 3. Выведите список книг, выпущенных в издательстве «Мир».
SELECT b.title, p.name 
FROM book b
JOIN publisher p ON b.publisher_id = p.id
WHERE p.name LIKE 'Мир'
GROUP BY title;

-- 4. Выведите количество книг, принадлежащих каждой из категорий. Результат отсортировать по возрастанию.
SELECT c.title, COUNT(b.id) AS book_count
FROM category c
LEFT JOIN book b ON c.id = b.category_id 
GROUP BY c.id, c.title
ORDER BY book_count ASC;


/* 5. Выведите количество книг, выпущенных в каждом издательстве. В итоговом
списке оставьте только те издательства, которые выпустили 3 и более книг. Резуль-
тат отсортировать по убыванию. */
SELECT p.name, COUNT(b.title) AS book_count
FROM publisher p
JOIN book b ON b.publisher_id = p.id 
GROUP BY p.name
HAVING COUNT(b.title) > 3
ORDER BY book_count DESC;

-- 6. Выведите список книг, автором которых являлся «С. А. Айвазян».
SELECT b.title
FROM author a
JOIN authorbook ab ON ab.author_id = a.id
JOIN book b ON ab.book_id = b.id
WHERE a.name = 'С. А. Айвазян';

/* 7. В каких издательствах и сколько выпускались книги за авторством «С. А. Айвазян». 
 * Результат отсортировать по убыванию. */
SELECT p.name, COUNT(b.title) AS count
FROM author a
JOIN authorbook ab ON ab.author_id = a.id
JOIN book b ON ab.book_id = b.id
JOIN publisher p ON b.publisher_id = p.id 
WHERE a.name = 'С. А. Айвазян'
GROUP BY p.name
ORDER BY count DESC;


