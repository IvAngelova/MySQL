# Ex 01
SELECT id, first_name, last_name, job_title
FROM employees
ORDER BY id;

# Ex 02
SELECT `id`, CONCAT(`first_name`,' ', `last_name`) AS 'full_name', 
`job_title`, `salary`
FROM `employees`
WHERE `salary` > 1000.00
ORDER BY id;

# Ex 03
UPDATE `employees`
SET `salary` = `salary` + 100
WHERE `job_title` = 'Manager';
SELECT `salary` FROM `employees`;

# Ex 04
CREATE VIEW `v_top_paid_employee` AS
SELECT * FROM `employees`
ORDER BY `salary` DESC
LIMIT 1;

SELECT * FROM `v_top_paid_employee`;

# Ex 05
SELECT * FROM `employees`
WHERE `department_id` = 4 AND `salary` >= 1000
ORDER BY `id`;

# Ex 06
DELETE FROM `employees`
WHERE `department_id` = 2 OR `department_id` = 1;
SELECT * FROM `employees`
ORDER BY `id`;




