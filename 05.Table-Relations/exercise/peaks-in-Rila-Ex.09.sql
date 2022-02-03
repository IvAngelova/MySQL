# Ex 09
SELECT m.`mountain_range`, p.`peak_name`, p.`elevation`
FROM `mountains` AS m
JOIN `peaks` AS p
ON m.`id` = p. `mountain_id`
WHERE  m.`mountain_range` = 'Rila'
ORDER BY p.`elevation` DESC;

# Demo
SELECT *
FROM `mountains` AS m
JOIN `peaks` AS p
ON m.`id` = p.`mountain_id`
JOIN `mountains_countries` AS mc
ON mc.`mountain_id` = m.`id`
WHERE  m.`mountain_range` = 'Rila'
ORDER BY p.`elevation` DESC;