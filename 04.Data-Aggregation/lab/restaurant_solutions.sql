# Ex 01
SELECT `department_id`, count(*) AS 'Number of employees'
FROM `employees`
GROUP BY `department_id`
ORDER BY `department_id`, `Number of employees`;

# Ex 02
SELECT `department_id`, round(avg(`salary`), 2) AS 'Average salary'
FROM `employees`
GROUP BY `department_id`
ORDER BY `department_id`;

# Ex 03
SELECT `department_id`, round(min(`salary`), 2) AS 'Min salary'
FROM `employees`
GROUP BY `department_id`
HAVING `Min salary` > 800;

# Ex 04
SELECT count(*) AS 'Count of appetizers'
FROM `products`
WHERE `category_id` = 2 AND `price` > 8;

# Ex 05
SELECT `category_id`, round(avg(`price`), 2) AS 'Average price',
round(min(`price`), 2) AS 'Cheapest product',
round(max(`price`), 2) AS 'Most expensive product'
FROM `products`
GROUP BY `category_id`;




