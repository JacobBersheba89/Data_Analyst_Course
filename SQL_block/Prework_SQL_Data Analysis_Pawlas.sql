-- SQL basics
SELECT * 
FROM sakila12_85.inventory;

SELECT * 
FROM sakila12_85.actor
ORDER BY first_name, last_name;

SELECT 
    col_name_1,
    col_name_2
FROM sakila12_85
ORDER BY 
    col_name_1 ASC, 
    col_name_2 DESC, 
    col_name_3;

-- AND operator, OR operator
SELECT *
FROM sakila12_85.film
where length > 60 AND rating = 'NC-17'
--
SELECT *
FROM sakila12_85.film
WHERE length > 20 AND (rating = 'NC-17' OR rating = 'G');
--
SELECT *
FROM sakila12_85.film
where length > 50 XOR rating = 'G'



-- DISTINCT, používá se k načtení jedinečných řádků z tabulky
-- list of one unique parametr 
SELECT DISTINCT first_name
FROM sakila12_85.actor
--
SELECT DISTINCT last_name
FROM sakila12_85.actor
--
SELECT DISTINCT last_update
FROM sakila12_85.actor
--
SELECT DISTINCT last_name
FROM sakila12_85.actor
--
SELECT DISTINCT name
FROM sakila12_85.category
--
SELECT DISTINCT city
FROM sakila12_85.city
--...... & list of two or more unique parametrs 
SELECT DISTINCT 
    address,
    district,
    postal_code
    phone,

FROM sakila12_85.address

--LIMIT, limit the result of the query or parameters
SELECT DISTINCT first_name
FROM sakila12_85.actor
LIMIT 5
--
SELECT DISTINCT 
    first_name,
    last_name,
    store_id
FROM sakila12_85.customer
LIMIT 25

-- use more parameters as SELECT, DISTINCT, WHERE, ORDER BY, LIMIT

SELECT DISTINCT title
FROM sakila12_85.film_analytics
WHERE actors = 5 -- find title with 5 actors
ORDER BY title ASC


--ADVANCED filtering
SELECT *
FROM sakila12_85.film
WHERE 
    (rental_rate = 0.99 
    AND rating = 'G') 
    OR special_features = 'Trailers'

-- from difrent databse
SELECT *
FROM financial12_85.client
WHERE district_id = '21 Tabor' AND gender = 'F';

-- and connection of other raw from diferent table


--NOT
SELECT *
FROM sakila12_85.film
WHERE 
    NOT (rental_rate = 0.99 
    AND rating = 'G')
    OR special_features = 'Trailers' 

--
SELECT *
FROM sakila12_85.film
WHERE True  -- an artificial creation for the purpose of forcing the use of a logical conjunction
    AND rental_rate = 0.99 
    AND rating = 'G' 
    OR special_features = 'Trailers' 

--NULL
SELECT *
FROM sakila12_85.address
WHERE address2 IS NULL
--
SELECT *
FROM sakila12_85.address
WHERE address2 IS NOT NULL

--CREATING OF TABLES
CREATE TABLE IF NOT EXISTS actor_nick AS
SELECT *
FROM sakila12_85.actor
WHERE first_name = 'NICK'
--
DROP TABLE IF EXISTS tmp_actor_nick;
CREATE TEMPORARY TABLE tmp_actor_nick AS
SELECT *
FROM sakila12_85.actor
WHERE first_name = 'NICK'



