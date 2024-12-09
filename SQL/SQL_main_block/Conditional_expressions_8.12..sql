select 
    first_name,
    last_name,
    avg_film_rate,

case 
    when films_amount > 20 then 'Super popular'         
    when films_amount between 10 and 20 then 'popular'  
    when films_amount < 10 then 'low popular'           
    else 'error'
 end as how_popular        
from sakila12_85.actor_analytics
;




SELECT
    first_name,
    last_name,
case 
    when payments_total < 90 then 'L---ow payment'
    when payments_total between 90 and 100 then 'A---vg payment'
    when payments_total > 100 then 'G---reat payment'
    else 'error'
    end as how_payment_is
from sakila12_85.payment_report;



    
WITH cte AS (
    SELECT *,
        CASE
            WHEN avg_film_rate < 2 THEN 'poor acting'
            WHEN avg_film_rate BETWEEN 2 AND 2.5 THEN 'fair acting'
            WHEN avg_film_rate BETWEEN 2.5 AND 3.5 THEN 'good acting'
            WHEN avg_film_rate > 3.5 THEN 'superb acting'
            ELSE 'error'
        END AS acting_level
    FROM sakila12_85.actor_analytics
)
SELECT acting_level,
       COUNT(1) AS amount,
       SUM(actor_payload) AS income,
       SUM(films_amount) AS films_amount,
       AVG(avg_film_rate) AS avg_film_rate
FROM cte
GROUP BY acting_level;


DROP PROCEDURE IF EXISTS sakila12_85.film_classification;
begin

CREATE procedure sakila12_85.film_classification(IN p_film_lenght INT, OUT p_class VARCHAR(100));



WITH cte AS (
    SELECT 
        IF(amount < 2, "fee", "regular") as payment_type, 
        SUM(amount) as amount
    FROM sakila12_85.payment
    GROUP BY payment_type
)
SELECT *,
    CONCAT(ROUND(amount / (SELECT SUM(amount) FROM cte) * 100), '%') AS share
FROM cte;



delimiter $$
drop procedure if exists film_rental $$
create procedure film_rental(in in_film_id int)
begin
start transaction;
update trigger_exercise12_85.stock_part_1
set stock = stock - 1
where film_id = in_film_id and stock > 0;
if row_count() > 0 then
select 1 as result;
commit;
else
select 0 as result;
rollback;
end if;
end $$
delimiter ;


set @stock_available = (
    select cast(greatest(stock -1, 0) as unsigned)
    set stock = stock - 1
    where film_id = p_film_id
);  



