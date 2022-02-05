# Ex 01
SELECT e.`employee_id`, concat(e.first_name, ' ', e.last_name) AS 'full_name', d.`department_id`, d.`name` AS 'department_name'
FROM employees AS e
JOIN departments AS d
ON d.manager_id = e.employee_id
ORDER BY e.employee_id
LIMIT 5;

# Ex 02
SELECT t.town_id, t.`name` AS `town_name`, a.address_text
FROM addresses AS a
LEFT JOIN towns AS t
USING (town_id)
where t.`name` IN ('San Francisco', 'Sofia', 'Carnation')
ORDER BY t.town_id, a.address_id;

# Ex 03
SELECT employee_id, first_name, last_name, department_id, salary 
FROM employees
WHERE manager_id IS NULL;

# Ex 04
SELECT count(*) AS 'count'
FROM employees
WHERE salary > (
SELECT avg(salary) FROM employees
);
