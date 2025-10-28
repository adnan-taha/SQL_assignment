CREATE TABLE authors
(
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name  TEXT NOT NULL,
    birth_year TEXT,
    country    TEXT
);

CREATE TABLE books
(
    id               INTEGER PRIMARY KEY AUTOINCREMENT,
    Title            TEXT NOT NULL unique,
    ISBN             INTEGER(13) UNIQUE,
    publication_year TEXT,
    price            REAL CHECK ( price >= 0 ),
    stock_quantity   INTEGER,
    author_id        INTEGER,
    FOREIGN KEY (author_id) REFERENCES Authors (id)
);

CREATE TABLE customers
(
    id                INTEGER PRIMARY KEY AUTOINCREMENT,
    email             TEXT NOT NULL UNIQUE,
    full_name         TEXT NOT NULL,
    registration_date TEXT DEFAULT CURRENT_TIMESTAMP,
    city              TEXT
);

create table orders
(
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id  INTEGER,
    order_date   TEXT DEFAULT CURRENT_TIMESTAMP,
    total_amount INTEGER,
    FOREIGN KEY (customer_id) REFERENCES Customers (id)
);

create table order_items
(
    id                INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id          INTEGER,
    book_id           INTEGER,
    quantity          INTEGER,
    price_at_purchase REAL,
    FOREIGN KEY (order_id) REFERENCES orders (id),
    FOREIGN KEY (book_id) REFERENCES Books (id)
);

create table reviews
(
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    book_id     INTEGER,
    customer_id INTEGER,
    rating      INTEGER CHECK ( rating >= 0 AND rating <= 5 ),
    review_text TEXT,
    review_date TEXT,
    FOREIGN KEY (book_id) REFERENCES Books (id),
    FOREIGN KEY (customer_id) REFERENCES Customers (id)
);

