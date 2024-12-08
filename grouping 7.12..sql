SELECT 
COUNT(*) as rows_amount 
FROM sakila12_85.payment;

SELECT
    customer_id,
    SUM(amount) AS amount
FROM sakila12_85.payment
WHERE amount > 1
GROUP BY customer_id
HAVING SUM(amount) > 50
ORDER BY amount ASC;

SELECT SUM(amount) AS total_income
FROM sakila12_85.payment;

SELECT customer_id, SUM(amount) AS total
FROM sakila12_85.payment
GROUP BY customer_id
HAVING SUM(amount) > 100;

SELECT CONCAT('€ ', FORMAT(SUM(amount), 2)) AS total_income
FROM sakila12_85.payment;

SELECT CONCAT('€ ', FORMAT(SUM(amount), 2)), SUM(amount) / COUNT(DISTINCT customer_id) AS average_income_per_customer
FROM sakila12_85.payment;


SELECT staff_id, COUNT(*) AS total_amout, count(rental_id) as total_rental
FROM sakila12_85.payment
GROUP BY staff_id;

create or replace view payment_report as 
SELECT
    c.first_name,
    c.last_name
    c.email,
    sum(p.amout) as payment_total
    count(p.)

from sakyla12_85.payment as payment_report
inner join customer c using (customer_id);


CREATE OR REPLACE VIEW payment_report AS
SELECT 
    c.first_name, 
    c.last_name, 
    c.email,
    sum(p.amount) as payments_total,
    count(p.payment_id) as payment_amount,
    avg(p.amount) as payments_average,
    max(p.payment_date) as max_payment_date
FROM 
    sakila12_85.payment as p 
INNER JOIN
    customer c using(customer_id)
GROUP BY c.customer_id;


DROP TABLE IF EXISTS tmp_film_payments
CREATE TEMPORARY TABLE tmp_film_payments AS 
SELECT
    i.film_id,
    sum(p.amount) as payments
FROM 
    sakila12_85.inventory as i
INNER JOIN 
    sakila12_85.rental as r using(inventory_id)
INNER JOIN
    sakila12_85.payment as p using(rental_id)
GROUP BY film_id;


--

SELECT s2.staff_id,
       sum(p.amount) as sales,
       s.store_id
FROM sakila12_85.inventory as i 
    INNER JOIN 
    sakila12_85.rental as r using(inventory_id)
    INNER JOIN
    sakila12_85.payment as p using(rental_id)
    INNER JOIN
    sakila12_85.store as s using(store_id)
    INNER JOIN 
    sakila12_85.staff as s2 using(store_id)
GROUP BY s.store_id, s2.staff_id with ROLLUP
ORDER BY 1, 2 ;



