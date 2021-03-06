USE world;

-- Take a peek
DESCRIBE city;
SELECT 
    *
FROM
    city
LIMIT 5;
SELECT 
    *
FROM
    country
LIMIT 5;
SELECT 
    *
FROM
    countrylanguage
LIMIT 5;

-- What languages are spoken in Santa Monica?
SELECT 
    Language, Percentage
FROM
    countrylanguage
WHERE
    CountryCode = (SELECT 
            CountryCode
        FROM
            city
        WHERE
            Name = 'Santa Monica')
ORDER BY Percentage;

-- How many different countries are in each region?
SELECT 
    Region, COUNT(*) AS num_countries
FROM
    country
GROUP BY Region
ORDER BY num_countries;

-- What is the population for each region?
SELECT 
    Region, SUM(population) AS population
FROM
    country
GROUP BY Region
ORDER BY population DESC;

-- What is the population for each continent?
SELECT 
    Continent, SUM(Population)
FROM
    country
GROUP BY Continent
ORDER BY SUM(Population) DESC;

-- What is the average life expectancy globally?
SELECT 
    AVG(LifeExpectancy)
FROM
    country;

-- What is the average life expectancy for each region, each continent? Sort the results from shortest to longest
SELECT 
    Continent, AVG(LifeExpectancy) AS life_expectancy
FROM
    country
GROUP BY Continent
ORDER BY AVG(LifeExpectancy);
SELECT 
    Region, AVG(LifeExpectancy) AS life_expectancy
FROM
    country
GROUP BY Region
ORDER BY AVG(LifeExpectancy);

-- 5. Using IN, display the country_id and country columns for the following countries:
-- Afghanistan, Bangladesh, and China:
SELECT 
    country_id, country
FROM
    country
WHERE
    country IN ('Afghanistan' , 'Bangladesh', 'China');

-- BONUS
-- Find all the countries whose local name is different from the official name
SELECT 
    Name, LocalName
FROM
    country
WHERE
    Name != LocalName;


USE sakila;

-- 1. Display the first and last names in all lowercase of all the actors.
SELECT 
    LOWER(first_name) AS first_name_lower,
    LOWER(last_name) AS last_name_lower
FROM
    actor;

-- 2. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe."
-- What is one query would you could use to obtain this information?
SELECT 
    actor_id, first_name, last_name
FROM
    actor
WHERE
    first_name = 'Joe';

-- 3. Find all actors whose last name contain the letters "gen":
SELECT 
    *
FROM
    actor
WHERE
    last_name LIKE '%gen%';

-- 4. Find all actors whose last names contain the letters "li". This time,
-- order the rows by last name and first name, in that order.
SELECT 
    *
FROM
    actor
WHERE
    last_name LIKE '%li%'
ORDER BY last_name , first_name;

-- 5. (relates to world database) ^above

-- 6. List the last names of all the actors, as well as how many actors have that last name.
SELECT 
    last_name, COUNT(last_name)
FROM
    actor
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;
 
-- 7. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT 
    last_name, COUNT(last_name)
FROM
    actor
GROUP BY last_name
HAVING COUNT(last_name) >= 2
ORDER BY COUNT(last_name) DESC;

-- 8. You cannot locate the schema of the address table. Which query would you use to re-create it?
SHOW CREATE TABLE address;

-- 9. Use JOIN to display the first and last names, as well as the address, of each staff member.
SELECT 
    staff.first_name,
    staff.last_name,
    address.address,
    address.district,
    city.city,
    country.country
FROM
    staff
        JOIN
    address ON staff.address_id = address.address_id
        JOIN
    city ON address.city_id = city.city_id
        JOIN
    country ON city.country_id = country.country_id;

-- 10. Use JOIN to display the total amount rung up by each staff member in August of 2005.
SELECT 
    staff.first_name, staff.last_name, SUM(payment.amount)
FROM
    staff
        JOIN
    payment ON staff.staff_id = payment.staff_id
WHERE
    payment.payment_date LIKE '2005-08%'
GROUP BY staff.last_name , staff.first_name
ORDER BY SUM(payment.amount) DESC;

-- 11. List each film and the number of actors who are listed for that film.
SELECT 
    film.title, COUNT(film_actor.actor_id) AS number_of_actors
FROM
    film
        JOIN
    film_actor ON film.film_id = film_actor.film_id
GROUP BY film.title
ORDER BY COUNT(film_actor.actor_id) DESC;


-- 12. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT 
    COUNT(inventory_id)
FROM
    inventory
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film
        WHERE
            title = 'Hunchback Impossible');

-- 13. The music of Queen and Kris Kristofferson have seen an unlikely resurgence.
-- As an unintended consequence, films starting with the letters K and Q have also soared in popularity.
-- Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
SELECT 
    film.title, language.name
FROM
    film
        JOIN
    language ON film.language_id = language.language_id
WHERE
    (title LIKE 'K%' OR title LIKE 'Q%')
        AND language.name = 'English';

