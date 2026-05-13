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
CREATE TABLE orders (o_id INT PRIMARY KEY, total DECIMAL(10,2));
SELECT * FROM orders WHERE total > ANY (SELECT total FROM orders WHERE total < 1000);
SELECT * FROM orders WHERE total > ALL (SELECT total FROM orders WHERE total < 500);

-- 7. Retail Management (Triggers and Functions)
CREATE TABLE inventory (p_id INT PRIMARY KEY, p_name VARCHAR(50), price DECIMAL(10,2), stock INT);
CREATE TABLE sales_log (s_id INT PRIMARY KEY, p_id INT, qty INT);

CREATE TRIGGER after_sale AFTER INSERT ON sales_log FOR EACH ROW
BEGIN
    UPDATE inventory SET stock = stock - NEW.qty WHERE p_id = NEW.p_id;
END;
