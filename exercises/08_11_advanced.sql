-- 8. Student, Enroll, Course (Joins)
---------------------------------------------------
-- CREATE STUDENT TABLE
---------------------------------------------------

CREATE TABLE student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    department VARCHAR(50)
);

---------------------------------------------------
-- CREATE COURSE TABLE
---------------------------------------------------

CREATE TABLE course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50)
);

---------------------------------------------------
-- CREATE ENROLL TABLE
---------------------------------------------------

CREATE TABLE enroll (
    enroll_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

---------------------------------------------------
-- INSERT SAMPLE DATA
---------------------------------------------------

INSERT INTO student VALUES
(1, 'Arun', 'CSE'),
(2, 'Bala', 'IT'),
(3, 'Charan', 'ECE');

INSERT INTO course VALUES
(101, 'DBMS'),
(102, 'Java'),
(103, 'Python');

INSERT INTO enroll VALUES
(1001, 1, 101),
(1002, 1, 102),
(1003, 2, 103);

---------------------------------------------------
-- INNER JOIN
-- Shows matching records only
---------------------------------------------------

SELECT 
    student.student_name,
    course.course_name
FROM enroll
INNER JOIN student
ON enroll.student_id = student.student_id
INNER JOIN course
ON enroll.course_id = course.course_id;

---------------------------------------------------
-- LEFT JOIN
-- Shows all students even if not enrolled
---------------------------------------------------

SELECT 
    student.student_name,
    course.course_name
FROM student
LEFT JOIN enroll
ON student.student_id = enroll.student_id
LEFT JOIN course
ON enroll.course_id = course.course_id;

---------------------------------------------------
-- RIGHT JOIN
-- Shows all courses even if no students enrolled
---------------------------------------------------

SELECT 
    student.student_name,
    course.course_name
FROM enroll
RIGHT JOIN course
ON enroll.course_id = course.course_id
LEFT JOIN student
ON enroll.student_id = student.student_id;

---------------------------------------------------
-- FULL OUTER JOIN
-- MySQL does not support FULL JOIN directly
-- Use UNION of LEFT JOIN and RIGHT JOIN
---------------------------------------------------

SELECT 
    student.student_name,
    course.course_name
FROM student
LEFT JOIN enroll
ON student.student_id = enroll.student_id
LEFT JOIN course
ON enroll.course_id = course.course_id

UNION

SELECT 
    student.student_name,
    course.course_name
FROM enroll
RIGHT JOIN course
ON enroll.course_id = course.course_id
LEFT JOIN student
ON enroll.student_id = student.student_id;

---------------------------------------------------
-- DISPLAY TABLES
---------------------------------------------------

SELECT * FROM student;
SELECT * FROM course;
SELECT * FROM enroll;
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
