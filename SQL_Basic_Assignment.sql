/* Question 1:
Write the SQL query to create the employees table.*/

CREATE TABLE employees (
    emp_id INT NOT NULL PRIMARY KEY,
    emp_name VARCHAR(255) NOT NULL,
    age INT CHECK (age >= 18),
    email VARCHAR(255) UNIQUE,
    salary DECIMAL(10, 2) DEFAULT 30000.00
);

/* Question 2:
Explain the purpose of constraints and how they help 
maintain data integrity in a database. Provide examples of 
common types of constraints.

ANS.

Constraints ensure data integrity and accuracy by 
restricting the type of data that can be entered into a 
table. They prevent invalid data entry, enforce rules at 
the database level, and maintain relationships between 
tables.

Examples:

NOT NULL: Ensures a column cannot have NULL values 
(e.g., emp_name).
UNIQUE: Ensures all values in a column are unique 
(e.g., email).
PRIMARY KEY: Combines NOT NULL and UNIQUE; uniquely 
identifies a record in a table.
FOREIGN KEY: Enforces a relationship between tables.
CHECK: Validates data based on a condition 
(e.g., age >= 18).
DEFAULT: Sets a default value if none is provided 
(e.g., salary).

Question 3:

Why would you apply the NOT NULL constraint to a column? 
Can a primary key contain NULL values? Justify your answer.

Answer:

NOT NULL Constraint:

This constraint ensures that a column must always have a 
value and cannot be left empty. It is used when data for 
a column is mandatory for the integrity of the record. 
For example, in the employees table, emp_name must not be 
NULL as every employee should have a name.

Primary Key and NULL Values:

A primary key cannot contain NULL values because it uniquely
identifies a record in a table. Allowing NULL values would 
mean that some rows might not have an identifier, breaking 
the uniqueness rule.

Example: If emp_id is the primary key and contains NULL, 
multiple rows could have NULL, making it impossible to 
uniquely identify records.

Question 4:
Explain the steps and SQL commands used to add or remove 
constraints on an existing table. Provide an example for 
both adding and removing a constraint.

Answer:

Adding a Constraint:

Use the ALTER TABLE statement with ADD CONSTRAINT.

Example: Adding a foreign key constraint. */

ALTER TABLE orders
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

/* Removing a Constraint:
Use the ALTER TABLE statement with DROP CONSTRAINT.

 example: Dropping a unique constraint. */

ALTER TABLE employees
DROP CONSTRAINT unique_email;

/* Question 5:

Explain the consequences of attempting to insert, update, 
or delete data in a way that violates constraints. 
Provide an example of an error message that might occur 
when violating a constraint.

Answer:

When a constraint is violated, the database prevents the 
operation, ensuring data integrity.

Insert Violation:

Attempting to insert a record that violates constraints 
will result in an error.

Example: Violating a NOT NULL constraint.
*/

INSERT INTO employees (emp_id, emp_name) VALUES (101, NULL);

-- Error: ERROR: Column 'emp_name' cannot be NULL.

-- Update Violation:
-- Attempting to update data that breaks constraints will also fail.

-- Example: Violating a CHECK constraint.

UPDATE employees SET age = 15 WHERE emp_id = 101;

/* Error: ERROR: Check constraint 'age_check' is violated.

Delete Violation:

Deleting data referenced by a foreign key without using 
ON DELETE CASCADE leads to errors.

Example: Deleting a parent row in a referenced table.
*/

DELETE FROM customers WHERE customer_id = 1;

/* Error: ERROR: Cannot delete or update a parent row: 
foreign key constraint fails.

Question 6:

You created a products table without constraints. Now, add 
the following constraints:

product_id should be a primary key.
price should have a default value of 50.00.
*/
-- Adding the primary key constraint 

ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);

-- Adding the default value constraint

ALTER TABLE products
MODIFY COLUMN price DECIMAL(10, 2) DEFAULT 50.00;

