# Ex 01
DELIMITER $$
CREATE PROCEDURE `usp_get_employees_salary_above_35000`()
BEGIN
	SELECT `first_name`, `last_name`
    FROM `employees`
    WHERE `salary` > 35000
    ORDER BY `first_name`, `last_name`, `employee_id`;
END $$
DELIMITER ;

CALL `usp_get_employees_salary_above_35000`();

# Ex 02
DELIMITER $$
CREATE PROCEDURE `usp_get_employees_salary_above`(min_salary DECIMAL(19,4))
BEGIN
	SELECT `first_name`, `last_name`
    FROM `employees`
    WHERE `salary` >= min_salary
    ORDER BY `first_name`, `last_name`, `employee_id`;
END $$
DELIMITER ;

CALL `usp_get_employees_salary_above`(45000);

# Ex 03
DELIMITER $$
CREATE PROCEDURE `usp_get_towns_starting_with`(start_string VARCHAR(20))
BEGIN
	SELECT `name`
    FROM `towns`
    WHERE `name` LIKE concat(start_string, '%')
    ORDER BY `name`;
END $$
DELIMITER ;

CALL `usp_get_towns_starting_with`('b');

# Ex 04
DELIMITER $$
CREATE PROCEDURE `usp_get_employees_from_town`(town_name VARCHAR(50))
BEGIN
	SELECT e.`first_name`, e.`last_name`
    FROM `employees` AS e
    JOIN `addresses` AS a
    USING (`address_id`)
    JOIN `towns` AS t
    USING (`town_id`)
    WHERE t.`name` = town_name
    ORDER BY `first_name`, `last_name`, `employee_id`;
END $$
DELIMITER ;

CALL `usp_get_employees_from_town`('Sofia');

# Ex 05
DELIMITER $$
CREATE FUNCTION `ufn_get_salary_level` (employee_salary DECIMAL)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
	RETURN (CASE
				WHEN employee_salary < 30000 THEN 'Low'
				WHEN employee_salary BETWEEN 30000 AND 50000 THEN 'Average'
                ELSE 'High'
			END
    );
END $$
DELIMITER ;

SELECT `ufn_get_salary_level` (13500) AS 'salary_level';
SELECT `ufn_get_salary_level` (43500) AS 'salary_level';

# Ex 06
DELIMITER $$
CREATE PROCEDURE `usp_get_employees_by_salary_level`(salary_level VARCHAR(10))
BEGIN
	SELECT e.`first_name`, e.`last_name`
    FROM `employees` AS e
    WHERE `ufn_get_salary_level`(e.`salary`) = salary_level
    ORDER BY `first_name` DESC, `last_name` DESC;
END $$
DELIMITER ;

CALL `usp_get_employees_by_salary_level`('high');

# Ex 07
DELIMITER $$
CREATE FUNCTION `ufn_is_word_comprised`(set_of_letters varchar(50), word varchar(50))  
RETURNS INTEGER
DETERMINISTIC
BEGIN
	RETURN ( SELECT word REGEXP concat('^[', set_of_letters, ']+$'));
END $$
DELIMITER ;

SELECT `ufn_is_word_comprised`('oistmiahf', 'Sofia');
SELECT `ufn_is_word_comprised`('oistmiahf', 'halves');
SELECT `ufn_is_word_comprised`('pppp', 'Guy');

# Ex 08
DELIMITER $$
CREATE PROCEDURE `usp_get_holders_full_name`()
BEGIN
	SELECT concat(`first_name`, ' ', `last_name`) AS 'full_name'
    FROM `account_holders`
    ORDER BY `full_name`, `id`;
END $$
DELIMITER ;

CALL `usp_get_holders_full_name`();

# Ex 09
DELIMITER $$
CREATE PROCEDURE `usp_get_holders_with_balance_higher_than`(min_balance DECIMAL)
BEGIN
	SELECT ah.`first_name`, ah.`last_name`
    FROM `account_holders` AS ah
    JOIN `accounts` AS a
    ON ah.`id` = a.`account_holder_id`
    GROUP BY a.`account_holder_id`
    HAVING sum(a.`balance`) > min_balance
    ORDER BY ah.`id`;
