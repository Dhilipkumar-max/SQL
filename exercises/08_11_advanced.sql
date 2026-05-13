-- 8. Student, Enroll, Course (Joins)
CREATE TABLE students (s_id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE courses (c_id INT PRIMARY KEY, title VARCHAR(50));
CREATE TABLE enroll (s_id INT, c_id INT);

SELECT s.name, c.title FROM students s INNER JOIN enroll e ON s.s_id = e.s_id INNER JOIN courses c ON e.c_id = c.c_id;
SELECT s.name, e.c_id FROM students s LEFT JOIN enroll e ON s.s_id = e.s_id;
SELECT e.s_id, c.title FROM enroll e RIGHT JOIN courses c ON e.c_id = c.c_id;

-- 9. Salary Management (Triggers)
CREATE TABLE employees (emp_id INT PRIMARY KEY, salary DECIMAL(10,2));
CREATE TABLE sal_history (emp_id INT, old_sal DECIMAL(10,2), new_sal DECIMAL(10,2));

CREATE TRIGGER sal_update BEFORE UPDATE ON employees FOR EACH ROW
BEGIN
    INSERT INTO sal_history VALUES (OLD.emp_id, OLD.salary, NEW.salary);
END;

-- 10. Airline Reservation System (Triggers)
CREATE TABLE flights (f_id INT PRIMARY KEY, capacity INT, booked INT);
CREATE TRIGGER check_flight_cap BEFORE INSERT ON tickets FOR EACH ROW
BEGIN
    IF (SELECT booked FROM flights WHERE f_id = NEW.f_id) >= (SELECT capacity FROM flights WHERE f_id = NEW.f_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Flight Full';
    END IF;
END;

-- 11. Views and Indexes
CREATE VIEW active_students AS SELECT * FROM students WHERE s_id IN (SELECT s_id FROM enroll);
CREATE INDEX idx_student_name ON students(name);
