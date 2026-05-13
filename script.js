const exercises = [
    {
        id: 1,
        tag: "Aggregate & Joins",
        title: "Student Marks System",
        desc: "Create student and studentmark tables and find average using aggregate functions and joins.",
        sql: `-- 1. Create student table
CREATE TABLE student (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50)
);

-- 2. Create studentmark table
CREATE TABLE studentmark (
    mark_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject VARCHAR(50),
    marks INT,
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);

-- 3. Find average marks using join
SELECT s.name, AVG(m.marks) as average_marks
FROM student s
JOIN studentmark m ON s.student_id = m.student_id
GROUP BY s.student_id;`
    },
    {
        id: 2,
        tag: "Triggers & Subqueries",
        title: "Healthcare Management",
        desc: "Create patient, doctor, and appointment tables. Use triggers and subqueries.",
        sql: `-- Table Creation
CREATE TABLE doctor (d_id INT PRIMARY KEY, d_name VARCHAR(50), spec VARCHAR(50));
CREATE TABLE patient (p_id INT PRIMARY KEY, p_name VARCHAR(50), age INT);
CREATE TABLE appointment (
    app_id INT PRIMARY KEY, 
    p_id INT, d_id INT, 
    app_date DATE,
    FOREIGN KEY (p_id) REFERENCES patient(p_id),
    FOREIGN KEY (d_id) REFERENCES doctor(d_id)
);

-- Trigger: Audit table for appointments
CREATE TABLE appointment_log (log_id INT AUTO_INCREMENT PRIMARY KEY, app_id INT, action VARCHAR(20), log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

DELIMITER //
CREATE TRIGGER after_app_insert
AFTER INSERT ON appointment
FOR EACH ROW
BEGIN
    INSERT INTO appointment_log(app_id, action) VALUES (NEW.app_id, 'INSERT');
END //
DELIMITER ;

-- Subquery: Patients with more than 1 appointment
SELECT p_name FROM patient 
WHERE p_id IN (SELECT p_id FROM appointment GROUP BY p_id HAVING COUNT(*) > 1);`
    },
    {
        id: 3,
        tag: "Transaction Control",
        title: "Banking System (TCL)",
        desc: "Demonstration of TCL commands: COMMIT, ROLLBACK, and SAVEPOINT.",
        sql: `-- Setup
CREATE TABLE accounts (acc_id INT PRIMARY KEY, balance DECIMAL(10,2));
INSERT INTO accounts VALUES (1, 5000), (2, 3000);

-- Transaction Start
START TRANSACTION;

-- Step 1: Transfer
UPDATE accounts SET balance = balance - 500 WHERE acc_id = 1;
SAVEPOINT sp1;

-- Step 2: Receive
UPDATE accounts SET balance = balance + 500 WHERE acc_id = 2;

-- If everything is fine
COMMIT;

-- Or if error occurs
-- ROLLBACK TO sp1; -- Go back to savepoint
-- ROLLBACK; -- Revert everything`
    },
    {
        id: 4,
        tag: "Aggregate Functions",
        title: "Sales Management",
        desc: "Aggregate functions: GROUP BY, MAX, MIN, ORDER BY, etc.",
        sql: `-- Create Sales Table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    quantity INT,
    price_per_unit DECIMAL(10,2),
    sale_date DATE
);

-- Queries
SELECT category, SUM(quantity * price_per_unit) as total_revenue
FROM sales
GROUP BY category
ORDER BY total_revenue DESC;

SELECT MAX(price_per_unit) as highest_price, MIN(price_per_unit) as lowest_price
FROM sales;`
    },
    {
        id: 5,
        tag: "Stored Logic",
        title: "Library Management",
        desc: "Library Management System using triggers and functions.",
        sql: `-- Table Structure
CREATE TABLE books (book_id INT PRIMARY KEY, title VARCHAR(100), status VARCHAR(20) DEFAULT 'Available');
CREATE TABLE borrow_log (log_id INT PRIMARY KEY AUTO_INCREMENT, book_id INT, borrow_date DATE);

-- Function: Get book count by status
DELIMITER //
CREATE FUNCTION get_book_count(p_status VARCHAR(20)) 
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE b_count INT;
    SELECT COUNT(*) INTO b_count FROM books WHERE status = p_status;
    RETURN b_count;
END //

-- Trigger: Update status on borrow
CREATE TRIGGER update_book_status
AFTER INSERT ON borrow_log
FOR EACH ROW
BEGIN
    UPDATE books SET status = 'Borrowed' WHERE book_id = NEW.book_id;
END //
DELIMITER ;`
    },
    {
        id: 6,
        tag: "Operators",
        title: "Order Table Operators",
        desc: "Using IN, ALL, and ANY operators for complex filtering.",
        sql: `-- Setup
CREATE TABLE orders (order_id INT PRIMARY KEY, amount DECIMAL(10,2));
INSERT INTO orders VALUES (1, 100), (2, 500), (3, 1200);

-- IN Operator
SELECT * FROM orders WHERE order_id IN (1, 3);

-- ANY Operator (Greater than any in list)
SELECT * FROM orders WHERE amount > ANY (SELECT amount FROM orders WHERE amount < 1000);

-- ALL Operator (Greater than all in list)
SELECT * FROM orders WHERE amount > ALL (SELECT amount FROM orders WHERE amount < 500);`
    },
    {
        id: 7,
        tag: "Retail Systems",
        title: "Retail Management",
        desc: "Retail Management System using triggers and functions for inventory.",
        sql: `-- Inventory System
CREATE TABLE products (p_id INT PRIMARY KEY, p_name VARCHAR(50), stock INT);
CREATE TABLE sales_items (s_id INT PRIMARY KEY, p_id INT, qty INT);

-- Trigger: Auto-reduce stock
DELIMITER //
CREATE TRIGGER reduce_stock
AFTER INSERT ON sales_items
FOR EACH ROW
BEGIN
    UPDATE products SET stock = stock - NEW.qty WHERE p_id = NEW.p_id;
END //
DELIMITER ;`
    },
    {
        id: 8,
        tag: "Joins",
        title: "Student Enrollment (Joins)",
        desc: "Implementation of INNER, OUTER, LEFT, RIGHT, and FULL Joins.",
        sql: `-- Tables
CREATE TABLE students (s_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE courses (c_id INT PRIMARY KEY, c_name VARCHAR(50));
CREATE TABLE enroll (s_id INT, c_id INT);

-- INNER JOIN
SELECT s.name, c.c_name FROM students s INNER JOIN enroll e ON s.s_id = e.s_id INNER JOIN courses c ON e.c_id = c.c_id;

-- LEFT JOIN (All students, even without courses)
SELECT s.name, e.c_id FROM students s LEFT JOIN enroll e ON s.s_id = e.s_id;

-- RIGHT JOIN (All courses, even without students)
SELECT e.s_id, c.c_name FROM enroll e RIGHT JOIN courses c ON e.c_id = c.c_id;

-- FULL JOIN (MySQL emulation using UNION)
SELECT s.name, c.c_name FROM students s LEFT JOIN enroll e ON s.s_id = e.s_id LEFT JOIN courses c ON e.c_id = c.c_id
UNION
SELECT s.name, c.c_name FROM students s RIGHT JOIN enroll e ON s.s_id = e.s_id RIGHT JOIN courses c ON e.c_id = c.c_id;`
    },
    {
        id: 9,
        tag: "Salary Logs",
        title: "Salary Management",
        desc: "Salary Management System using triggers to track history.",
        sql: `-- Table
CREATE TABLE employees (emp_id INT PRIMARY KEY, name VARCHAR(50), salary DECIMAL(10,2));
CREATE TABLE salary_audit (audit_id INT AUTO_INCREMENT PRIMARY KEY, emp_id INT, old_sal DECIMAL(10,2), new_sal DECIMAL(10,2), change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

-- Trigger to log salary changes
DELIMITER //
CREATE TRIGGER log_salary_change
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_audit(emp_id, old_sal, new_sal) 
        VALUES (OLD.emp_id, OLD.salary, NEW.salary);
    END IF;
END //
DELIMITER ;`
    },
    {
        id: 10,
        tag: "Reservation Logic",
        title: "Airline Reservation System",
        desc: "Airline Reservation System using triggers to prevent overbooking.",
        sql: `-- Tables
CREATE TABLE flights (f_id INT PRIMARY KEY, capacity INT, booked_seats INT DEFAULT 0);
CREATE TABLE tickets (t_id INT PRIMARY KEY, f_id INT, passenger VARCHAR(50));

-- Trigger: Prevent overbooking
DELIMITER //
CREATE TRIGGER check_seat_availability
BEFORE INSERT ON tickets
FOR EACH ROW
BEGIN
    DECLARE v_cap, v_booked INT;
    SELECT capacity, booked_seats INTO v_cap, v_booked FROM flights WHERE f_id = NEW.f_id;
    
    IF v_booked >= v_cap THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No seats available on this flight!';
    ELSE
        UPDATE flights SET booked_seats = booked_seats + 1 WHERE f_id = NEW.f_id;
    END IF;
END //
DELIMITER ;`
    },
    {
        id: 11,
        tag: "Optimization",
        title: "Views and Indexes",
        desc: "Creating views for reporting and indexes for performance.",
        sql: `-- 1. Create Index for faster searching
CREATE INDEX idx_emp_name ON employees(name);

-- 2. Create View for high earners
CREATE VIEW high_salary_employees AS
SELECT name, salary, department
FROM employees
WHERE salary > 50000;

-- Using the view
SELECT * FROM high_salary_employees;`
    },
    {
        id: 12,
        tag: "NoSQL",
        title: "Document-Based NoSQL",
        desc: "Example of a Customer Order in JSON format (MongoDB style).",
        sql: `// MongoDB Collection: orders
{
  "_id": ObjectId("65f1..."),
  "customer": {
    "name": "Dilip Kumar",
    "email": "dilip@example.com",
    "address": "123 Tech Street, Bangalore"
  },
  "items": [
    { "product": "Laptop", "qty": 1, "price": 85000 },
    { "product": "Mouse", "qty": 1, "price": 1200 }
  ],
  "total": 86200,
  "status": "Delivered",
  "ordered_at": ISODate("2026-05-13T10:00:00Z")
}`
    },
    {
        id: 13,
        tag: "BaaS",
        title: "Firebase Test Management",
        desc: "Realtime Test Management System using Firebase Realtime Database.",
        sql: `// Firebase Database Structure (JSON)
{
  "tests": {
    "test_001": {
      "title": "SQL Quiz 1",
      "duration": 30,
      "questions": {
        "q1": { "text": "What is 3NF?", "options": ["A", "B", "C"], "correct": "A" }
      }
    }
  },
  "submissions": {
    "user_101": {
      "test_id": "test_001",
      "score": 85,
      "timestamp": 1715568000000
    }
  }
}`
    },
    {
        id: 14,
        tag: "Theory",
        title: "Normalization (3NF)",
        desc: "Detailed explanation and example of Normalization up to 3rd Normal Form.",
        sql: `-- 1NF: No multi-valued attributes (Each cell has single value)
-- 2NF: 1NF + No partial dependency (Non-prime attributes depend on whole primary key)
-- 3NF: 2NF + No transitive dependency (Non-prime attributes don't depend on other non-prime)

-- Example: Student(ID, Name, Dept_ID, Dept_Name)
-- This is NOT in 3NF because Dept_Name depends on Dept_ID (Transitive).

-- Normalized to 3NF:
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);`
    }
];

