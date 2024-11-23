--DRUHÁ ČÁST

--PRVNÍ ÚKOL - první část
--Zobrazte data z sakila.rentalpřidělení aliasů do sloupců podle požadavků: 
--ponechat sloupce rental_id, inventory_id, customer_id beze změny,
-- změna rental_date na date_of_rental
SELECT 
    rental_id, 
    inventory_id, 
    customer_id, 
    
    rental_date AS date_of_rental
FROM sakila12_85.rental;


--změnit return_date sloupec na date_of_rental_return
SELECT 
    rental_id, 
    inventory_id, 
    customer_id,
    return_date,
    return_date AS date_of_rental_return
FROM sakila12_85.rental;

--uveďte sloupce v pořadí, které si sami zvolíme - tak zde stačí vyměnit pořadí v SQL zápisu

SELECT 
    rental_id, 
    customer_id, 
    inventory_id, 
    rental_date AS date_of_rental
FROM sakila12_85.rental;

-- test

SELECT 
    customer_id, 
    inventory_id,
    rental_id,
    rental_date AS date_of_rental
FROM sakila12_85.rental;

                --druhá část -> změnit názvy sloupců

SELECT 
    customer_id AS zákaznické_ID,
    inventory_id AS ID_inventáře,
    rental_id AS ID_pronájmu,
    rental_date AS datum_pronájmu,
    return_date AS datum_navrácení
FROM sakila12_85.rental;

--Druhý úkol
--In the sakila.payment table there is information about payments made by the clients of the DVD rental store. Write a query to display the payment_date column in the following formats:
--'year/month/day',
--'year-name_of_month-day_of_week',
--'year-number_of_week',
--'year/month/day@day_of week_name',
--'year/month/day@day_of_week_number'.

SELECT  
payment_date
DATE_FORMAT (payment_date, '%Y/%m/%d') as time1
DATE_FORMAT (payment_date, '%Y-%M-%w') as time2
DATE_FORMAT (payment_date, '%Y-%dv') as time3
DATE_FORMAT (payment_date, '%Y/%m/%d@%a') as time4
DATE_FORMAT (payment_date, '%Y/%m/%d@%w') as time5
DATE_FORMAT (payment_date, GET_FORMAT(DATE, 'USA')) as
payment_data_USA_formatted
FROM skila12_85.payment

--Třetí úkol - least

SELECT 
    LEAST(price, length) AS nejmensi_hodnota_price_length
FROM sakila12_85.film_list;

--možnost s COALESCE

SELECT 
    LEAST(COALESCE(price, 0), COALESCE(length, 0)) AS nejmensi_hodnota_price_length
FROM sakila12_85.film_list;

--

--UNION
--první úkol
SELECT first_name 
FROM sakila12_85.customer
UNION
SELECT first_name 
FROM sakila12_85.actor
UNION
SELECT first_name 
FROM sakila12_85.staff;

--SELECT first_name, přidání sloupce s počtem daných jmen

SELECT first_name,
COUNT(*) AS počet_unikátních_jmen --(*)počíta všechny řádky / sloupec v tabulce se vytvoří příkazem COUNT(*)
FROM (
    SELECT first_name FROM sakila12_85.customer
    UNION ALL
    SELECT first_name FROM sakila12_85.actor
    UNION ALL
    SELECT first_name FROM sakila12_85.staff
) AS all_first_names
GROUP BY first_name

--

SELECT first_name, 
    COUNT(*) AS počet_unikátních_jmen, --PŘIDÁ SLOUPEC 
    CASE --DÍKY CASE, MŮŽEME PŘIŘAZOVAT HODNOTY - JE TO TAKÉ HODNOCENÍ URČITÉ HODNOTY
        WHEN COUNT(*) = 1 THEN 'unikátní' -- POKUD SE JMÉNO VYSKYTUJE POUZE JEDNOU, VYPÍŠE SE 'unikátní' 
        ELSE 'neunikátní' -- v opačném případě se vypíše..
        END AS status -- ukončneí podmíněného výrazu
FROM (
    SELECT first_name FROM sakila12_85.customer
    UNION ALL
    SELECT first_name FROM sakila12_85.actor
    UNION ALL
    SELECT first_name FROM sakila12_85.staff
) AS all_first_names
GROUP BY first_name;

--přidání počtu písmen ve jméně..

SELECT 
    first_name, 
    COUNT(*) AS počet_unikátních_jmen, 
    CASE 
        WHEN COUNT(*) = 1 THEN 'unikátní'
        ELSE '-'
        END AS je_unikatni,
    LENGTH(first_name) AS počet_písmen --využití funcke LENGHT
