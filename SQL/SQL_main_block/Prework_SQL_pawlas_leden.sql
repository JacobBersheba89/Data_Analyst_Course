-- prework, session 2, Views (zkoušel jsem si modifikovat vzorový příklad)


SELECT 
    a.first_name as actor_name,
    a.last_name as actor_last_name,
    f.title as film_title,
    f.description as film_description
FROM
        sakila12_85.actor as a
    INNER JOIN
        sakila12_85.film_actor fa on a.actor_id = fa.actor_id
    INNER JOIN
        sakila12_85.film f on fa.film_id = f.film_id;
        
        
-- views jsou uloženy přímo do databáze serveru a nemusí se vytvářet znovu

CREATE VIEW actor_film as
SELECT 
    a.first_name as actor_name,
    a.last_name as actor_last_name,
    f.title as film_title,
    f.description as film_description
FROM
        sakila12_85.actor as a
    INNER JOIN
        sakila12_85.film_actor fa on a.actor_id = fa.actor_id
    INNER JOIN
        sakila12_85.film f on fa.film_id = f.film_id;
        

-- zkusím jestli se mi "actor_film" opravdu uložil
SELECT * FROM actor_film;

--  TEĎ ZKUSÍME NĚJAKÉ JINÉ PŘÍKAZY A FUNKCE, KLAUZULE.. 

-- Náhodně třebavybereme 5 filmů :-)

SELECT *
FROM actor_film
ORDER BY RAND()
LIMIT 5;

-- mohli bychom vyhledat film podle toho jak dlouho byl půjčený

SELECT 
    a.actor_id as ajdyčko_herce,
    fa.film_id as ajdyčko_filmu,
    f.title as nazev_filmu,
    CONCAT(a.first_name, ' ', a.last_name) AS actor_name
   
FROM
    sakila12_85.actor as a,
    sakila12_85.film_actor as fa,
    sakila12_85.film as f
    