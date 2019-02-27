USE ada_677;

-- 1. Using the example from the lesson, re-create the employees_with_departments table.
CREATE TEMPORARY TABLE employees_with_departments
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no);

-- a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
ALTER TABLE employees_with_departments
ADD full_name VARCHAR(100);

-- b. Update the table so that full name column contains the correct data
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

-- c. Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name, DROP COLUMN last_name;

-- d. What is another way you could have ended up with this same table?
-- When creating the table, I could have made the column that concatenated the first and last names in a single column.

-- 2. Create a temporary table based on the payments table from the sakila database.
-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment.
-- For example, 1.99 should become 199.
CREATE TEMPORARY TABLE sakila_payments
SELECT payment_id, customer_id, staff_id, rental_id, CAST(amount * 100 AS SIGNED) AS amount, payment_date, last_update
FROM sakila.payment
LIMIT 100;

-- 3. Find out how the average pay in each department compares to the overall average pay.
-- In order to make the comparison easier, you should use the Z-score for salaries.
-- In terms of salary, what is the best department to work for? Sales The worst? Human Resources
CREATE TABLE employee_salary
SELECT emp_no, dept_no, salary
FROM employees.salaries
JOIN employees.dept_emp USING(emp_no)
WHERE employees.salaries.to_date > NOW()
	  AND employees.dept_emp.to_date > NOW();
      
-- DROP TABLE employee_salary;

CREATE TABLE employee_salary_zscore
SELECT emp_no, dept_no, (salary - (SELECT AVG(salary) FROM employee_salary)) / (SELECT STDDEV_SAMP(salary) FROM employee_salary) AS z_score_salary
FROM employee_salary;

-- DROP TABLE employee_salary_zscore;

-- the answer
SELECT employees.departments.dept_name, AVG(employee_salary_zscore.z_score_salary) AS salary_z_score
FROM employee_salary_zscore
JOIN employees.departments USING(dept_no)
GROUP BY employee_salary_zscore.dept_no
ORDER BY AVG(employee_salary_zscore.z_score_salary) DESC;

-- 4. What is the average salary for an employee based on the number of years they have been with the company?
-- Express your answer in terms of the Z-score of salary.
-- Since this data is a little older, scale the years of experience by subtracting the minumum from every row.

CREATE TABLE employee_salary_tenure_years
SELECT emp_no, hire_date, ROUND(DATEDIFF((SELECT MAX(hire_date) FROM employees.employees), hire_date) / 365.25) AS years, salary
FROM employees.employees
JOIN employees.salaries USING(emp_no)
JOIN employees.dept_emp ON employees.dept_emp.emp_no = employees.employees.emp_no
WHERE employees.salaries.to_date > NOW()
      AND employees.dept_emp.to_date > NOW();

-- DROP TABLE employee_salary_tenure_years;

CREATE TABLE employee_salary_tenure_z_score
SELECT years, (salary - (SELECT AVG(salary) FROM employee_salary_tenure_years)) / (SELECT STDDEV_POP(salary) FROM employee_salary_tenure_years) AS salary_z_score
FROM employee_salary_tenure_years;

-- DROP TABLE employee_salary_tenure_z_score;

SELECT years, AVG(salary_z_score)
FROM employee_salary_tenure_z_score
GROUP BY years;
