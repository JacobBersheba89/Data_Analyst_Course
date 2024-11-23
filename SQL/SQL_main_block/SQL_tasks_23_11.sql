-- první příklad

SELECT * 
FROM sakila12_85.rental
WHERE rental_date > 2005

-- od data 24.5.

SELECT * 
FROM sakila12_85.rental
WHERE rental_date > 2005-05-24 

-- po datu 30.6.

SELECT *
FROM sakila12_85.rental
WHERE rental_date >= '2005-06-30';

-- o prázdninových pronájmech, to znamená: mezi 30. 6. 2005 a 31. 8. 2005 od Jona

SELECT *
FROM sakila12_85.rental
WHERE rental_date BETWEEN '2005-06-30' AND '2005-08-31'
  
  AND staff_id = (SELECT staff_id FROM sakila12_85.staff WHERE first_name = 'Jon');

  --+ druhá možnost, ze stejné tabulky

SELECT *
FROM sakila12_85.rental
WHERE rental_date BETWEEN '2005-06-30' AND '2005-08-31'AND staff_id = '2 Jon';


--ukol dvě

--všichni aktivní klienti
SELECT *
FROM sakila12_85.customer
WHERE active = '1';

--všichni aktivní zákazníci kteří začínají na 'ANDRE'
SELECT *
FROM sakila12_85.customer
WHERE active = '1' and first_name LIKE 'ANDR%'; --může se použít také přísnější pokyn 'XOR'

--ukol tři

--všichni neaktivní zákazníci s store_id= 1,
SELECT *
FROM sakila12_85.customer
WHERE active = '0' and store_id = '1';

--nebo

SELECT *
FROM sakila12_85.customer
WHERE 1=1
  AND active = 0
  AND store_id = 1

--zákazníci, jejichž e-mailová adresa je v jiné doméně než sakilacustomer.org. jsou nějaké? TAKOVÉ MAILY NEJSOU V DATABÁZY PŘÍTOMNY
SELECT *
FROM sakila12_85.customer
WHERE email NOT LIKE '%@sakilacu%';
--OVĚŘENÍ
SELECT *
FROM sakila12_85.customer
WHERE email LIKE '%@sakilacu%';

--zákazníky s jedinečnými hodnotami ve create_datesloupci. DOPLNIT
SELECT DISTINCT create_date --jedna z mála fcí, která se používá ještě před výběrem raws
FROM sakila12_85.customer;

--poslední úkol

--zobrazit herce, kteří hráli ve více než 25 filmech,
SELECT *
FROM sakila12_85.actor_analytics
WHERE films_amount >= '25';

--zobrazit herce, kteří hráli ve více než 20 filmech a jejichž průměrné hodnocení je vyšší než 3,3,
SELECT *
FROM sakila12_85.actor_analytics
WHERE films_amount >= '20'
    AND avg_film_rate > '3.3';

--zobrazit herce, kteří hráli ve více než 20 filmech a jejichž průměrné hodnocení je vyšší než 3,3 nebo příjem z pronájmů ( actor_payload) je vyšší než 2000.
SELECT *
FROM sakila12_85.actor_analytics
WHERE films_amount >= '20'
    AND avg_film_rate > '3.3' OR actor_payload > '2000';