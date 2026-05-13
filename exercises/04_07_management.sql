-- 4. Create sales table and use aggregate functions
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product VARCHAR(50),
    category VARCHAR(50),
    amount DECIMAL(10,2),
    sale_date DATE
);

SELECT category, SUM(amount), MAX(amount), MIN(amount) 
FROM sales 
GROUP BY category 
ORDER BY SUM(amount) DESC;

-- 5. Library Management System (Triggers and Functions)
CREATE TABLE books (b_id INT PRIMARY KEY, title VARCHAR(50), available_qty INT);
CREATE TABLE issues (issue_id INT PRIMARY KEY, b_id INT, issue_date DATE);

DELIMITER //
CREATE FUNCTION check_stock(book_id INT) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE qty INT;
    SELECT available_qty INTO qty FROM books WHERE b_id = book_id;
    RETURN qty;
END //

CREATE TRIGGER update_stock AFTER INSERT ON issues FOR EACH ROW
BEGIN
    UPDATE books SET available_qty = available_qty - 1 WHERE b_id = NEW.b_id;
END //
DELIMITER ;

-- 6. Order Table (IN, ALL, ANY)
---------------------------------------------------
-- CREATE ORDER TABLE
---------------------------------------------------

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    product_name VARCHAR(50),
    amount DECIMAL(10,2)
);

---------------------------------------------------
-- INSERT SAMPLE DATA
---------------------------------------------------

INSERT INTO orders VALUES
(1, 'Arun', 'Laptop', 55000),
(2, 'Bala', 'Mobile', 20000),
(3, 'Charan', 'Tablet', 30000),
(4, 'David', 'Headphone', 5000),
(5, 'Elan', 'Monitor', 25000);

---------------------------------------------------
-- USING IN OPERATOR
---------------------------------------------------

-- Display orders for Laptop and Mobile

SELECT *
FROM orders
WHERE product_name IN ('Laptop', 'Mobile');

---------------------------------------------------
-- USING ANY OPERATOR
---------------------------------------------------

-- Find products with amount greater than ANY product
-- whose amount is below 25000

SELECT *
FROM orders
WHERE amount > ANY (
    SELECT amount
    FROM orders
    WHERE amount < 25000
);

---------------------------------------------------
-- USING ALL OPERATOR
---------------------------------------------------

-- Find products with amount greater than ALL products
-- whose amount is below 25000

SELECT *
FROM orders
WHERE amount > ALL (
    SELECT amount
    FROM orders
    WHERE amount < 25000
);

---------------------------------------------------
-- DISPLAY TABLE
---------------------------------------------------

SELECT * FROM orders;
-- 7. Retail Management (Triggers and Functions)
---------------------------------------------------
-- RETAIL MANAGEMENT SYSTEM
-- USING TRIGGERS AND FUNCTIONS
---------------------------------------------------

---------------------------------------------------
-- 1. CREATE PRODUCT TABLE
---------------------------------------------------

CREATE TABLE product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    stock INT,
    price DECIMAL(10,2)
);

---------------------------------------------------
-- 2. CREATE CUSTOMER TABLE
---------------------------------------------------

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

---------------------------------------------------
-- 3. CREATE SALES TABLE
---------------------------------------------------

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    sale_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

---------------------------------------------------
-- 4. INSERT SAMPLE DATA
---------------------------------------------------

INSERT INTO product VALUES
(1, 'Laptop', 10, 55000),
(2, 'Mobile', 20, 20000);

INSERT INTO customer VALUES
(101, 'Arun'),
(102, 'Bala');

---------------------------------------------------
-- 5. CREATE TRIGGER
-- Reduce stock after product sale
---------------------------------------------------

DELIMITER $$

CREATE TRIGGER trg_reduce_stock
AFTER INSERT ON sales
FOR EACH ROW
BEGIN
    UPDATE product
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;
END$$

DELIMITER ;

---------------------------------------------------
-- 6. INSERT SALE RECORD
---------------------------------------------------

INSERT INTO sales VALUES
(1001, 101, 1, 2, '2025-05-12');

---------------------------------------------------
-- 7. CREATE FUNCTION
-- Calculate total price
---------------------------------------------------

DELIMITER $$

CREATE FUNCTION total_amount(pid INT, qty INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT price * qty
    INTO total
    FROM product
    WHERE product_id = pid;

    RETURN total;
END$$

DELIMITER ;

---------------------------------------------------
-- 8. CALL FUNCTION
---------------------------------------------------

SELECT total_amount(1, 2) AS total_bill;

---------------------------------------------------
-- 9. DISPLAY TABLES
---------------------------------------------------

SELECT * FROM product;
SELECT * FROM customer;
SELECT * FROM sales;
