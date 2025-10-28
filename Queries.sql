SELECT Title
FROM books
WHERE publication_year > 2020
ORDER BY price DESC;

SELECT full_name
FROM customers
WHERE city = 'London';

SELECT c.full_name, o.*
FROM orders AS o
         JOIN customers AS c ON o.customer_id = c.id
WHERE o.order_date > DATE_SUB(CURDATE(), INTERVAL 30 DAY);;

SELECT *
FROM books
WHERE stock_quantity = 0;

SELECT b.Title, AVG(r.rating) AS 'Rating'
FROM books AS b
         join reviews AS r on b.id = r.book_id
GROUP BY book_id;

SELECT c.full_name, COUNT(*) AS 'Order Count'
FROM customers AS c
         JOIN orders AS o on c.id = o.customer_id
GROUP BY o.customer_id;

SELECT Title, price
FROM books
ORDER BY price DESC
LIMIT 3;

#Joins & Advanced Queries

SELECT c.full_name, b.Title AS 'Book Title', oi.quantity
FROM customers AS c
         JOIN orders AS o on c.id = o.customer_id
         JOIN order_items AS oi on o.id = oi.order_id
         JOIN books AS b on oi.book_id = b.id;


SELECT b.Title, a.full_name AS 'Author Name'
FROM books AS b
         JOIN authors AS a on b.author_id = a.id;

SELECT full_name AS "Customer Name"
FROM customers
WHERE id NOT IN (SELECT customer_id FROM reviews);

SELECT a.full_name, SUM(oi.quantity)
FROM authors AS a
         JOIN books b on a.id = b.author_id
         JOIN order_items oi on b.id = oi.book_id
GROUP BY a.full_name;

SELECT c.full_name,
       SUM(o.total_amount) AS 'Total amount',
       SUM(oi.quantity)    AS 'Total quantity',
       AVG(rating)         AS 'Rating'
FROM customers AS c
         JOIN orders AS o on c.id = o.customer_id
         JOIN order_items AS oi on o.id = oi.order_id
         JOIN reviews AS r on c.id = r.customer_id
group by c.full_name
HAVING SUM(o.total_amount) > 100
ORDER BY SUM(o.total_amount) DESC
LIMIT 5;