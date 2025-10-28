-- ===========================================
-- 1️⃣ Import authors.csv into Authors table
-- ===========================================

CREATE TEMPORARY TABLE temp_authors
(
    `Full Name`  VARCHAR(255),
    `Birth Year` INT,
    Country      VARCHAR(100)
);

LOAD DATA LOCAL INFILE '/path/to/authors.csv'
    INTO TABLE temp_authors
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

INSERT INTO Authors (full_name, birth_year, country)
SELECT `Full Name`, `Birth Year`, Country
FROM temp_authors;

DROP TEMPORARY TABLE temp_authors;


-- ===========================================
-- 2️⃣ Import books.csv into Books table
-- ===========================================

CREATE TEMPORARY TABLE temp_books
(
    Title              VARCHAR(255),
    ISBN               VARCHAR(20),
    `Publication Year` INT,
    Price              DECIMAL(10, 2),
    `Stock Quantity`   INT,
    `Author ID`        INT
);

LOAD DATA LOCAL INFILE '/path/to/books.csv'
    INTO TABLE temp_books
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

INSERT INTO books (Title, ISBN, publication_year, price, stock_quantity, author_id)
SELECT Title, ISBN, `Publication Year`, Price, `Stock Quantity`, `Author ID`
FROM temp_books;

DROP TEMPORARY TABLE temp_books;


-- ===========================================
-- 3️⃣ Import customers.csv into Customers table
-- ===========================================

CREATE TEMPORARY TABLE temp_customers
(
    Email               VARCHAR(255),
    `Full Name`         VARCHAR(255),
    `Registration Date` DATETIME,
    City                VARCHAR(100)
);

LOAD DATA LOCAL INFILE '/path/to/customers.csv'
    INTO TABLE temp_customers
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

INSERT INTO customers (email, full_name, registration_date, city)
SELECT Email, `Full Name`, `Registration Date`, City
FROM temp_customers;

DROP TEMPORARY TABLE temp_customers;


-- ===========================================
-- 4️⃣ Import orders.csv into Orders table
-- ===========================================

CREATE TEMPORARY TABLE temp_orders
(
    `Customer ID`  INT,
    `Order Date`   DATETIME,
    `Total Amount` DECIMAL(10, 2)
);

LOAD DATA LOCAL INFILE '/path/to/orders.csv'
    INTO TABLE temp_orders
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

INSERT INTO orders (customer_id, order_date, total_amount)
SELECT `Customer ID`, `Order Date`, `Total Amount`
FROM temp_orders;

DROP TEMPORARY TABLE temp_orders;


-- ===========================================
-- 5️⃣ Import order_items.csv into Order_Items table
-- ===========================================

CREATE TEMPORARY TABLE temp_order_items
(
    `Order ID`          INT,
    `Book ID`           INT,
    Quantity            INT,
    `Price at Purchase` DECIMAL(10, 2)
);

LOAD DATA LOCAL INFILE '/path/to/order_items.csv'
    INTO TABLE temp_order_items
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

INSERT INTO order_items (order_id, book_id, quantity, price_at_purchase)
SELECT `Order ID`, `Book ID`, Quantity, `Price at Purchase`
FROM temp_order_items;

DROP TEMPORARY TABLE temp_order_items;


-- ===========================================
-- 6️⃣ Import reviews.csv into Reviews table
-- ===========================================

CREATE TEMPORARY TABLE temp_reviews
(
    `Book ID`     INT,
    `Customer ID` INT,
    Rating        INT,
    `Review Text` TEXT,
    `Review Date` DATETIME
);

LOAD DATA LOCAL INFILE '/path/to/reviews.csv'
    INTO TABLE temp_reviews
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

INSERT INTO reviews (book_id, customer_id, rating, review_text, review_date)
SELECT `Book ID`, `Customer ID`, Rating, `Review Text`, `Review Date`
FROM temp_reviews;

DROP TEMPORARY TABLE temp_reviews;


-- ===========================================
-- 7️⃣ Update stock_quantity for top 3 most-ordered books
-- ===========================================

UPDATE books b
    JOIN (SELECT book_id, SUM(quantity) AS total_ordered
          FROM order_items
          GROUP BY book_id
          ORDER BY COUNT(*) DESC
          LIMIT 3) t ON b.id = t.book_id
SET b.stock_quantity = b.stock_quantity - t.total_ordered;


-- ===========================================
-- 8️⃣ Delete customers who never placed an order
-- ===========================================

DELETE c
FROM customers c
         JOIN orders o ON c.id = o.customer_id
WHERE o.customer_id IS NULL;
