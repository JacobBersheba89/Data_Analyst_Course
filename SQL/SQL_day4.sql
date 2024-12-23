-- conditional expressions

DELIMITER $$
CREATE PROCEDURE delta_example(IN p_delta DOUBLE)
BEGIN
    IF p_delta > 0 THEN
        SELECT 'The equation has exactly two solutions';
    ELSEIF p_delta = 0 THEN
        SELECT 'The equation has one solution';
    ELSE
        SELECT 'The equation has no solution in real numbers';
    END IF;
END;$$        
 
-- Sample call
CALL delta_example(-1);
CALL delta_example(0);
CALL delta_example(10);

IF condition THEN
    statements;
END IF;
IF condition THEN
    statements;
ELSE
    else-statements;
END IF;
IF condition THEN
    statements;
ELSEIF elseif-condition THEN
    elseif-statements;
...
ELSE
    else-statements;
END IF;

CASE case_value
     WHEN when_value1 THEN statements
     WHEN when_value2 THEN statements
     ...
     [ELSE else-statements]
  END CASE;
Advanced comparison

CASE
      WHEN search_condition1 THEN statements
      WHEN search_condition1 THEN statements
      ...
      [ELSE else-statements]
  END CASE;

SELECT 
    *
    , CASE 
        WHEN films_amount > 20 THEN 'SUPER POPULAR'
        WHEN films_amount BETWEEN 10 AND 20 THEN 'POPULAR'
        WHEN films_amount < 10 THEN 'LOW POPULAR'
        ELSE 'ERROR'
    END AS how_popular
FROM sakila.actor_analytics

SELECT 
    amount,
    IF(amount > 5, 'Big payment', 'Low payment') AS payment_type
FROM sakila12_85.payment
General syntax of the clause:

IF(condition, value_if_true, value_if_false) 

/* Actors ratings
Using the actor_analyticstable write a query that groups actors according to the following criteria:

if avg_film_rate < 2 - 'poor acting',
if avg_film_rate is between 2 and 2.5 - 'fair acting',
if avg_film_rate is between 2.5 and 3.5 - 'good acting',
if avg_film_rate is above 3.5 - 'superb acting.
Call the column created this way: acting_level and use it in an analysis that calculates:

number of occurrences in each group,
the total revenue of each group,
number of films in each group,
the average rating in a group.
Hint: Do the exercise in two steps:

Write a subquery that creates an acting_level column,
Based on the results from the previous subpoint, do the rest of the exercise. */

/* Film duration
Write a procedure that, based on the duration of the film (i.e. length column from film), assigns the record to one of the groups below:

very short - film up to 1h,
short - film up to 1.5h,
normal - film up to 2h,
long - film up to 2.5h,
very long - film over 2.5h.
Call the procedure film_classification.

Hint:

In this exercise, for now, we will not query any table. We will pass film duration as a procedure parameter. */

/* Payment amount
Write a query that groups the payments according to the following classification:

fee - payments below 2,
regular - all others.
Use the payment table to complete the exercise.

Group the result and use SQL to find out what percent of the total payments were the fees. */


-- transactions

--Preparing the data,
DROP TABLE IF EXISTS examples.pln_acc;
CREATE TABLE examples.pln_acc (bal_pln numeric);
INSERT INTO examples.pln_acc VALUES (500);
 
DROP TABLE IF EXISTS examples.eur_acc;
CREATE TABLE examples.eur_acc (bal_eur numeric);
INSERT INTO examples.eur_acc VALUES (0);
 
-- Transaction execution
DELIMITER $$
DROP PROCEDURE IF EXISTS transfer;
CREATE PROCEDURE transfer()
BEGIN  -- start the procedure
START TRANSACTION; -- start the transaction
UPDATE examples.pln_acc SET bal_pln = bal_pln - 200 WHERE bal_pln>=200; -- update PLN account balance
IF ROW_COUNT() > 0 THEN  -- check if row has been updated
  UPDATE examples.eur_acc SET bal_eur = bal_eur+50;  -- update EUR account balance
  COMMIT;  -- confirm the transaction
ELSE
  ROLLBACK; -- otherwise, revert it
END IF;
END; $$ -- finish the procedure

USE examples;
DROP TABLE IF EXISTS messages;
CREATE TABLE messages (message VARCHAR(100));
INSERT INTO messages(message) VALUES('Hello');
We will need two consoles with open connections. Instruction

SELECT CONNECTION_ID();

- 1) beginning transaction
START TRANSACTION;
 
-- 2) deleting all values
DELETE FROM messages;
 
-- 3a) checking the number of rows in the table
SELECT COUNT(*) from messages; -- 0
 
-- 4) reverting transaction
ROLLBACK;
 
-- 5a) checking number of rows in the table
SELECT COUNT(*) from messages; -- 1

-- 3b) checking how much data remains in the database
SELECT COUNT(*) from messages; -- 1
 
-- 5b) checking the number of rows in the table
SELECT COUNT(*) from messages; -- 1

/* Film rental
Based on the analogy with a bank transaction, write a film_rental procedure that uses the table trigger_exercise.stock_part_1 to check whether a given film_id can be rented - if so, reduce the stock by one and return 1, otherwise return 0.

Example of use:

CALL film_rental(1)

Take advantage of the transaction mechanism here by following the steps below:

First write a query that finds the film and reduces its stock by 1,
If the film is found and its count is sufficient to be rented, approve the transaction.
Otherwise, cancel it. */

/* Stock
Modify the solution of the previous task so that it also returns the number of movies available to rent. */

