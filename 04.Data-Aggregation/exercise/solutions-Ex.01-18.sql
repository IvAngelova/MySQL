# Ex 01
SELECT count(*) AS 'count'
FROM `wizzard_deposits`;

# Ex 02
SELECT max(`magic_wand_size`) AS 'longest_magic_wand'
FROM `wizzard_deposits`;

# Ex 03
SELECT `deposit_group`, max(`magic_wand_size`) AS 'longest_magic_wand'
FROM `wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY `longest_magic_wand`, `deposit_group`;

# Ex 04
SELECT `deposit_group`
FROM `wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY avg(`magic_wand_size`) ASC
LIMIT 1;

# Ex 05
SELECT `deposit_group`, sum(`deposit_amount`) AS 'total_sum'
FROM `wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY `total_sum`;

# Ex 06
SELECT `deposit_group`, sum(`deposit_amount`) AS 'total_sum'
FROM `wizzard_deposits`
WHERE `magic_wand_creator` = 'Ollivander family'
GROUP BY `deposit_group`
ORDER BY `deposit_group`;

# Ex 07
SELECT `deposit_group`, sum(`deposit_amount`) AS 'total_sum'
FROM `wizzard_deposits`
WHERE `magic_wand_creator` = 'Ollivander family'
GROUP BY `deposit_group`
HAVING `total_sum` < 150000
ORDER BY `total_sum` DESC;

# Ex 08
SELECT `deposit_group`, `magic_wand_creator`, min(`deposit_charge`) AS 'min_deposit_charge'
FROM `wizzard_deposits`
GROUP BY `deposit_group`, `magic_wand_creator`
ORDER BY `magic_wand_creator`, `deposit_group`;

# Ex 09
SELECT 
    (CASE
        WHEN `age` BETWEEN 0 AND 10 THEN '[0-10]'
        WHEN `age` BETWEEN 11 AND 20 THEN '[11-20]'
        WHEN `age` BETWEEN 21 AND 30 THEN '[21-30]'
        WHEN `age` BETWEEN 31 AND 40 THEN '[31-40]'
        WHEN `age` BETWEEN 41 AND 50 THEN '[41-50]'
        WHEN `age` BETWEEN 51 AND 60 THEN '[51-60]'
        ELSE '[61+]'
    END) AS 'age_group',
    COUNT(*) AS 'wizard_count'
FROM
    `wizzard_deposits`
GROUP BY `age_group`
ORDER BY `age_group`;

# Ex 10
SELECT left(`first_name`, 1) AS 'first_letter'
FROM `wizzard_deposits`
WHERE `deposit_group` = 'Troll Chest'
GROUP BY `first_letter`
ORDER BY `first_letter`;

# Ex 11
SELECT `deposit_group`, `is_deposit_expired`, avg(`deposit_interest`) AS 'avg_interest'
FROM `wizzard_deposits`
WHERE `deposit_start_date` >  '1985-01-01'
GROUP BY `deposit_group`, `is_deposit_expired`
ORDER BY `deposit_group` DESC, `is_deposit_expired`;

# Ex 12
SELECT `department_id`, min(`salary`) AS 'min_salary'
FROM `employees`
WHERE `department_id` IN (2, 5, 7) AND `hire_date` > '2000-01-01'
GROUP BY `department_id`
ORDER BY `department_id`;

# Ex 13
CREATE TABLE `high_paid_employees` AS
SELECT * 
FROM `employees`
WHERE `salary` > 30000;

DELETE FROM `high_paid_employees`
WHERE `manager_id` = 42; 

UPDATE `high_paid_employees`
SET `salary` = `salary` + 5000
WHERE `department_id` = 1;

SELECT `department_id`, avg(`salary`) AS `avg_salary`
FROM `high_paid_employees`
GROUP BY `department_id`
ORDER BY `department_id`;

# Ex 14
SELECT `department_id`, max(`salary`) AS 'max_salary'
FROM `employees`
GROUP BY `department_id`
HAVING `max_salary` NOT BETWEEN 30000 AND 70000
ORDER BY `department_id`;

# Ex 15
SELECT count(`salary`)
FROM `employees`
WHERE `manager_id` IS NULL;

# Ex 16 - SubQuery
SELECT 
    e.`department_id`,
    (SELECT DISTINCT
            e2.`salary`
        FROM
            `employees` AS e2
        WHERE
            e2.`department_id` = e.`department_id`
        ORDER BY e2.`salary` DESC
        LIMIT 1 OFFSET 2) AS `third_highest_salary`
FROM
    `employees` AS e
GROUP BY e.`department_id`
HAVING `third_highest_salary` IS NOT NULL
ORDER BY e.`department_id`;

# Ex 17 - SubQuery
SELECT 
    e.`first_name`, e.`last_name`, e.`department_id`
FROM
    `employees` AS e
WHERE
    e.`salary` > (SELECT 
            AVG(e2.`salary`)
        FROM
            `employees` AS e2
        WHERE
            e2.`department_id` = e.`department_id`)
ORDER BY e.`department_id` , e.`employee_id`
LIMIT 10;

# Ex 18
SELECT `department_id`, sum(`salary`) AS 'total_salary'
FROM `employees`
GROUP BY `department_id`
ORDER BY `department_id`;





