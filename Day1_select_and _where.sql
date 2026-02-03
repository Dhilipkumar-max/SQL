use  practice;
CREATE TABLE employees (
    emp_id INT,
    name VARCHAR(50),
    age INT,
    department VARCHAR(20),
    salary INT,
    city VARCHAR(20)
);
INSERT INTO employees VALUES
(1, 'Arun', 25, 'IT', 35000, 'Chennai'),
(2, 'Divya', 30, 'HR', 42000, 'Bangalore'),
(3, 'Ravi', 28, 'IT', 50000, 'Hyderabad'),
(4, 'Sneha', 35, 'Finance', 60000, 'Chennai'),
(5, 'Karthik', 26, 'IT', 30000, 'Coimbatore'),
(6, 'Priya', 29, 'HR', 38000, 'Chennai'),
(7, 'Vijay', 40, 'Finance', 75000, 'Bangalore'),
(8, 'Anitha', 24, 'IT', 28000, 'Hyderabad'),
(9, 'Suresh', 32, 'Sales', 45000, 'Coimbatore'),
(10, 'Meena', 27, 'Sales', 40000, 'Chennai');
-- Question 1
select * from employees;
-- Question 2
select name , salary from employees;
-- Question 3
select * from employees where department = 'IT';
-- Question 4
select * from employees where salary >40000;
-- Question 5
select * from employees where city = 'Chennai';
-- Question 6
select * from employees where age<30;
-- Question 7
select * from employees where department='HR' && city = 'Chennai';
-- Question 8
select * from employees where salary between 30000 and 50000;
-- Question 9
select * from employees where department = 'IT' or department = 'Sales';
-- Question 10
select * from employees where age >= 30;
-- Question 11
select * from employees where department != 'IT';
-- Question 12
select * from employees where salary <35000 and city = 'Hyderabad';
-- Question 13
select * from employees where city ='Bangalore' and salary > 60000;
-- Question 14
select * from employees where age between 25 and 35;
-- Question 15
select * from employees where department='Finance' and salary > 50000;
-- Qestion 16
select * from employees where city = "Chennai" or city ="Coimbatore";
-- Question 17
select * from employees where age != 30;
-- Question 18
select * from employees where salary = 40000;
-- Question 19
select * from employees where age < 28 and department="IT";
-- Question 20:
select * from employees where department ="Sales" and salary < 45000;
