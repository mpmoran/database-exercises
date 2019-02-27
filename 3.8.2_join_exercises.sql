-- 1. Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;

SELECT 
    *
FROM
    users;
    
SELECT 
    *
FROM
    roles;

-- 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson.
-- Before you run each query, guess the expected number of results.
SELECT 
    *
FROM
    users
        JOIN
    roles ON users.role_id = roles.id;

SELECT 
    *
FROM
    users
        LEFT JOIN
    roles ON users.role_id = roles.id;

SELECT 
    *
FROM
    users
        RIGHT JOIN
    roles ON users.role_id = roles.id;

SELECT 
    *
FROM
    roles
        LEFT JOIN
    users ON roles.id = users.role_id;

-- 3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries.
-- Use count and the appropriate join type to get a list of roles along with the number of users that has the role.
-- Hint: You will also need to use group by in the query.
SELECT 
    roles.name, COUNT(users.role_id)
FROM
    roles
        LEFT JOIN
    users ON roles.id = users.role_id
GROUP BY roles.name;

-- 1. Use the employees database.
USE employees;

SELECT 
    *
FROM
    dept_manager
LIMIT 5;

SELECT 
    *
FROM
    employees
LIMIT 5;

SELECT 
    *
FROM
    departments
LIMIT 5;

SELECT 
    *
FROM
    titles
LIMIT 5;
SELECT 
    *
FROM
    dept_emp
LIMIT 5;
SELECT 
    *
FROM
    salaries
LIMIT 5;

-- 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department
-- along with the name of the current manager for that department.
SELECT 
    departments.dept_name AS 'Department Name',
    CONCAT(employees.first_name,
            ' ',
            employees.last_name) AS 'Department Manager'
FROM
    departments
        JOIN
    dept_manager ON departments.dept_no = dept_manager.dept_no
        JOIN
    employees ON employees.emp_no = dept_manager.emp_no
WHERE
    dept_manager.to_date = '9999-01-01';

-- 3. Find the name of all departments currently managed by women.
SELECT 
    departments.dept_name AS 'Department Name',
    CONCAT(employees.first_name,
            ' ',
            employees.last_name) AS 'Manager Name'
FROM
    departments
        JOIN
    dept_manager ON departments.dept_no = dept_manager.dept_no
        JOIN
    employees ON employees.emp_no = dept_manager.emp_no
WHERE
    dept_manager.to_date = '9999-01-01'
        AND employees.gender = 'F';

-- 4. Find the current titles of employees currently working in the
-- Customer Service department.
SELECT 
    titles.title AS Title, COUNT(titles.title) AS 'Count'
FROM
    titles
        JOIN
    dept_emp ON titles.emp_no = dept_emp.emp_no
        JOIN
    departments ON departments.dept_no = dept_emp.dept_no
WHERE
    departments.dept_name = 'Customer Service'
        AND titles.to_date = '9999-01-01'
        AND dept_emp.to_date = '9999-01-01'
GROUP BY titles.title;

-- 5. Find the current salary of all current managers.
SELECT 
    departments.dept_name AS 'Department Name',
    CONCAT(employees.first_name,
            ' ',
            employees.last_name) AS 'Department Manager',
    salaries.salary AS 'Salary'
FROM
    departments
        JOIN
    dept_manager ON departments.dept_no = dept_manager.dept_no
        JOIN
    salaries ON salaries.emp_no = dept_manager.emp_no
        JOIN
    employees ON employees.emp_no = salaries.emp_no
WHERE
    dept_manager.to_date = '9999-01-01'
        AND salaries.to_date = '9999-01-01';

-- 6. Find the number of employees in each department.
SELECT 
    departments.dept_no,
    departments.dept_name,
    COUNT(dept_emp.emp_no)
FROM
    departments
        JOIN
    dept_emp ON departments.dept_no = dept_emp.dept_no
WHERE
    dept_emp.to_date = '9999-01-01'
GROUP BY departments.dept_no, departments.dept_name;

-- 7. Which department has the highest average salary?
SELECT 
    departments.dept_name,
    AVG(salaries.salary) AS average_salary
FROM
    departments
        JOIN
    dept_emp ON departments.dept_no = dept_emp.dept_no
        JOIN
    salaries ON salaries.emp_no = dept_emp.emp_no
WHERE
    salaries.to_date = '9999-01-01'
        AND dept_emp.to_date = '9999-01-01'
GROUP BY departments.dept_name
ORDER BY average_salary DESC
LIMIT 1;

-- 8. Who is the highest paid employee in the Marketing department?
SELECT 
    employees.first_name, employees.last_name
FROM
    employees
        JOIN
    dept_emp ON employees.emp_no = dept_emp.emp_no
        JOIN
    departments ON departments.dept_no = dept_emp.dept_no
        JOIN
    salaries ON salaries.emp_no = dept_emp.emp_no
WHERE
    departments.dept_name = 'Marketing'
        AND dept_emp.to_date = '9999-01-01'
        AND salaries.to_date = '9999-01-01'
ORDER BY salaries.salary DESC
LIMIT 1;

-- 9. Which current department manager has the highest salary?
SELECT 
    employees.first_name,
    employees.last_name,
    salaries.salary,
    departments.dept_name
FROM
    departments
        JOIN
    dept_manager ON departments.dept_no = dept_manager.dept_no
        JOIN
    employees ON employees.emp_no = dept_manager.emp_no
        JOIN
    salaries ON salaries.emp_no = dept_manager.emp_no
WHERE
    dept_manager.to_date = '9999-01-01'
        AND salaries.to_date = '9999-01-01'
ORDER BY salaries.salary DESC
LIMIT 1;

-- 10. Bonus Find the names of all current employees, their department name,
-- and their current manager's name.
-- ** MY ORDER IS DIFFERENT
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name',
    departments.dept_name AS 'Department Name',
    CONCAT(m.first_name, ' ', m.last_name) AS 'Manager Name'
FROM
    employees AS e
        JOIN
    dept_emp ON e.emp_no = dept_emp.emp_no
        JOIN
    departments ON departments.dept_no = dept_emp.dept_no
        JOIN
    dept_manager ON dept_manager.dept_no = dept_emp.dept_no
        JOIN
    employees AS m ON m.emp_no = dept_manager.emp_no
WHERE
    dept_emp.to_date = '9999-01-01'
        AND dept_manager.to_date = '9999-01-01';

-- 11. Bonus Find the highest paid employee in each department.
SELECT 
    CONCAT(employees.first_name,
            ' ',
            employees.last_name) AS 'Employee Name',
    employees.emp_no,
    departments.dept_name AS 'Department Name',
    salaries.salary AS Salary
FROM
    employees
        JOIN
    dept_emp ON employees.emp_no = dept_emp.emp_no
        JOIN
    departments ON departments.dept_no = dept_emp.dept_no
        JOIN
    salaries ON salaries.emp_no = dept_emp.emp_no
WHERE
    (dept_emp.dept_no, salaries.salary) IN (SELECT 
            departments.dept_no, MAX(salaries.salary)
        FROM
            departments
                JOIN
            dept_emp ON departments.dept_no = dept_emp.dept_no
                JOIN
            salaries ON salaries.emp_no = dept_emp.emp_no
        WHERE
            salaries.to_date = '9999-01-01'
                AND dept_emp.to_date = '9999-01-01'
        GROUP BY departments.dept_no)
        AND salaries.to_date = '9999-01-01'
        AND dept_emp.to_date = '9999-01-01';
