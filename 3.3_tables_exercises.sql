-- 3.
USE employees;

-- 4.
SHOW TABLES;

-- 5. INT, DATE, VARCHAR, VARCHAR, ENUM, DATE
DESCRIBE employees;

DESCRIBE current_dept_emp;
DESCRIBE departments;
DESCRIBE dept_emp;
DESCRIBE dept_emp_latest_date;
DESCRIBE dept_manager;
DESCRIBE employees;
DESCRIBE salaries;
DESCRIBE titles;

-- 6. current_dept_emp, dept_emp, dept_emp_latest_date, employees, salaries

-- 7. current_dept_emp, departments, dept_emp, dept_emp_latest_date, dept_manager, employees, salaries, titles

-- 8. current_dept_emp, dept_emp_latest_date, employees, salaries

-- 9. By their contents alone, they are not directly related. But, there is a dept_emp table that relates
-- an employees's emp_no to the employee's dept_no
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM dept_emp;

-- 10. 
SHOW CREATE TABLE dept_manager;