-- 14. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT 
    actor.first_name, actor.last_name
FROM
    actor
WHERE
    actor.actor_id IN (SELECT 
            film_actor.actor_id
        FROM
            film_actor
                JOIN
            film ON film_actor.film_id = film.film_id
        WHERE
            film.title = 'Alone Trip');

-- 15. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.
SELECT customer.first_name, customer.last_name, customer.email
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON city.city_id = address.city_id
JOIN country ON country.country_id = city.country_id
WHERE country.country = 'Canada';

-- 16. Sales have been lagging among young families, and you wish to target all family movies for a promotion.
-- Identify all movies categorized as famiy films.
SELECT film.title
FROM film
JOIN film_category USING(film_id)
JOIN category USING(category_id)
WHERE category.name = "Family";


-- 17. Write a query to display how much business, in dollars, each store brought in.
SELECT inventory.store_id AS 'Store ID', SUM(payment.amount) AS 'Total Revenue'
FROM inventory
JOIN rental USING(inventory_id)
JOIN payment USING(rental_id)
GROUP BY inventory.store_id;

-- 18. Write a query to display for each store its store ID, city, and country.
SELECT store.store_id AS 'Store ID', city.city AS City, country.country AS Country
FROM store
JOIN address USING(address_id)
JOIN city USING(city_id)
JOIN country USING(country_id);

-- 19. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
SELECT category.name, SUM(payment.amount) AS 'Gross Revenue'
FROM category
JOIN film_category USING(category_id)
JOIN inventory USING(film_id)
JOIN rental USING(inventory_id)
JOIN payment USING(rental_id)
GROUP BY category.name
ORDER BY SUM(payment.amount) DESC
LIMIT 5;

-- MORE BONUS
-- 1. What is the average replacement cost of a film?
SELECT ROUND(AVG(replacement_cost), 2) AS 'Average Replacement Cost'
FROM film;

-- Does this change depending on the rating of the film? Yes, but slightly; the more mature the rating, the higher the price.
SELECT rating AS Rating, ROUND(AVG(replacement_cost), 2) AS 'Average Replacement Cost'
FROM film
GROUP BY rating
ORDER BY ROUND(AVG(replacement_cost), 2);

-- 2. How many different films of each genre are in the database?
SELECT category.name AS Genre, COUNT(*) AS 'Number of Films'
FROM category
JOIN film_category USING(category_id)
JOIN film USING(film_id)
GROUP BY category.name
ORDER BY category.name;

-- 3. What are the 5 frequently rented films?
SELECT film.title, COUNT(rental.rental_id) AS 'Number of Rental'
FROM film
JOIN inventory USING(film_id)
JOIN rental USING(inventory_id)
GROUP BY film.title
ORDER BY COUNT(rental.rental_id) DESC
LIMIT 7;

-- 4. What are the most most profitable films (in terms of gross revenue)?
SELECT film.title AS Film, SUM(payment.amount) AS 'Gross Revenue'
FROM film
JOIN inventory USING(film_id)
JOIN rental USING(inventory_id)
JOIN payment USING(rental_id)
GROUP BY film.title
ORDER BY SUM(payment.amount) DESC
LIMIT 5;

-- 5. Who is the best customer?
SELECT CONCAT(customer.last_name, ', ', customer.first_name) AS Customer, SUM(payment.amount) as Total
FROM customer
JOIN payment USING(customer_id)
GROUP BY customer.customer_id
ORDER BY SUM(payment.amount) DESC
LIMIT 1;

-- 6. Who are the most popular actors (that have appeared in the most films)?
SELECT CONCAT(actor.last_name, ', ', actor.first_name), COUNT(film_actor.film_id) AS 'Total Films'
FROM actor
JOIN film_actor USING(actor_id)
GROUP BY actor.actor_id
ORDER BY COUNT(film_actor.film_id) DESC
LIMIT 5;

-- 7. What are the sales for each store for each month in 2005?
SELECT DATE_FORMAT(payment.payment_date, '%Y-%m') AS MONTH, inventory.store_id AS 'Store ID', SUM(payment.amount) AS Sales
FROM payment
JOIN rental USING(rental_id)
JOIN inventory USING(inventory_id)
WHERE DATE_FORMAT(payment.payment_date, '%Y-%m') LIKE '2005-%'
GROUP BY DATE_FORMAT(payment.payment_date, '%Y-%m'), inventory.store_id;

-- 8. Bonus: Find the film title, customer name, customer phone number, and customer address for all the outstanding DVDs.
SELECT film.title AS 'Film Title', CONCAT(customer.last_name, ', ', customer.first_name) AS Customer, address.phone AS 'Phone', address.address as 'Address', city.city AS 'City', country.country AS 'Country'
FROM film
JOIN inventory USING(film_id)
JOIN rental USING(inventory_id)
JOIN customer USING(customer_id)
JOIN address USING(address_id)
JOIN city USING(city_id)
JOIN country USING(country_id)
WHERE rental.return_date IS NULL;