END $$
DELIMITER ;

CALL `usp_get_holders_with_balance_higher_than`(7000);

# Ex 10
DELIMITER $$
CREATE FUNCTION `ufn_calculate_future_value` (sum DECIMAL(19,4), interest DOUBLE, years INT)
RETURNS DECIMAL(19,4)
DETERMINISTIC
BEGIN
	RETURN ( sum * power(1 + interest, years) );
END $$
DELIMITER ;

SELECT ufn_calculate_future_value(1000, 0.5, 5);

# Ex 11
DELIMITER $$
CREATE PROCEDURE `usp_calculate_future_value_for_account`(account_id INT, interest DOUBLE(6,4))
BEGIN
	SELECT a.`id` AS 'account_id', ah.`first_name`, ah.`last_name`, a.`balance` AS 'current_balance',
    ufn_calculate_future_value(a.`balance`, interest, 5) AS 'balance_in_5_years'
    FROM `account_holders` AS ah
    JOIN `accounts` AS a
    ON ah.`id` = a.`account_holder_id`
    WHERE a.`id` = account_id;
END $$
DELIMITER ;

CALL `usp_calculate_future_value_for_account`(1, 0.1);

# Ex 12
DELIMITER $$
CREATE PROCEDURE `usp_deposit_money`(account_id INT, money_amount DECIMAL(19,4)) 
BEGIN
	START TRANSACTION;
	IF (money_amount <= 0 OR (SELECT count(`id`) FROM accounts WHERE `id` = account_id) = 0)
    THEN ROLLBACK;
    ELSE
    UPDATE `accounts`
    SET `balance` = `balance` + money_amount
    WHERE `id` = account_id;
    END IF;
END $$
DELIMITER ;

CALL usp_deposit_money(1, 10);
SELECT *
FROM accounts
WHERE id = 1;

# Ex 13
DELIMITER $$
CREATE PROCEDURE `usp_withdraw_money`(account_id INT, money_amount DECIMAL(19,4)) 
BEGIN
	START TRANSACTION;
	IF (money_amount <= 0 OR 
    (SELECT count(`id`) FROM accounts WHERE `id` = account_id) = 0  OR 
    (SELECT `balance` FROM `accounts` WHERE `id` = account_id) < money_amount)
    THEN ROLLBACK;
    ELSE
    UPDATE `accounts`
    SET `balance` = `balance` - money_amount
    WHERE `id` = account_id;
    END IF;
END $$
DELIMITER ;

CALL usp_withdraw_money(1, 10);

# Ex 14
DELIMITER $$
CREATE PROCEDURE `usp_transfer_money`(from_account_id INT, to_account_id INT, amount DECIMAL(19,4)) 
BEGIN
	START TRANSACTION;
	IF (amount <= 0 OR 
    (SELECT count(*) FROM accounts WHERE `id` = from_account_id) = 0  OR 
    (SELECT count(*) FROM accounts WHERE `id` = to_account_id) = 0  OR 
    (from_account_id = to_account_id) OR
    (SELECT `balance` FROM `accounts` WHERE `id` = from_account_id) < amount)
    THEN ROLLBACK;
    ELSE
    UPDATE `accounts`
    SET `balance` = `balance` - amount
    WHERE `id` = from_account_id;
    UPDATE `accounts`
    SET `balance` = `balance` + amount
    WHERE `id` = to_account_id;
    END IF;
END $$
DELIMITER ;

CALL usp_transfer_money(1, 2, 10);

SELECT *
FROM accounts
WHERE id = 1 OR id = 2;

# Ex 15
CREATE TABLE `logs`(
`log_id` INT PRIMARY KEY AUTO_INCREMENT,
`account_id` INT,
`old_sum` DECIMAL(19,4),
`new_sum` DECIMAL(19,4)
);

DELIMITER $$
CREATE TRIGGER `tr_accounts_AFTER_UPDATE`
AFTER UPDATE ON `accounts` 
FOR EACH ROW
BEGIN
	INSERT INTO `logs`(`account_id`, `old_sum`, `new_sum`)
    VALUES (OLD.`id`, OLD.`balance`, NEW.`balance`);
END $$
DELIMITER ;