/* Film rentals 2
Write a procedure film_rental_store that tests if it is possible to rent the film at the given store (stock_part_2 table).

If possible (the film is available), the procedure should:

return the information, about the stock after renting the film
and the information that the film is available to rent.
Otherwise, the procedure should:

return the information that the film is out of stock in the store,
return the information whether the film can be rented from another store. If so, make a reservation there, that is: reduce the stock.
What parameters does the procedure need to take to be executed?

You may use this. Additionally, offer a different solution.

Hint:

The stock is updated by removing the appropriate record from the table; remember to start a transaction before DELETE. */

-- loops

[begin_label:] LOOP
      statement_list
  END LOOP [end_label]
By default, this loop executes indefinitely and this is usually undesirable behavior. We can break it using the following construction:

[label]: LOOP
    ...
    -- terminate the loop
    IF condition THEN
        LEAVE [label];
    END IF;
    ...
END LOOP;

DELIMITER $$
  CREATE PROCEDURE even_numbers_using_loop()
  BEGIN
      DECLARE x  INT;
      DECLARE str  VARCHAR(255);
      SET x = 1, str =  '';
  
      loop_label:  LOOP
          IF  x > 10 THEN
              LEAVE  loop_label;
          END  IF;
  
          SET  x = x + 1;
          IF  (x mod 2) THEN
              ITERATE  loop_label;
          ELSE
              SET  str = CONCAT(str,x,',');
          END  IF;
      END LOOP;
      SELECT str;
  END$$
  DELIMITER ;

  CALL even_numbers_using_loop();

  [begin_label:] WHILE search_condition DO
      statement_list
  END WHILE [end_label]

  DELIMITER $$
CREATE PROCEDURE even_numbers_using_while()
BEGIN
    DECLARE x  INT;
    DECLARE str  VARCHAR(255);
    SET x = 1, str =  '';
 
    while_label:  WHILE x < 11 DO
        SET  x = x + 1;
        IF  (x mod 2) THEN
            ITERATE  while_label;
        ELSE
            SET  str = CONCAT(str,x,',');
        END  IF;
    END WHILE;
    SELECT str;
END$$
DELIMITER ;

CALL even_numbers_using_while();

[begin_label:] REPEAT
      statement
  UNTIL search_condition
  END REPEAT [end_label]

  DELIMITER $$
CREATE PROCEDURE even_numbers_using_repeat()
BEGIN
    DECLARE x  INT;
    DECLARE str  VARCHAR(255);
    SET x = 1, str =  '';
 
    repeat_label:  REPEAT
        SET  x = x + 1;
        IF  (x mod 2) THEN
            ITERATE  repeat_label;
        ELSE
            SET  str = CONCAT(str,x,',');
        END  IF;
    UNTIL x > 9
    END REPEAT repeat_label;
    SELECT str;
END$$
DELIMITER ;

CALL even_numbers_using_repeat();

/* Multiplication
Create a database procedure with a name of your choice that for the parameters: base and number_of_elements returns the multiple of base equal to the number of elements.

For example:

-- calling a procedure with base 2 and number of elements 10
CALL proc_name(@p_base:=2, @p_number:=10)

-- Result:
-- 2,4,6,8,10,12,14,16,18,20

Note:

In order to combine a string and a numeric type, you can take a hint from the following code snippet:

SELECT CONCAT('I am ', cast(5 as CHAR(10)), ' years old')

 */

/* Randomization
Write a procedure that first creates a table called randomizer, and then fills it with random values (a part of the procedure should be to specify how many values should be in the table). For example:

CALL fill_randomizer(10)

should populate the randomizer table with 10 random values from the 0-1 range.

Hint:

To generate a random value from the 0-1 range, you can take a hint from the example below:

SELECT rand() -- randomizing from the range of 0-1

In addition, you can use the following structure code to create a table:

DROP TABLE IF EXISTS randomizer;
CREATE TABLE randomizer (
    id INT,
    value FLOAT
)

 */


 -- cursor

 DECLARE cursor_name CURSOR FOR SELECT_statement;

 DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

 DELIMITER $$
-- here we need a large number to fit complex names into a single variable
CREATE PROCEDURE cursor_example(INOUT p_customers varchar(16000))
BEGIN
  DECLARE finished INTEGER DEFAULT 0;
  DECLARE customer varchar(100) DEFAULT "";
 
  DECLARE cur_customer
      CURSOR FOR
          SELECT DISTINCT
              CONCAT(first_name, ' ',
                  last_name) as name
          FROM sakila.customer;
 
  DECLARE CONTINUE HANDLER
      FOR NOT FOUND SET finished = 1;

DELIMITER $$
-- here we need a large number to fit complex names into a single variable
CREATE PROCEDURE cursor_example(INOUT p_customers varchar(16000))
BEGIN
  DECLARE finished INTEGER DEFAULT 0;
  DECLARE customer varchar(100) DEFAULT "";
 
  DECLARE cur_customer
      CURSOR FOR
          SELECT DISTINCT
              CONCAT(first_name, ' ',
                  last_name) as name
          FROM sakila.customer;
 
  DECLARE CONTINUE HANDLER
      FOR NOT FOUND SET finished = 1;

OPEN cur_customer;
 
  get_customer: LOOP
      FETCH cur_customer INTO customer;
 
      IF finished = 1 THEN
          LEAVE get_customer;
      END IF;
 
      SET p_customers =
          concat(customer, ';', p_customers);
  END LOOP get_customer;
  CLOSE cur_customer;
END$$
DELIMITER ;

SET @customers = '';
CALL cursor_example(@customers);
SELECT @customers;


/* Newsletter
Write a procedure using cursors that for active clients from the Buenos Aires area returns the email to send the newsletter to.

Separate elements with ;.

Hint: Data needed to do it are in the customer and address tables.

 */

