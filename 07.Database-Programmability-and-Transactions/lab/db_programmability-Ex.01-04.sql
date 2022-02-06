# Ex 01
DELIMITER %%
CREATE FUNCTION `ufn_count_employees_by_town` (town_name VARCHAR(50))
RETURNS INTEGER
DETERMINISTIC
BEGIN

RETURN (SELECT count(*) 
FROM `employees` AS e
JOIN `addresses` AS d
USING (`address_id`)
JOIN `towns` AS t
USING (`town_id`)
WHERE t.`name` = town_name
GROUP BY t.`name`);

END %%
DELIMITER ;

# Ex 02
DELIMITER %%
CREATE PROCEDURE `usp_raise_salaries` (department_name  VARCHAR(25))
BEGIN
UPDATE `employees` AS e
JOIN `departments` AS d
ON d.`department_id` = e.`department_id`
SET e.`salary` = e.`salary`* 1.05
WHERE d.`name` = department_name;
END%%
DELIMITER ;

# Ex 03
DELIMITER %%
CREATE PROCEDURE `usp_raise_salary_by_id` (id INT)
BEGIN
     START TRANSACTION;
	IF((SELECT count(*)
           FROM employees
		   WHERE employee_id = id) = 1)
	THEN 
		UPDATE employees
	    SET salary = salary * 1.05
        WHERE employee_id = id;
        COMMIT;
	ELSE
		ROLLBACK;
 END IF;
END%%
DELIMITER ;

# Ex 04
CREATE TABLE deleted_employees(
	employee_id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	middle_name VARCHAR(20),
	job_title VARCHAR(50),
	department_id INT,
	salary DOUBLE 
);

DELIMITER %%
CREATE TRIGGER `employees_AFTER_DELETE` AFTER DELETE ON `employees` FOR EACH ROW
BEGIN
    INSERT INTO deleted_employees (first_name, last_name, middle_name, job_title, department_id, salary)
	VALUES(OLD.first_name, OLD.last_name, OLD.middle_name, OLD.job_title, OLD.department_id, OLD.salary);
END%%
DELIMITER ;

