SELECT department, COUNT(employee_id) AS total_staff, AVG(salary)
FROM employees
GROUP BY department
HAVING AVG(salary) > 40000;