/* Question 7:

Write a query to fetch the student_name and class_name for
each student using an INNER JOIN.
*/

SELECT students.student_name, classes.class_name
FROM students
INNER JOIN classes ON students.class_id = classes.class_id;

/* Question 8:

Write a query that shows all order_id, customer_name, and 
product_name, ensuring all products are listed even if they 
are not associated with an order. */

SELECT orders.order_id, customers.customer_name, products.product_name
FROM products
LEFT JOIN orders ON products.product_id = orders.product_id
LEFT JOIN customers ON orders.customer_id = customers.customer_id;

/* Question 9:

Write a query to find the total sales amount for each 
product using an INNER JOIN and the SUM() function. */

SELECT products.product_name, SUM(orders.quantity * products.price) AS total_sales
FROM orders
INNER JOIN products ON orders.product_id = products.product_id
GROUP BY products.product_name;

/* Question 10:

Write a query to display the order_id, customer_name, and 
the quantity of products ordered by each customer using an 
INNER JOIN between all three tables.
*/

SELECT orders.order_id, customers.customer_name, SUM(orders.quantity) AS total_quantity
FROM orders
INNER JOIN customers ON orders.customer_id = customers.customer_id
INNER JOIN products ON orders.product_id = products.product_id
GROUP BY orders.order_id, customers.customer_name;

/* SQL Commands

1-Identify the primary keys and foreign keys in maven movies 
db. Discuss the differences
*/
 
SELECT TABLE_NAME, COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'mavenmovies';

/*
Discussion:
Primary Key: Uniquely identifies each record in a table. 
Cannot contain NULL values.

Foreign Key: Links two tables and enforces referential 
integrity by pointing to a primary key in another table.
*/

-- Q2. List all details of actors:

USE mavenmovies;
SELECT * FROM actor;

-- Q3 List all customer information from the database:

USE mavenmovies;
SELECT * FROM customer;

-- Q4 List different countries:

USE mavenmovies;
SELECT DISTINCT country FROM country;

-- Q5 Display all active customers:

USE mavenmovies;
SELECT * FROM customer WHERE active = 1;

-- Q6 List all rental IDs for customer with ID 1:

USE mavenmovies;
SELECT rental_id FROM rental WHERE customer_id = 1;

-- Q7 Display all the films whose rental duration is greater than 5:

USE mavenmovies;
SELECT * FROM film WHERE rental_duration > 5;

-- Q8 List the total number of films whose replacement cost is greater than $15 and less than $20:

USE mavenmovies;
SELECT COUNT(*) AS total_films 
FROM film
WHERE replacement_cost BETWEEN 15 AND 20;

-- Q9 Display the count of unique first names of actors:

USE mavenmovies;
SELECT COUNT(DISTINCT first_name) AS unique_first_names 
FROM actor;

-- Q10 Display the first 10 records from the customer table:

USE mavenmovies;
SELECT * FROM customer LIMIT 10;

-- Q11 Display the first 3 records from the customer table whose first name starts with 'b':

USE mavenmovies;
SELECT * FROM customer 
WHERE first_name LIKE 'b%' 
LIMIT 3;

-- Q12 Display the names of the first 5 movies which are rated as 'G':

USE mavenmovies;
SELECT title 
FROM film
WHERE rating = 'G' 
LIMIT 5;

-- Q13. Find all customers whose first name starts with "a":

USE mavenmovies;
SELECT * FROM customer WHERE first_name LIKE 'a%';

-- Q14. Find all customers whose first name ends with "a":

USE mavenmovies;
SELECT * FROM customer WHERE first_name LIKE '%a';

-- Q15. Display the list of the first 4 cities that start and end with ‘a’:

USE mavenmovies;
SELECT city 
FROM city 
WHERE city LIKE 'a%' AND city LIKE '%a' 
LIMIT 4;

