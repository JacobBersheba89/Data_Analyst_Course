--Payments and rentals
--Write a join for rental and payment tables. Display only the following columns:
        
        --pament_id--        se v jedné z tabulek nenachází... 
        --rental_id--

SELECT 
    payment_id, rental_id, amount, rental_date, payment_date
FROM 
    sakila12_85.rental
INNER JOIN
    sakila12_85.payment ON 
     sakila12_85.rental.rental_id = sakila12_85.payment.rental_id;

--použití aliasu AS

SELECT 
    payment_id, rental_id, amount, rental_date, payment_date
FROM 
    sakila12_85.rental AS a
INNER JOIN
    sakila12_85.payment AS b ON 
    a.rental_id = b.rental_id;

--použití USING

 SELECT 
    payment_id, rental_id, amount, rental_date, payment_date
FROM 
    sakila12_85.rental AS a
INNER JOIN
    sakila12_85.payment AS b USING (rental_id);


        --amount--              se v jedné z tabulek nenachází... 
        --rental_date--         se v jedné z tabulek nenachází... 

SELECT *
FROM 
    sakila12_85.rental AS r
INNER JOIN
    sakila12_85.payment AS p USING (rental_date);

        --payment_date          se v jedné z tabulek nenachází... 



--DRUHY UKOL
--Rentals and stocks
--Write a query that joins the rental and inventory tables and displays the following columns:

SELECT 
    y.inventory_id, r.rental_id, y.film_id
FROM 
    sakila12_85.rental AS r
INNER JOIN
    sakila12_85.inventory AS y USING (inventory_id);


--TRETI UKOL
--Film rentals
--Write a query that joins the film and inventory tables and displays the following columns:

select * from film;
select * from inventory;

select
    i.inventory_id, i.film_id, f.title, f.description, f.release_year
from 
    sakila12_85.film as f 
    inner join
    sakila12_85.inventory as i using(film_id)

--CTRVTÝ UKOL
--Rental report
--Using the queries and the joining method from the previous tasks, write a query that returns the following information about the rental:

select
    rental_id, film_id, title as film_title, description as film_description, rating as film_rating, amount as payment_amount
    from 
            saklia12_85.payment as p 
        join
            sakila12_85.rental as r using (rental_id)
        join
            sakila12_85.inventory as i using (inventory_id)
        join
            sakila12_85.film as f using (film_id)   


--PATY UKOL
--Unpaid rentals
--Using tasks.payment and sakila.rental tables find unpaid rentals (those with no payment).
--What type of JOIN should be used here? Can you find more than one solution of this exercise?

SELECT*
from tasks.payment as p 
right join
        sakila12_85.rental as r using(rental_id)
where p.pament_id is null;



--JOIN in data modification

--clauzule DELETE je schopna mazat určité řádky

DELETE c 
FROM 
        examples.delete_join_customer AS c 
    innder join
        examples.delete_join_address ass a using (address_id)¨
where a.district = 'England'


