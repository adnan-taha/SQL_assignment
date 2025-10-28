PREPARE insert_customer FROM
    'INSERT INTO customers (email, full_name, city) VALUES (?, ?, ?)';

SET @email = 'john.doe@example.com';
SET @full_name = 'John Doe';
SET @city = 'Berlin';

EXECUTE insert_customer USING @email, @full_name, @city;