-- Q16. Find all customers whose first name has "NI" in any position:

USE mavenmovies;
SELECT * FROM customer WHERE first_name LIKE '%NI%';

-- Q17. Find all customers whose first name has "r" in the second position:

USE mavenmovies;
SELECT * FROM customer WHERE first_name LIKE '_r%';

-- Q18. Find all customers whose first name starts with "a" and is at least 5 characters in length:

USE mavenmovies;
SELECT * FROM customer 
WHERE first_name LIKE 'a%' AND LENGTH(first_name) >= 5;

-- Q19. Find all customers whose first name starts with "a" and ends with "o":

USE mavenmovies;
SELECT * FROM customer WHERE first_name LIKE 'a%o';

-- Q20. Get the films with PG and PG-13 rating using the IN operator:

USE mavenmovies;
SELECT * FROM film WHERE rating IN ('PG', 'PG-13');

-- Q21. Get the films with a length between 50 and 100 using the BETWEEN operator:

USE mavenmovies;
SELECT * FROM film WHERE length BETWEEN 50 AND 100;

-- Q22. Get the top 50 actors using the LIMIT operator:

USE mavenmovies;
SELECT * FROM actor LIMIT 50;

-- Q23. Get the distinct film IDs from the inventory table:

USE mavenmovies;
SELECT DISTINCT film_id FROM inventory;


-- Aggregate Functions

-- Q1: Retrieve the total number of rentals made in the Sakila database.

USE mavenmovies;
SELECT COUNT(*) AS total_rentals FROM rental;

-- Q2: Find the average rental duration (in days) of movies rented from the Sakila database.

USE mavenmovies;
SELECT ROUND(AVG(rental_duration),2) AS average_rental_duration_In_Days 
FROM film;

-- String Functions

-- Q3: Display the first name and last name of customers in uppercase.

USE mavenmovies;
SELECT UPPER(first_name) AS first_name_upper,
 UPPER(last_name) AS last_name_upper FROM customer;

-- Q4: Extract the month from the rental date and display it alongside the rental ID.

USE mavenmovies;
SELECT rental_id, MONTH(rental_date) AS rental_month FROM rental;

-- GROUP BY

-- Q5: Retrieve the count of rentals for each customer (display customer ID and the count of rentals).

USE mavenmovies;
SELECT customer_id, COUNT(*) AS rental_count 
FROM rental
GROUP BY customer_id;

-- Q6: Find the total revenue generated by each store.

USE mavenmovies;
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id;

-- Q7: Determine the total number of rentals for each category of movies.

USE mavenmovies;
SELECT category.name AS category_name, COUNT(rental.rental_id) AS rental_count
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name;


-- Q8: Find the average rental rate of movies in each language.

USE mavenmovies;
SELECT language.name AS language_name, 
AVG(film.rental_rate) AS average_rental_rate
FROM film
JOIN language ON film.language_id = language.language_id
GROUP BY language.name;

-- Joins

-- Q9: Display the title of the movie, customer’s first name, and last name who rented it.

USE mavenmovies;
SELECT film.title, customer.first_name, customer.last_name
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN customer ON rental.customer_id = customer.customer_id;

-- Q10: Retrieve the names of all actors who have appeared in the film "Gone with the Wind."

USE mavenmovies;
SELECT actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = "Gone with the Wind";

-- Q11: Retrieve the customer names along with the total amount they've spent on rentals.

USE mavenmovies;
SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS total_spent
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id;

-- Q12: List the titles of movies rented by each customer in a particular city (e.g., 'London').

USE mavenmovies;
SELECT 
    customer.first_name, 
    customer.last_name, 
    city.city AS customer_city, 
    GROUP_CONCAT(film.title SEPARATOR ', ') AS movie_titles
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN customer ON rental.customer_id = customer.customer_id
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
GROUP BY customer.first_name, customer.last_name, city.city_id;