// Populate Grid
const grid = document.getElementById('exerciseGrid');
const modal = document.getElementById('modal');
const modalTitle = document.getElementById('modalTitle');
const modalBody = document.getElementById('modalBody');
const closeModal = document.getElementById('closeModal');

function renderExercises() {
    exercises.forEach((ex, index) => {
        const card = document.createElement('div');
        card.className = 'card reveal';
        card.style.transitionDelay = `${index * 0.1}s`;
        
        card.innerHTML = `
            <span class="card-tag">${ex.tag}</span>
            <h3>${ex.title}</h3>
            <p>${ex.desc}</p>
            <button class="btn-view" onclick="openExercise(${ex.id})">View Solution</button>
        `;
        
        card.onclick = (e) => {
            if(e.target.tagName !== 'BUTTON') openExercise(ex.id);
        };
        
        grid.appendChild(card);
    });

    // Simple scroll reveal
    setTimeout(() => {
        const cards = document.querySelectorAll('.card');
        cards.forEach(c => c.classList.add('active'));
    }, 100);
}

function openExercise(id) {
    const ex = exercises.find(e => e.id === id);
    modalTitle.innerText = ex.title;
    
    // Simple SQL highlighter emulation
    let highlightedSql = ex.sql
        .replace(/(--.*)/g, '<span class="sql-comment">$1</span>')
        .replace(/\b(CREATE|TABLE|SELECT|INSERT|UPDATE|DELETE|FROM|WHERE|JOIN|GROUP BY|ORDER BY|PRIMARY KEY|FOREIGN KEY|TRIGGER|FUNCTION|DELIMITER|BEGIN|END|IF|THEN|ELSE|DECLARE|SIGNAL|SQLSTATE|SET|MESSAGE_TEXT|IN|ANY|ALL|COMMIT|ROLLBACK|SAVEPOINT|START TRANSACTION|AUTO_INCREMENT|DECIMAL|INT|VARCHAR|DATE|TIMESTAMP|RETURNS|DETERMINISTIC|UNION)\b/g, '<span class="sql-keyword">$1</span>')
        .replace(/'(.*?)'/g, '<span class="sql-string">\'$1\'</span>')
        .replace(/\b(AVG|SUM|MAX|MIN|COUNT|NOW|CURRENT_TIMESTAMP)\b/g, '<span class="sql-func">$1</span>');

    modalBody.innerHTML = `
        <p style="margin-bottom: 1.5rem; color: var(--text-secondary);">${ex.desc}</p>
        <h4>SQL Solution:</h4>
        <pre><code>${highlightedSql}</code></pre>
    `;
    
    modal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
}

closeModal.onclick = () => {
    modal.style.display = 'none';
    document.body.style.overflow = 'auto';
};

window.onclick = (event) => {
    if (event.target == modal) {
        modal.style.display = 'none';
        document.body.style.overflow = 'auto';
    }
};

document.addEventListener('DOMContentLoaded', renderExercises);
