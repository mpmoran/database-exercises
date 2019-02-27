-- 1.
USE employees;

-- 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya'
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya');

-- 3. Find all employees whose last name starts with 'E'
SELECT * FROM employees WHERE last_name LIKE 'E%';

-- 4. Find all employees hired in the 90s
SELECT * FROM employees WHERE hire_date LIKE '199%';

-- 5. Find all employees born on Christmas
SELECT * FROM employees WHERE birth_date LIKE '%-12-25';

-- 6. Find all employees with a 'q' in their last name
SELECT * FROM employees WHERE last_name LIKE '%q%';

-- 1. Update your query for 'Irena', 'Vidya', or 'Maya' to use OR instead of IN
SELECT * FROM employees WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';

-- 2. Add a condition to the previous query to find everybody with those names who is also male
SELECT * FROM employees WHERE 
(first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya') AND gender = 'M';

-- 3. Find all employees whose last name starts or ends with 'E'
SELECT * FROM employees WHERE last_name LIKE 'E%' OR last_name LIKE '%e';

-- 4. Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E'
SELECT * FROM employees WHERE last_name LIKE 'E%e';

-- 5. Find all employees hired in the 90s and born on Christmas
SELECT * FROM employees WHERE (hire_date LIKE '199%') AND (birth_date LIKE '%-12-25');

-- 6. Find all employees with a 'q' in their last name but not 'qu'
SELECT * FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';