-- Advanced Joins and GROUP BY

-- Q13: Display the top 5 rented movies along with the number of times they've been rented.

USE mavenmovies;
SELECT film.title, COUNT(rental.rental_id) AS rental_count
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY rental_count DESC
LIMIT 5;

-- Q14: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).

USE mavenmovies;
SELECT 
    customer.customer_id, 
    customer.first_name, 
    customer.last_name
FROM rental
JOIN customer ON rental.customer_id = customer.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN store ON inventory.store_id = store.store_id
WHERE store.store_id IN (1, 2)
GROUP BY customer.customer_id;


-- Window Functions
 
-- Q1: Rank the customers based on the total amount they've spent on rentals.

USE mavenmovies;
SELECT customer.customer_id, customer.first_name, customer.last_name,
       SUM(payment.amount) AS total_spent
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY total_spent DESC;

-- Q2: Calculate the cumulative revenue generated by each film over time.

USE mavenmovies;
SELECT 
    film.title, 
    payment.payment_date, 
    SUM(payment.amount) OVER (PARTITION BY film.film_id ORDER BY payment.payment_date) AS cumulative_revenue
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
ORDER BY film.title, payment.payment_date;


-- Q3: Determine the average rental duration for each film, considering films with similar lengths.

USE mavenmovies;
SELECT 
    title,
    length,
    AVG(rental_duration) OVER (PARTITION BY length) AS avg_rental_duration
FROM film;

-- Q4: Identify the top 3 films in each category based on their rental counts.

SELECT 
    fc.category_id, 
    f.title, 
    COUNT(r.rental_id) AS rental_count
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    inventory i ON i.film_id = f.film_id -- Join inventory table to get the film_id
JOIN 
    rental r ON r.inventory_id = i.inventory_id -- Join rental table on inventory_id
GROUP BY 
    fc.category_id, f.film_id
ORDER BY 
    fc.category_id, rental_count DESC;


-- Q5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.

SELECT customer_id, COUNT(rental_id) AS total_rentals,
       COUNT(rental_id) - AVG(COUNT(rental_id)) OVER () AS rental_diff
FROM rental
GROUP BY customer_id;

-- 6. Find the monthly revenue trend for the entire rental store over time.

USE mavenmovies;
SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month, 
    SUM(amount) AS total_revenue
FROM payment
GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY month;

-- 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.

SELECT customer_id, total_spent
FROM (
    SELECT customer_id, 
           SUM(amount) AS total_spent,
           PERCENT_RANK() OVER (ORDER BY SUM(amount) DESC) AS rank_percentage
    FROM payment
    GROUP BY customer_id
) ranked_customers
WHERE rank_percentage <= 0.2;


-- 8. Calculate the running total of rentals per category, ordered by rental count.

USE mavenmovies;
SELECT 
    c.name AS category_name,
    COUNT(*) AS rental_count,
    SUM(COUNT(*)) OVER (ORDER BY COUNT(*) DESC) AS running_total
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY rental_count DESC;


-- 9. Find the films that have been rented less than the average rental count for their respective categories.

USE mavenmovies;
SELECT 
    title,
    category_name,
    rental_count
FROM (
    SELECT 
        film.title,
        category.name AS category_name,
        COUNT(rental.rental_id) AS rental_count,
        AVG(COUNT(rental.rental_id)) OVER (PARTITION BY category.name) AS avg_rental_count
    FROM rental
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    JOIN film ON inventory.film_id = film.film_id
    JOIN film_category ON film.film_id = film_category.film_id
    JOIN category ON film_category.category_id = category.category_id
    GROUP BY category.name, film.title
) AS subquery
WHERE rental_count < avg_rental_count;


-- 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.

