USE employees;

-- 1. Find all the employees with the same hire date as employee 101010 using a sub-query. 69 Rows
SELECT 
    emp_no, first_name, last_name, hire_date
FROM
    employees
WHERE
    hire_date = (SELECT 
            hire_date
        FROM
            employees
        WHERE
            emp_no = 101010);

-- 2. Find all the titles held by all employees with the first name Aamod. 314 total titles, 6 unique titles
SELECT 
    title
FROM
    titles
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            first_name = 'Aamod')
GROUP BY title;

-- 3. How many people in the employees table are no longer working for the company?
-- get current employees in subquery and count all employees whose numbers are not in there
SELECT 
    COUNT(emp_no)
FROM
    employees
WHERE
    emp_no NOT IN (SELECT 
            emp_no
        FROM
            dept_emp
        WHERE
            to_date > NOW());

-- 4. Find all the current department managers that are female.
SELECT 
    first_name, last_name
FROM
    employees
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            dept_manager
        WHERE
            to_date > NOW()) AND gender = 'F';

-- 5. Find all the employees that currently have a higher than average salary. 154543 rows in total.
-- find the average salary in a subquery and then select those employees whose salaries are greater than the average
SELECT 
    first_name, last_name, salary
FROM
    employees
        JOIN
    dept_emp ON employees.emp_no = dept_emp.emp_no
        JOIN
    salaries ON salaries.emp_no = dept_emp.emp_no
WHERE
    salary > (SELECT 
            AVG(salaries.salary)
        FROM
            salaries
        -- WHERE
            -- to_date > NOW()
            )
        AND dept_emp.to_date > NOW()
        AND salaries.to_date > NOW();

-- 6. How many current salaries are within 1 standard deviation of the highest salary?
-- (Hint: you can use a built in function to calculate the standard deviation.) 78 salaries
SELECT 
    COUNT(*) AS num_salaries_within_1_stddev_of_highest
FROM
    salaries
WHERE
    salary >= (SELECT 
            MAX(salary) - STDDEV_POP(salary)
        FROM
            salaries)
        AND to_date > NOW();

-- What percentage of all salaries is this?
SELECT COUNT(*) / (SELECT COUNT(*) FROM salaries WHERE to_date > NOW()) * 100 AS percent_salaries_within_1_stddev_of_highest
FROM salaries
WHERE salary >= (SELECT MAX(salary) - STDDEV_POP(salary)
                 FROM salaries)
	  AND to_date > NOW();
-- BONUS

-- 1. Find all the department names that currently have female managers.
SELECT dept_name
FROM departments
WHERE dept_no IN (
	SELECT dept_no
    FROM dept_manager
    WHERE emp_no IN (
		SELECT emp_no
        FROM employees
        WHERE gender = 'F'
    ) AND to_date > NOW()
);

-- 2. Find the first and last name of the employee with the highest salary.
SELECT first_name, last_name
FROM employees
WHERE emp_no = (
	SELECT emp_no
	FROM salaries
	WHERE to_date > NOW()
	ORDER BY salary DESC
	LIMIT 1
);

-- 3. Find the department name that the employee with the highest salary works in.
SELECT dept_name
FROM departments
WHERE dept_no = (
	SELECT dept_no
    FROM dept_emp
    WHERE emp_no = (
		SELECT emp_no
		FROM salaries
		WHERE to_date > NOW()
		ORDER BY salary DESC
		LIMIT 1
    )
);
