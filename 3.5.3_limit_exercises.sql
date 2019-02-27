USE employees;

-- 2. List the first 10 distinct last name sorted in descending order.
SELECT DISTINCT last_name FROM employees ORDER BY last_name DESC LIMIT 10;

-- 3. Find your query for employees born on Christmas and hired in the
-- 90s from order_by_exercises.sql. Update it to find just the first 5 employees.
SELECT * FROM employees WHERE (hire_date LIKE '199%') AND (birth_date LIKE '%-12-25') ORDER BY birth_date, hire_date DESC LIMIT 5;

-- 4. Update the query to find the tenth page of results.
SELECT * FROM employees WHERE (hire_date LIKE '199%') AND (birth_date LIKE '%-12-25') ORDER BY birth_date, hire_date DESC LIMIT 5 OFFSET 45;

-- What is the relationship between OFFSET (number of results to skip),
-- LIMIT (number of results per page), and the page number? offset = (page - 1) x limit