--Vazby mezi tabulkami.. 

-- one-to-one relationship -> 1-1            //------//
        --


-- one-to-many relationship -> 1-n          //------/<-
        --


-- many-to-many relationship -> n-n         ->\-----/<-
        --v praxi se často přechází k tomu, že tato vazba se do databáze nepropisuje. Může se použít pomocná mezitabulka


        --DDL -> Data Definition Language, Příkazy pro definování struktury databáze.
                    -- Účel: Vytváří, mění nebo odstraňuje databázové objekty jako tabulky, indexy a schémata.

        --DML -> (Data Manipulation Language), Příkazy pro manipulaci s daty v tabulkách.
                    -- Příklady: INSERT, UPDATE, DELETE, MERGE
                    -- Účel: Umožňuje vkládat, aktualizovat, mazat a upravovat data v tabulkách.

        --DCL -> (Data Control Language), Příkazy pro kontrolu přístupu k datům.
                    -- Příklady: GRANT, REVOKE
                    -- Účel: Spravuje oprávnění a přístupy uživatelů k databázovým objektům.

        --TCL -> (Transaction Control Language), Příkazy pro správu transakcí v databázi.
                    -- Příklady: COMMIT, ROLLBACK, SAVEPOINT, SET TRANSACTION
                    -- Účel: Řídí transakce, umožňuje potvrzení změn nebo jejich zrušení.

        --DQL -> dotazy na data z tabulek (vytváření SELEKTŮ), NEUPRAVUJEME DATABÁZI


        **joining tables**
        select column_name(s)
        From table1
        [inner, left, rigth] 

        LEFT JOIN --levá tabulka překryje pravou a vybere data která požadujeme, o část dat z pravé tabulky příjdeme
        INNER JOIN -- spojí společná data, části z obou tabulek ztrácíme
        FULL outer JOIN -- spojí tabulky A i B dohromady

    --examples
        SELECT *
        FROM    examples.payment_join
            RIGHT JOIN  
                EXAMPLES.RENTAL_JOIN on
                    exmaples.payment_join.rental_id = examples.rental_join.rental_id;
    --


        SELECT*.............................SELECT *
        FROM PAYMENT...........FROM RENTAL

        SELECT*
        FROM 
            PAYMENT on -- ON ZNAČÍ ZAČÁTEK KLÍČE, KTERÝ PAK NÁSLEDUJE ZA TEČKOU (V TOMTO PŘÍPADĚ 'RENTAL_ID' )
        INNER JOIN
            PAYMENT.RENTAL_ID = RENTAL.RENTAL_ID




