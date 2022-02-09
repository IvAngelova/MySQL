# Ex 02
INSERT INTO `clients` (`full_name`, `phone_number`)
SELECT concat(`first_name`, ' ', `last_name`), 
concat('(088) 9999', (`id` * 2))
FROM `drivers`
WHERE `id` BETWEEN 10 AND 20;

# Ex 03
UPDATE `cars`
SET `condition` = 'C'
WHERE (`mileage` >= 800000 OR `mileage` IS NULL) AND `year` <= 2010 AND `make` != 'Mercedes-Benz';

# Ex 04
DELETE FROM `clients`
WHERE char_length(`full_name`) > 3 AND `id` NOT IN (SELECT `client_id` FROM courses);

# Ex 05
SELECT `make`, `model`, `condition`
FROM `cars`
ORDER BY `id`;

# Ex 06
SELECT d.`first_name`, d.`last_name`, c.`make`, c.`model`, c.`mileage`
FROM `drivers` AS d
JOIN `cars_drivers` AS cd
ON d.`id` = cd.`driver_id`
JOIN `cars` AS c
ON c.`id` = cd.`car_id`
WHERE c.`mileage` IS NOT NULL
ORDER BY c.`mileage` DESC, d.`first_name`;

# Ex 07
SELECT c.`id` AS 'car_id', c.`make`, c.`mileage`, count(co.`id`) AS 'count_of_courses', round(avg(co.`bill`),2) AS 'avg_bill'
FROM `cars` AS c
LEFT JOIN `courses` AS co
ON c.`id` = co.`car_id`
GROUP BY c.`id`
HAVING `count_of_courses` != 2
ORDER BY `count_of_courses` DESC, c.`id`; 

# Ex 08
SELECT c.`full_name`, count(co.`car_id`) AS 'count_of_cars', sum(co.`bill`) AS 'total_sum'
FROM `clients` AS c
JOIN `courses` AS co
ON c.`id` = co.`client_id`
WHERE c.`full_name` LIKE '_a%'
GROUP BY co.`client_id`
HAVING `count_of_cars` > 1
ORDER BY c.`full_name`;

# Ex 09
SELECT a.`name` , 
(CASE
	WHEN hour(co.`start`) BETWEEN 6 AND 20 THEN 'Day'
	ELSE 'Night'
 END) AS 'day_time',
 co.`bill`, cl.`full_name`, c.`make`, c.`model`, ca.`name` AS 'category_name'
FROM `addresses` AS a
JOIN `courses` AS co
ON a.`id` = co.`from_address_id`
JOIN `clients` AS cl
ON cl.`id` = co.`client_id`
JOIN `cars` AS c
ON c.`id` = co.`car_id`
JOIN `categories` AS ca
ON ca.`id` = c.`category_id`
ORDER BY co.`id`;

# Ex 10
DELIMITER $$
CREATE FUNCTION `udf_courses_by_client` (phone_num VARCHAR(20)) 
RETURNS INTEGER
DETERMINISTIC
BEGIN
	RETURN (SELECT count(co.`id`)
	FROM `clients` AS cl
	LEFT JOIN `courses` AS co
	ON cl.`id` = co.`client_id`
	WHERE cl.`phone_number` = phone_num );
END $$
DELIMITER ;

SELECT udf_courses_by_client ('(803) 6386812') as `count`; 

# Ex 11
DELIMITER $$
CREATE PROCEDURE `udp_courses_by_address` (address_name VARCHAR(100))
BEGIN
	SELECT a.`name`, cl.`full_name` AS 'full_names', 
(CASE
	WHEN co.`bill` <= 20 THEN 'Low'
	WHEN co.`bill` <= 30 THEN 'Medium'
    ELSE 'High'
 END) AS 'level_of_bill',
	c.`make`, c.`condition`, ca.`name` AS 'cat_name'
	FROM `addresses` AS a
	LEFT JOIN `courses` AS co
	ON a.`id` = co.`from_address_id`
	LEFT JOIN `clients` AS cl
	ON cl.`id` = co.`client_id`
	LEFT JOIN `cars` AS c
	ON co.`car_id` = c.`id`
	LEFT JOIN `categories` AS ca
	ON ca.`id` = c.`category_id`
	WHERE a.`name` = address_name
	ORDER BY c.`make`, cl.`full_name`;
END $$
DELIMITER ;

CALL udp_courses_by_address('66 Thompson Drive');









