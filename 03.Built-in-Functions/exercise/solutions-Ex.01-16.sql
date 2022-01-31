# Ex 01
SELECT `first_name`, `last_name`
FROM `employees`
WHERE left(`first_name`, 2) = 'Sa'
ORDER BY `employee_id`;

# Ex 02
SELECT `first_name`, `last_name`
FROM `employees`
WHERE `last_name` LIKE '%ei%'
ORDER BY `employee_id`;

# Ex 03
SELECT `first_name`
FROM `employees`
WHERE `department_id` IN (3,10) AND year(`hire_date`) BETWEEN 1995 AND 2005
ORDER BY `employee_id`;

# Ex 04
SELECT `first_name`, `last_name`
FROM `employees`
WHERE `job_title` NOT LIKE '%engineer%'
ORDER BY `employee_id`;

# Ex 05
SELECT `name`
FROM `towns`
WHERE char_length(`name`) IN (5,6)
ORDER BY `name`;

# Ex 06
SELECT `town_id`, `name`
FROM `towns`
WHERE left(`name`, 1) IN ('M', 'K', 'B' , 'e')
ORDER BY `name`;

# Ex 07
SELECT `town_id`, `name`
FROM `towns`
WHERE left(`name`, 1) NOT IN ('R', 'B' , 'D')
ORDER BY `name`;

# Ex 08
CREATE VIEW `v_employees_hired_after_2000` AS
SELECT `first_name`, `last_name`
FROM `employees`
WHERE year(`hire_date`) > 2000;

SELECT * FROM `v_employees_hired_after_2000`;

# Ex 09
SELECT `first_name`, `last_name`
from `employees`
WHERE char_length(`last_name`) = 5;

# Ex 10
SELECT `country_name`, `iso_code`
FROM `countries`
WHERE `country_name` LIKE '%A%A%A%'
ORDER BY `iso_code`;

# Ex 11
SELECT 
    `peak_name`,
    `river_name`,
    LOWER(CONCAT(`peak_name`, SUBSTRING(`river_name`, 2))) AS 'mix'
FROM
    `peaks`,
    `rivers`
WHERE
    RIGHT(`peak_name`, 1) = LEFT(`river_name`, 1)
ORDER BY `mix`;

# Ex 12
SELECT `name`, date_format(`start`, '%Y-%m-%d') AS 'start'
FROM `games`
WHERE year(`start`) IN (2011, 2012)
ORDER BY `start`, `name`
limit 50;

# Ex 13
SELECT `user_name`, substring(`email`,  locate('@', `email`) + 1) AS 'Email Provider'
FROM `users`
ORDER BY `Email Provider` , `user_name`;

# Ex 14
SELECT `user_name`, `ip_address`
FROM `users`
WHERE `ip_address` LIKE '___.1%.%.___'
ORDER BY `user_name`;

# Ex 15
SELECT 
    `name`,
    (CASE
        WHEN HOUR(`start`) BETWEEN 0 AND 11 THEN 'Morning'
        WHEN HOUR(`start`) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END) AS 'Part of the day',
    (CASE
        WHEN `duration` <= 3 THEN 'Extra Short'
        WHEN `duration` <= 6 THEN 'Short'
        WHEN `duration` <= 10 THEN 'Long'
        ELSE 'Extra Long'
    END) AS 'Duration'
FROM
    `games`;
    
# Ex 16
SELECT `product_name`, `order_date`,
date_add(`order_date`, interval 3 day) AS 'pay_due',
date_add(`order_date`, interval 1 month) AS 'deliver_due'
FROM `orders`;
    


