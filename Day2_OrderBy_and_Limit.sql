CREATE TABLE students (
    student_id INT,
    name VARCHAR(50),
    course VARCHAR(30),
    marks INT,
    age INT,
    city VARCHAR(30)
);
INSERT INTO students VALUES
(1, 'Amit', 'Computer Science', 85, 21, 'Chennai'),
(2, 'Neha', 'Computer Science', 92, 22, 'Bangalore'),
(3, 'Rohit', 'Mechanical', 76, 23, 'Hyderabad'),
(4, 'Pooja', 'Electrical', 88, 21, 'Chennai'),
(5, 'Karan', 'Mechanical', 65, 24, 'Pune'),
(6, 'Anjali', 'Computer Science', 90, 22, 'Chennai'),
(7, 'Suresh', 'Electrical', 72, 23, 'Bangalore'),
(8, 'Meena', 'Computer Science', 95, 20, 'Hyderabad'),
(9, 'Ravi', 'Mechanical', 80, 22, 'Chennai'),
(10, 'Divya', 'Electrical', 68, 24, 'Pune'),
(11, 'Arjun', 'Computer Science', 78, 21, 'Bangalore'),
(12, 'Kavya', 'Mechanical', 88, 23, 'Hyderabad');

select * from students order by marks asc;
select * from students order by marks desc;
select distinct course from students;
select name,age from students order by age;
select * from students order by marks desc limit 3;
select * from students where city = "Chennai" order by marks desc;
select distinct city from students;
select * from students where course = "Computer Science" order by marks;
select name,course,marks from students order by course asc, marks desc;
select * from students where course = "Mechanical" order by marks desc limit 2;
select * from students order by marks asc limit 3;
select * from students where city ="Bangalore" order by age desc;
select distinct course from students order by course;
select distinct marks from students order by marks desc limit 1 offset 1;
