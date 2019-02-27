USE mysql;

-- Write a query that shows all the information in the `help_topic` table in the
-- `mysql` database. How could you write a query to search for a specific help
-- topic?
SELECT * FROM help_topic;

SELECT * FROM help_topic WHERE name = "INT";

-- Take a look at the information in the salaries table in the employees
-- database. What do you notice? There are two private keys; salary is an int, not a float
USE employees;

SHOW TABLES;

SELECT * FROM salaries;

DESCRIBE salaries;

-- Explore the `sakila` database. What do you think this database represents? An inventory and tracking system for movie rentals
-- What kind of company might be using this database? A video rental store
USE sakila;

SHOW TABLES;

-- write a query that shows all the columns from the `actors` table
DESCRIBE actor;

-- write a query that only shows the last name of the actors from the
-- `actors` table
SELECT last_name FROM actor;

-- Write a query that displays the title, description, rating, movie length
-- columns from the `films` table for films that last 3 hours or longer.
DESCRIBE film;
SELECT title, description, rating, length FROM film WHERE length > 180;

-- Select the payment id, amount, and payment date columns from the payments
-- table for payments made on or after 05/27/2005.
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date >= "2005-05-27 00:00:00";

-- Select the primary key (payment_id), amount, and payment date columns from the payment
-- table for payments made on 05/27/2005.
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date > "2005-05-26 23:59:59" AND payment_date < "2005-05-28 00:00:00";