USE mavenmovies;
SELECT month, total_revenue, revenue_rank
FROM (
    SELECT 
        DATE_FORMAT(payment_date, '%Y-%m') AS month, 
        SUM(amount) AS total_revenue,
        RANK() OVER (ORDER BY SUM(amount) DESC) AS revenue_rank
    FROM payment
    GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
) AS RevenueData
WHERE revenue_rank <= 5
ORDER BY total_revenue DESC;


-- Normalisation & CTE

-- 1. First Normal Form (1NF):

-- a. Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF.

-- Current schema violating 1NF
-- actor_award_id | actor_id | first_name | last_name | awards
-- 1              | 5        | John       | Doe       | "Oscar, Emmy"

-- Create the normalized table
CREATE TABLE actor_award_Normalized (
    actor_award_id INT AUTO_INCREMENT PRIMARY KEY,
    actor_id INT NOT NULL,
    award VARCHAR(255) NOT NULL
);

SELECT * FROM actor_award_Normalized;

-- Insert normalized data
/* INSERT INTO actor_award_Normalized (actor_id, award)
VALUES
    (1, 'Oscar'), (1, 'Golden Globe'),
    (2, 'BAFTA'), (2, 'Emmy'),
    (3, 'Oscar'), (3, 'Golden Globe'), (3, 'SAG Award'),
    (4, 'Emmy'), (4, 'BAFTA'),
    (5, 'Oscar'), (5, 'Emmy'),
    (6, 'Golden Globe'), (6, 'BAFTA'), (6, 'SAG Award'),
    -- Continue adding rows until there are 157
*/

-- 2. Second Normal Form (2NF):

 -- a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF, explain the steps to normalize it.

-- `film_category_details` with columns (film_id, category_id, category_name).
-- This violates 2NF because `category_name` depends on `category_id`, not the entire primary key (film_id, category_id).

-- Step 1: Current schema:
-- film_id | category_id | category_name
-- 1       | 10          | "Action"
-- 2       | 20          | "Comedy"

-- Step 2: Normalize by creating a separate table for categories:

