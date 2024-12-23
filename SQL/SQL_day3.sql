
-- grouping

SELECT 
COUNT(*) as rows_amount 
FROM sakila12_85.payment; --zjištění počtu řádků

SELECT
    col_name1, 
    ..., 
    col_name_n, 
    aggregate_function(col_name_m)
FROM tab_name
WHERE conditions
GROUP BY col_name1, ..., col_name_n

SELECT 
    actor_id,
    count(film_id) AS played_in
FROM sakila12_85.film_actor
GROUP BY actor_id
ORDER BY played_in DESC

SELECT
    a.first_name AS actor_name,
    a.last_name as actor_last_name,
    count(film_id) AS played_in
FROM
        sakila12_85.film_actor as fa
    INNER JOIN
        sakila12_85.actor as a USING (actor_id)
GROUP BY actor_id
ORDER BY played_in DESC

SELECT
    customer_id,
    sum(amount) as amount
FROM payment
WHERE amount > 1
GROUP BY customer_id
HAVING sum(amount) > 50

-- Income
/*
Aggregate thepayment table according to the following rules:

determine the total amount of rental shop's income,
determine the total amount of rental shop's income divided by customers (for now don't use JOIN, only customer_id),
determine the total amount of rented films per employee,
using date_format function, do subpoints 2 and 3. split by months and sort the results by the keys: client_id/staff_id ascending, amount - descending. */

/* Payment report
Using the appropriate tables from the sakila database, prepare a payment report showing the following information:

client's name,
client's surname,
client's email,
amount of payments,
number of payments,
average payment amount,
date of last payment.
Save the query result to a database; use a view.

How do you check if your query is correct? Write appropriate query/queries. */

/* Most profitable film (part 1) - Number of actors in a film
Write a query that returns the following information:

film id,
film title,
number of actors playing in the film.
Save the results to a temporary table, e.g. tmp_film_actors.

Additionally, write a query to verify your query. */

/* Most profitable film (part 2) - Number of film rentals
Write a query that returns:

film id,
film title,
number of film rentals.
Save the results to a temporary table, e.g. tmp_film_rentals.

Additionally, write a query that you can use to verify your solution.*/

/* Most profitable film (part 3) - Income by film
Write a query that will return the amount of contributions from a movie in the following format:

film id, the amount of payments from the film.

Save the results to a temporary table, e.g. tmp_film_actors.

Remember to test your solution.

Hint for testing: Check if all rental_id are filled

 */

/* Most profitable film (summary)
Prepare a report that displays the top 10 most rented films. Make the following business assumptions to prepare the report:

film title,
number of actors who played in it,
the amount of revenue of the film,
number of film rentals.
Additionally, make sure that the amount you get for all films is correct (before you limit the results). */

-- roll up

SELECT * FROM sakila.film_analytics

SELECT
    rating, 
    release_year, 
    sum(payments) as payments
    FROM sakila.film_analytics
    GROUP BY rating, release_year
UNION ALL
    SELECT 
    RATING, 
    NULL, 
    sum(payments) as payments
    FROM sakila12_85.film_analytics
    GROUP by rating
UNION ALL
    SELECT 
    NULL, 
    NULL, 
    sum(payments)
    FROM sakila.film_analytics

SELECT
    rating, 
    release_year, 
    sum(payments) as payments
FROM sakila.film_analytics
GROUP BY 
    rating, 
    release_year 
WITH ROLLUP -- here we say we want to use ROLLUP

SELECT
    select_list
FROM
    table_name
GROUP BY
    c1, c2, c3 WITH ROLLUP;

/* ROLLUP
Write a query that generates a report on:

the store's total sales and its employees,
the store's total sales (no division by employee),
total sales.
Additionally – choose your own way to sort rows. */

/* ROLLUP and HAVING
Based on the payment table write a query that:

determines the sum of payments divided by client and by employee,
determines the sum of payments per client,
determines the sum of payments.
Do two versions of the exercise:

Using only ROLLUP,
Adding the HAVING clause to the GROUP BY for payments above 70.
How are the results of the queries different? To make it easier to notice the difference, do the exercise only for the first 3 customers (customer_id < 4). */

-- window functions

SELECT
    customer_id,
    amount,
    SUM(amount) OVER (PARTITION BY customer_id) as total_amount
FROM sakila12_85.payment

window_function OVER (PARTITION BY column_name_1 ORDER BY column_name_2)

SELECT
    customer_id,
    AVG(amount) OVER (customer_window) as payment_amount,
    MIN(amount) OVER (customer_window) as min_payment,
    MAX(amount) OVER (customer_window) as max_payment
