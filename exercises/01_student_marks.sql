-- 1. Create student and studentmark table
-- Find average using aggregate functions and joins.

CREATE TABLE student (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50)
);

CREATE TABLE studentmark (
    mark_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject VARCHAR(50),
    marks INT,
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);

-- Sample Data
INSERT INTO student VALUES (1, 'Dilip', 'CSE'), (2, 'Kumar', 'ECE');
INSERT INTO studentmark (student_id, subject, marks) VALUES 
(1, 'DBMS', 85), (1, 'OS', 90), 
(2, 'DBMS', 75), (2, 'OS', 80);

-- Average Marks using Join
SELECT s.name, AVG(m.marks) as average_marks
FROM student s
JOIN studentmark m ON s.student_id = m.student_id
GROUP BY s.student_id;