CREATE TABLE category_N (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

CREATE TABLE film_category_normalized (
    film_id INT,
    category_id INT,
    PRIMARY KEY (film_id, category_id),
    FOREIGN KEY (category_id) REFERENCES category_N(category_id)
);

-- Step 3: Populate the normalized tables with appropriate data. 

--  3. Third Normal Form (3NF):

 -- a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the steps to normalize the table to 3NF.
 
 -- Step 1: Current schema violating 3NF
-- address_id | address       | district    | city_id
-- 1          | "123 Street"  | "Downtown"  | 101

-- Step 2: Create a city table

CREATE TABLE city_N (
    city_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    city_name VARCHAR(50) NOT NULL,
    district VARCHAR(20) NOT NULL
);

-- Step 3: Modify address table to reference city table

CREATE TABLE address_normalized (
    address_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    address VARCHAR(50) NOT NULL,
    city_id SMALLINT UNSIGNED NOT NULL,
    PRIMARY KEY (address_id),
    FOREIGN KEY (city_id) REFERENCES city_N(city_id)
);

-- Step 4: Populate the normalized tables
-- city: city_id | city_name   | district
-- address_normalized: address_id | address       | city_id

 -- 4. Normalization Process:

-- a. Take a specific table in Sakila and guide through the process of normalizing it from the initial unnormalized form up to at least 2NF.

-- Step 1: Unnormalized table
-- rental_id | customer_id | customer_name | staff_name | staff_id

-- Step 2: Normalize to 2NF (Separate customer and staff details)

CREATE TABLE customer_N (
    customer_id SMALLINT UNSIGNED NOT NULL PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL
);

CREATE TABLE staff_N(
    staff_id SMALLINT UNSIGNED NOT NULL PRIMARY KEY,
    staff_name VARCHAR(50) NOT NULL
);

CREATE TABLE rental_2NF_N (
    rental_id SMALLINT UNSIGNED NOT NULL PRIMARY KEY,
    customer_id SMALLINT UNSIGNED NOT NULL,
    staff_id SMALLINT UNSIGNED NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer_N(customer_id),
    FOREIGN KEY (staff_id) REFERENCES staff_N(staff_id)
);

-- Step 3: Normalize to 3NF (Eliminate any transitive dependencies)
-- Example: If `customer_address` depends on `customer_id`, move it to a separate table.

CREATE TABLE customer_address_N (
    customer_id SMALLINT UNSIGNED NOT NULL,
    address VARCHAR(100),
    FOREIGN KEY (customer_id) REFERENCES customer_N(customer_id)
);

-- 5. CTE Basics:

-- a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have acted in from the actor and film_actor tables.

USE mavenmovies;
WITH ActorFilmCount AS (
    SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id
)
SELECT actor_id, CONCAT(first_name, ' ', last_name) AS actor_name, film_count
FROM ActorFilmCount;


-- 6. CTE with Joins:

-- a. Create a CTE that combines information from the film and language tables to display the film title,language name, and rental rate.

WITH FilmLanguageInfo AS (
    SELECT f.title, l.name AS language_name, f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT * FROM FilmLanguageInfo;

-- 7. CTE for Aggregation:

-- a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from the customer and payment tables.

WITH CustomerRevenue AS (
    SELECT c.customer_id, SUM(p.amount) AS total_revenue
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id
)
SELECT customer_id, total_revenue FROM CustomerRevenue;

-- 8. CTE with Window Functions:

-- a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.

WITH FilmRankings AS (
    SELECT film_id, title, rental_duration,
           RANK() OVER (ORDER BY rental_duration DESC) AS `rank`
    FROM film
)
SELECT * 
FROM FilmRankings;

-- 9. CTE and Filtering:

-- a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer table to retrieve additional customer details.

WITH FrequentRenters AS (
    SELECT customer_id, COUNT(*) AS rental_count
    FROM rental
    GROUP BY customer_id
    HAVING rental_count > 2
)
SELECT fr.customer_id, c.first_name, c.last_name
FROM FrequentRenters fr
JOIN customer c ON fr.customer_id = c.customer_id;

-- 10. CTE for Date Calculations:

-- a. Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table

WITH MonthlyRentals AS (
    SELECT DATE_FORMAT(rental_date, '%Y-%m') AS rental_month, COUNT(*) AS rental_count
    FROM rental
    GROUP BY rental_month
)
SELECT * FROM MonthlyRentals;

-- 11. CTE and Self-Join:

-- a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table.

WITH ActorPairs AS (
    SELECT fa1.actor_id AS actor_1, fa2.actor_id AS actor_2, fa1.film_id
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
)
SELECT actor_1, actor_2, film_id FROM ActorPairs;

-- 12. CTE for Recursive Search:


-- a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager,considering the reports_to column


WITH RECURSIVE ManagerHierarchy AS (
    
    SELECT 
        s.staff_id,
        CONCAT(s.first_name, ' ', s.last_name) AS staff_name,
        st.store_id,
        CAST(s.staff_id AS CHAR(100)) AS path
    FROM staff s
    INNER JOIN store st ON s.staff_id = st.manager_staff_id
    WHERE s.staff_id = 2 -- Manager's ID is 2
    
    UNION ALL
    
    SELECT 
        s.staff_id,
        CONCAT(s.first_name, ' ', s.last_name) AS staff_name,
        st.store_id,
        CONCAT(mh.path, '>', s.staff_id) AS path -- Update the hierarchy path
    FROM staff s
    INNER JOIN store st ON s.staff_id = st.manager_staff_id
    INNER JOIN ManagerHierarchy mh ON st.store_id = mh.store_id
    WHERE FIND_IN_SET(s.staff_id, mh.path) = 0 -- Avoid processing duplicates
)
SELECT 
    mh.staff_id,
    mh.staff_name,
    mh.store_id
FROM ManagerHierarchy mh;