START TRANSACTION;

INSERT INTO orders (customer_id, order_date)
values (2, CURDATE());



INSERT INTO order_items (order_id, book_id, quantity, price_at_purchase)
VALUES ((SELECT id FROM orders ORDER BY id DESC LIMIT 1), 1, 1, (SELECT price FROM books WHERE id = 3)),
       ((SELECT id FROM orders ORDER BY id DESC LIMIT 1), 5, 2, (SELECT price FROM books WHERE id = 5));


UPDATE Books
SET stock_quantity = stock_quantity - (SELECT quantity
                                       FROM order_items
                                       WHERE order_items.book_id = Books.id
                                         AND order_items.order_id = (SELECT id FROM orders ORDER BY id DESC LIMIT 1))
WHERE id IN (SELECT book_id
             FROM order_items
             WHERE order_id = (SELECT id FROM orders ORDER BY id DESC LIMIT 1));

COMMIT;


