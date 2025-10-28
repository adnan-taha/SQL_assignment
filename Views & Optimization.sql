CREATE VIEW book_details AS
SELECT
    b.id AS book_id,
    b.Title,
    a.full_name,
    AVG(r.rating) AS Rating,
    COUNT(r.id) AS `total reviews`
FROM books b
         JOIN authors a ON a.id = b.author_id
         JOIN reviews r ON b.id = r.book_id
GROUP BY b.id, b.Title, a.full_name;

CREATE INDEX order_date ON orders (order_date);

CREATE INDEX author_id ON books (author_id);