FROM (
    SELECT first_name FROM sakila12_85.customer
    UNION ALL
    SELECT first_name FROM sakila12_85.actor
    UNION ALL
    SELECT first_name FROM sakila12_85.staff
) AS all_first_names
GROUP BY first_name;

--další rozšíření o různé podmínky

SELECT first_name, 
COUNT(*) AS počet_unikátních_jmen
FROM (
    SELECT first_name FROM sakila12_85.customer
    UNION ALL
    SELECT first_name FROM sakila12_85.actor
    UNION ALL
    SELECT first_name FROM sakila12_85.staff
) AS all_first_names
GROUP BY first_name;

SELECT 
    first_name, 
    COUNT(*) AS počet_unikátních_jmen, 
    
    CASE 
        WHEN COUNT(*) = 1 THEN 'unikátní'
        ELSE '-'
        END AS je_unikatni,
        
    LENGTH(first_name) AS počet_písmen,
    
    CASE 
        WHEN LENGTH(first_name) <= 4 THEN '-krátké jméno'
        WHEN LENGTH(first_name) BETWEEN 5 AND 6 THEN '---střední jméno'
        ELSE '------dlouhé jméno'
    END AS délka_jména
    
FROM (
    SELECT first_name FROM sakila12_85.customer
    UNION ALL
    SELECT first_name FROM sakila12_85.actor
    UNION ALL
    SELECT first_name FROM sakila12_85.staff
) AS all_first_names
GROUP BY first_name;

-- Dalsí rozšíření o rozdělení jmén. Ženská jména se podařilo rozdělit pomocí 16-ti parametrů

-- pomocí UNION jsem seskupil ze tří tabulek
-- takže tabulku se jmény jsem seřadil podle unikátních jmén;
-- následně jsem pomocí COUNT(*) vytvořil nový sloupec a spočítal kolikrát se dané jméno objevuje v tabulkách
-- posléze jsem pomocí AS přidal další sloupec a přidal CASE s podmínkou, kdy = pokud je dané jmené v tabulce pouze jednou vypíše pojem 'unikátní'
-- Dále jsem počítal pomocí funkce LENGHT počet písmen ve slově a vytvořil 3 podmínky podle kterých se slova rozdělí do třech kategorií
-- no a poslední co mě napadlo bylo rozdělení jmen na ženská a mužská jména.. využil jsem LIKE a parametr %.. podařilo se mi pomocí 16 parametrů rozdělit ženksá jména.. nevím jak to dopadlo s mužskými

SELECT 
    first_name, 
    COUNT(*) AS počet_unikátních_jmen, 
    
    CASE 
        WHEN COUNT(*) = 1 THEN 'unikátní'
        ELSE '-'
        END AS je_unikatni,
        
    LENGTH(first_name) AS počet_písmen,
    
    CASE 
        WHEN LENGTH(first_name) <= 4 THEN '-krátké jméno'
        WHEN LENGTH(first_name) BETWEEN 5 AND 6 THEN '---střední jméno'
        ELSE '------dlouhé jméno'
    END AS délka_jména,
    
    CASE 
        WHEN first_name LIKE '%lores' THEN 'ženské jméno'
        WHEN first_name LIKE '%lady%' THEN 'ženské jméno'
        WHEN first_name LIKE '%gne%' THEN 'ženské jméno'
        WHEN first_name LIKE '%ano%' THEN 'ženské jméno'
        WHEN first_name LIKE '%anet' THEN 'ženské jméno'
        WHEN first_name LIKE '%ris' THEN 'ženské jméno'
        WHEN first_name LIKE '%ret' THEN 'ženské jméno'
        WHEN first_name LIKE '%er' THEN 'ženské jméno'
        WHEN first_name LIKE '%o' OR first_name LIKE '%r' THEN 'mužské jméno'
        WHEN first_name LIKE '%t' THEN 'mužské jméno'
        WHEN first_name LIKE '%c' OR first_name LIKE '%s' THEN 'mužské jméno'
        WHEN first_name LIKE '%a' OR first_name LIKE '%e' THEN 'ženské jméno'
        WHEN first_name LIKE '%ine' THEN 'ženské jméno'
        WHEN first_name LIKE '%elle' THEN 'ženské jméno'
        WHEN first_name LIKE '%ina' THEN 'ženské jméno'
        WHEN first_name LIKE '%thy' THEN 'ženské jméno'
        ELSE 'neznámé jméno'
    END AS typ_jmena
    
FROM (
    SELECT first_name FROM sakila12_85.customer
    UNION ALL
    SELECT first_name FROM sakila12_85.actor
    UNION ALL
    SELECT first_name FROM sakila12_85.staff
) AS all_first_names
GROUP BY first_name;