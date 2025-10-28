DELIMITER $$

CREATE PROCEDURE place_order(
    IN p_customer_id INT,
    IN p_book_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_stock INT;
    DECLARE v_price DECIMAL(10,2);
    DECLARE v_order_id INT;

    SELECT stock_quantity, price INTO v_stock, v_price
    FROM books
    WHERE id = p_book_id;

    IF v_stock IS NULL THEN
        SELECT 'Error: Book not found.' AS message;
    ELSEIF v_stock < p_quantity THEN
        SELECT CONCAT('Error: Only ', v_stock, ' in stock.') AS message;
    ELSE
        START TRANSACTION;

        INSERT INTO orders (customer_id, order_date)
        VALUES (p_customer_id, CURDATE());

        SET v_order_id = LAST_INSERT_ID();

        INSERT INTO order_items (order_id, book_id, quantity, price_at_purchase)
        VALUES (v_order_id, p_book_id, p_quantity, v_price);

        UPDATE books
        SET stock_quantity = stock_quantity - p_quantity
        WHERE id = p_book_id;

        COMMIT;

        SELECT CONCAT('Success: Order placed with ID ', v_order_id) AS message;
    END IF;
END $$

DELIMITER ;

