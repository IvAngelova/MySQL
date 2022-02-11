# Ex 02
INSERT INTO `cards`(`card_number`, `card_status`, `bank_account_id`)
SELECT reverse(`full_name`), 'Active', `id`
FROM `clients`
WHERE `id` BETWEEN 191 AND 200;

# Ex 03 !!! error code 1093 you can not specify target table ec for update in FROM clause
UPDATE employees_clients AS ec
SET ec.employee_id = (
	SELECT
		ecs.employee_id
	FROM (SELECT * FROM employees_clients) AS ecs
	GROUP BY ecs.employee_id
	ORDER BY
		COUNT(ecs.client_id) ASC,
		ecs.employee_id ASC
	LIMIT 1)
WHERE ec.employee_id = ec.client_id;


# Ex 04
DELETE FROM `employees`
WHERE `id` NOT IN (SELECT `employee_id` FROM employees_clients);

# Ex 05
SELECT 
    `id`, `full_name`
FROM
    `clients`
ORDER BY `id`;

# Ex 06
SELECT 
    `id`,
    CONCAT(`first_name`, ' ', `last_name`) AS 'full_name',
    CONCAT('$', `salary`) AS 'salary',
    `started_on`
FROM
    `employees`
WHERE
    `salary` >= 100000
        AND YEAR(`started_on`) >= 2018
ORDER BY `salary` DESC , `id`;

# Ex 07
SELECT 
    c.`id`,
    CONCAT(c.`card_number`, ' : ', cl.`full_name`) AS 'card_token'
FROM
    `cards` AS c
        JOIN
    `bank_accounts` AS ba ON ba.`id` = c.`bank_account_id`
        JOIN
    `clients` AS cl ON cl.`id` = ba.`client_id`
ORDER BY c.`id` DESC;

# Ex 08
SELECT 
    CONCAT(`first_name`, ' ', `last_name`) AS 'name',
    `started_on`,
    COUNT(ec.`client_id`) AS 'count_of_clients'
FROM
    employees AS e
        JOIN
    employees_clients AS ec ON e.id = ec.employee_id
GROUP BY e.`id`
ORDER BY `count_of_clients` DESC , e.`id`
LIMIT 5;

# Ex 09
SELECT 
    b.`name`, COUNT(c.`id`) AS 'count_of_cards'
FROM
    `branches` AS b
        LEFT JOIN
    `employees` AS e ON b.`id` = e.`branch_id`
        LEFT JOIN
    `employees_clients` AS ec ON ec.`employee_id` = e.`id`
        LEFT JOIN
    `clients` AS cl ON cl.`id` = ec.`client_id`
        LEFT JOIN
    `bank_accounts` AS ba ON cl.`id` = ba.`client_id`
        LEFT JOIN
    `cards` AS c ON c.`bank_account_id` = ba.`id`
GROUP BY b.`name`
ORDER BY `count_of_cards` DESC , b.`name`;


# Ex 10
DELIMITER $$
CREATE FUNCTION udf_client_cards_count(name VARCHAR(30)) 
RETURNS INTEGER
DETERMINISTIC
BEGIN
	RETURN (SELECT count(c.`id`)
			FROM `clients` AS cl
			LEFT JOIN `bank_accounts` AS ba
			ON ba.client_id = cl.id
			LEFT JOIN `cards` AS c
			ON c.bank_account_id = ba.id
			WHERE cl.`full_name` = name);
END $$
DELIMITER ;

SELECT c.full_name, udf_client_cards_count('Baxy David') as `cards` FROM clients c
WHERE c.full_name = 'Baxy David';


# Ex 11
DELIMITER $$
CREATE PROCEDURE `udp_clientinfo` (f_name VARCHAR(50))
BEGIN
		SELECT cl.`full_name`, cl.`age`, ba.`account_number`, concat('$',ba.`balance` ) AS 'balance'
		FROM clients AS cl
		JOIN `bank_accounts` AS ba
		ON ba.client_id = cl.`id`
		WHERE cl.`full_name` = f_name;
END $$
DELIMITER ;








