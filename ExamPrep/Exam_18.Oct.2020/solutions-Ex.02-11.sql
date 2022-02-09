# Ex 02
INSERT INTO `products_stores` 
SELECT `id`, 1
FROM `products`
WHERE `id` NOT IN (SELECT `product_id` FROM `products_stores`); 

# Ex 03
UPDATE `employees`
SET `manager_id` = 3, `salary` = `salary` - 500
WHERE year(`hire_date`) > 2003 AND `store_id` NOT IN (5, 14);

# Ex 04
DELETE FROM `employees`
WHERE `manager_id` IS NOT NULL AND `salary` >= 6000;

# Ex 05
SELECT first_name, middle_name, last_name, salary, hire_date
FROM employees
ORDER BY hire_date DESC;

# Ex 06
SELECT 
    p.`name`,
    p.`price`,
    p.`best_before`,
    CONCAT(SUBSTRING(p.`description`, 1, 10), '...') AS 'short_description',
    pi.`url`
FROM
    `products` AS p
        JOIN
    `pictures` AS pi ON p.`picture_id` = pi.`id`
WHERE
    CHAR_LENGTH(p.`description`) > 100
        AND p.`price` > 20
        AND YEAR(pi.`added_on`) < 2019
ORDER BY p.`price` DESC;

# Ex 07
SELECT 
    s.`name`,
    COUNT(p.`id`) AS 'product_count',
    ROUND(AVG(p.`price`), 2) AS 'avg'
FROM
    `stores` AS s
        LEFT JOIN
    `products_stores` AS ps ON ps.`store_id` = s.`id`
        LEFT JOIN
    `products` AS p ON p.`id` = ps.`product_id`
GROUP BY s.`name`
ORDER BY `product_count` DESC , `avg` DESC , s.`id`;

# Ex 08
SELECT 
    CONCAT_WS(' ', e.`first_name`, e.`last_name`) AS 'full_name',
    s.`name` AS 'store_name',
    a.`name` AS 'address',
    e.`salary`
FROM
    employees AS e
        JOIN
    `stores` AS s ON s.`id` = e.`store_id`
        JOIN
    addresses AS a ON a.`id` = s.`address_id`
WHERE
    e.`salary` < 4000
        AND a.`name` LIKE '%5%'
        AND CHAR_LENGTH(s.`name`) > 8
        AND e.`last_name` LIKE '%n';
        
# Ex 09 
SELECT 
    REVERSE(s.`name`) AS 'reversed_name',
    CONCAT(UPPER(t.`name`), '-', a.`name`) AS 'full_address',
    COUNT(e.`id`) AS 'employees_count'
FROM
    `stores` AS s
        JOIN
    `addresses` AS a ON a.`id` = s.`address_id`
        JOIN
    `towns` AS t ON t.`id` = a.`town_id`
        JOIN
    employees AS e ON e.`store_id` = s.`id`
GROUP BY s.`name`
HAVING `employees_count` >= 1
ORDER BY `full_address`;

# Ex 10
DELIMITER $$
CREATE FUNCTION udf_top_paid_employee_by_store (store_name VARCHAR(50))
RETURNS VARCHAR(200)
DETERMINISTIC
BEGIN
	RETURN (SELECT 
		CONCAT(e.`first_name`,
            ' ',
            e.`middle_name`,
            '. ',
            e.`last_name`,
            ' works in store for ',
            TIMESTAMPDIFF(YEAR,
                e.`hire_date`,
                '2020-10-18'),
            ' years')
	FROM
    `employees` AS e
        JOIN
    `stores` AS s ON s.`id` = e.`store_id`
	WHERE
    s.`name` = store_name
	ORDER BY e.`salary` DESC
	LIMIT 1);
END $$
DELIMITER ;

SELECT udf_top_paid_employee_by_store('Keylex') as 'full_info';

# Ex 11
DELIMITER $$
CREATE PROCEDURE udp_update_product_price (address_name VARCHAR (50))
BEGIN
	UPDATE products AS p
	JOIN products_stores AS ps
	ON ps.`product_id` = p.`id`
	JOIN stores AS s
	ON s.`id` = ps.`store_id`
	JOIN addresses AS a
	ON a.`id` = s.`address_id`
	SET p.`price` = IF(a.`name` LIKE '0%', p.`price` + 100,  p.`price` + 200)
	WHERE a.`name` = address_name;
END $$
DELIMITER ;

CALL udp_update_product_price('1 Cody Pass');
SELECT name, price FROM products WHERE id = 17;























