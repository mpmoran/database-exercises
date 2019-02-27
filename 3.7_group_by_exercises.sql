USE employees;

-- 2. In your script, use DISTINCT to find the unique titles in the titles table.
SELECT DISTINCT
    title
FROM
    titles;

-- 3. Find your query for employees whose last names start and end with 'E'. Update the query
-- find just the unique last names that start and end with 'E' using GROUP BY.
SELECT 
    last_name
FROM
    employees
WHERE
    last_name LIKE 'e%e'
GROUP BY last_name;

-- 4. Update your previous query to now find unique combinations of first and last name
-- where the last name starts and ends with 'E'. You should get 846 rows.
SELECT 
    last_name, first_name
FROM
    employees
WHERE
    last_name LIKE 'e%e'
GROUP BY last_name, first_name;

-- 5. Find the unique last names with a 'q' but not 'qu'.
SELECT 
    last_name
FROM
    employees
WHERE
    last_name LIKE '%q%'
        AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

-- 6. Erratum from Zach: Which (across all employees) name is the most common, the least common?
-- Find this for both first name: Shahab (most common), Renny and Lech (least common),
-- last name:  Baba (most common), Sadowsky (least common),
-- and the combination of the two: Rosalyn Baalen and Laurentiu Cesareni (most common), many (least common). 3 separate queries
SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name
ORDER BY COUNT(*) DESC;

SELECT 
    last_name, COUNT(first_name)
FROM
    employees
GROUP BY last_name
ORDER BY COUNT(*) DESC;

SELECT 
    first_name, last_name, COUNT(*)
FROM
    employees
GROUP BY first_name , last_name
ORDER BY COUNT(*) DESC;

-- 7. Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to
-- find the number of employees for each gender with those names.
SELECT 
    COUNT(*), gender
FROM
    employees
WHERE
    first_name IN ('Irena' , 'Vidya', 'Maya')
GROUP BY gender;

-- 8. Recall the query the generated usernames for the employees from the last lesson. Are there any duplicate usernames? Yes
SELECT 
    LOWER(CONCAT(SUBSTR(first_name, 1, 1),
                    SUBSTR(last_name, 1, 4),
                    '_',
                    SUBSTR(birth_date, 6, 2),
                    SUBSTR(birth_date, 3, 2))) AS username,
    COUNT(*)
FROM
    employees
GROUP BY username
HAVING
	COUNT(*) > 1
ORDER BY COUNT(*) DESC;

-- Bonus: how many duplicate usernames are there? 13,251