FROM sakila.payment
WINDOW customer_window As (PARTITION BY customer_id)

SELECT
    customer_id,
    amount,
    ROW_NUMBER() OVER (amount_window) as rn,
    DENSE_RANK() OVER (amount_window) as dr,
    RANK() OVER (amount_window) as r
FROM sakila.payment
WINDOW amount_window As (ORDER BY amount DESC)

SELECT
  customer_id,
  amount,
  payment_date,
  LEAD(amount) OVER (customer_window) as following_payment,
  LAG(amount) OVER (customer_window) as previous_payment
FROM sakila.payment
WINDOW customer_window As (PARTITION BY customer_id ORDER BY payment_date ASC)
ORDER BY customer_id, payment_date

/* Actors ranking
Write a query that will create a ranking of actors based on the average rating from the movies they played in. To do the exercise assume the following:

use the actor_analytics view,
use the ROW_NUMBER() function to create the ranking.
Sort the actors from the best to the worst, e.g.: 1 - highest rating.

Additionally, review the table and see how rows that have the same values are treated.*/

/* Cumulative sum
Cumulative sum (often shortened to cumsum), as the name suggests, refers to the cumulative amount; window functions let us count according to a specified order: this is done using the ORDER BY clause.

In a sense ROW_NUMBER() was already an example of a cumsum regarding the count of elements in a partition. In statistics this approach can be used to determine e.g. a cumulative distribution function

Our task is going to be to write a clause that determines the following accumulating values.

MIN for avg_film_rate,
SUM for actor_payload,
MAX for longest_movie_duration.
Use actor_id as a sorting key - ascending.

*/

/* Pareto principle
Pareto principle In short states that 20% of the society holds 80% of wealth.

In the context of a video rental company, we want to perform a similar analysis - to do this we will use window functions. Let's once again use the actor data from the actor_analytics view and check what % of actors is responsible for what % of income of the rental shop.

How should we approach this task?

Create a window function using ROW_NUMBER,
Using COUNT and a empty window (OVER ()) count the number of rows in the table,
Dividing point 1./2. you are going to get an increasing sequence representing the % of actors,
Use your knowledge from subpoints 1-3, to do the calculation for the % of income.
Make an interpretation of the query results for a sample actor.

*/

/* Ranking
Using RANK, DENSE_RANK and ROW_NUMBER, create a ranking of the movies by number of rentals.

Notice the results of each function.

When you do this exercise, add a partition according to rating.

In this exercise you can use the sakila.film_analytics table.*/

-- datetime

SELECT ADDDATE('2021-06-01', INTERVAL 1 DAY); -- adding 1 day to the date

SELECT ADDDATE('2021-06-01', INTERVAL 30 DAY); -- adding 30 days to the date

SELECT ADDDATE('2021-06-01', INTERVAL 1 MONTH); -- adding 1 month to the date

SELECT ADDDATE('2021-06-01', INTERVAL -15 DAY); -- subtracting 15 days from the date

SELECT ADDDATE(date, INTERVAL num UNIT);

SELECT ADDTIME('2021-07-10 23:59:59', '0:0:1'); -- add one second

SELECT ADDTIME('2021-07-10 23:59:59', '1:1:1'); -- adding one hour, minute, second

SELECT ADDTIME(exp1, exp2)

SELECT DATEDIFF('2021-06-10 23:00:00', '2021-06-01 23:00:00'); -- 9

SELECT DATEDIFF('2021-06-10 23:00:00', '2020-06-01'); -- 374

SELECT DATEDIFF('2021-06-10 23:00:00', '2021-06-01 22:00:00'); -- 9

SELECT EXTRACT(YEAR FROM '2021-06-10 23:00:00'); -- 2021

SELECT EXTRACT(DAY FROM '2021-06-10 23:00:00'); -- 10

SELECT EXTRACT(WEEK FROM '2021-06-10 23:00:00'); -- 23

SELECT EXTRACT(SECOND FROM '2021-06-10 23:00:00'); -- 0

SELECT EXTRACT(unit FROM date);

SELECT NOW()

/* Calendar

Using ROW_NUMBER and appropriate date values create a calendar table in the database, that:

will start from '2000-01-01',
will end on '2030-12-31'.
The calendar table should have the following columns:

date (date),
year (date_year),
month (date_month),
day (date_day),
number of day of week (day_of_week),
number of week in the year (week_of_year),
date of generating the calendar (last_update). */

/* Payments

Using the payment table, create a view that displays the following summaries:

sum of payments in one year - name the column payment_year,
sum of payments per month - name the column payment_month,
total amount of payments.
Additionally, take care to display the result in a logical way using ORDER BY.*/
