# Ex 02
INSERT INTO `coaches` (`first_name`, `last_name`, `salary`, `coach_level`)
SELECT `first_name`, `last_name`, `salary` * 2, char_length(`first_name`)
FROM `players`
WHERE `age` >= 45;

# Ex 03
UPDATE `coaches`
SET `coach_level` = `coach_level` + 1
WHERE `id` IN (SELECT `coach_id` FROM players_coaches) AND `first_name` LIKE 'A%';

# Ex 04
DELETE FROM players
WHERE `age` >= 45;

# Ex 05
SELECT `first_name`, `age`, `salary`
FROM players
ORDER BY `salary` DESC;

# Ex 06
SELECT 
    p.`id`,
    CONCAT(p.`first_name`, ' ', p.`last_name`) AS 'full_name',
    p.`age`,
    p.`position`,
    p.`hire_date`
FROM
    players AS p
        JOIN
    `skills_data` AS sd ON p.`skills_data_id` = sd.`id`
WHERE
    p.`age` < 23 AND p.`hire_date` IS NULL
        AND sd.`strength` > 50
ORDER BY p.`salary` , p.`age`;

# Ex 07
SELECT 
    t.`name`,
    t.`established`,
    t.`fan_base`,
    COUNT(p.`id`) AS 'players_count'
FROM
    `teams` AS t
        LEFT JOIN
    `players` AS p ON p.`team_id` = t.`id`
GROUP BY t.`id`
ORDER BY `players_count` DESC , t.`fan_base` DESC;

# Ex 08
SELECT 
    MAX(sd.`speed`) AS 'max_speed', tow.`name` AS 'town_name'
FROM
    `skills_data` AS sd
        RIGHT JOIN
    `players` AS p ON p.`skills_data_id` = sd.`id`
        RIGHT JOIN
    `teams` AS t ON t.`id` = p.`team_id`
        RIGHT JOIN
    `stadiums` AS s ON s.`id` = t.`stadium_id`
        RIGHT JOIN
    `towns` AS tow ON tow.`id` = s.`town_id`
WHERE
    t.`name` != 'Devify'
GROUP BY tow.`id`
ORDER BY `max_speed` DESC , tow.`name`;

# Ex 09
SELECT 
    c.`name`,
    COUNT(p.`id`) AS 'total_count_of_players',
    SUM(p.`salary`) AS 'total_sum_of_salaries'
FROM
    `countries` AS c
        LEFT JOIN
    `towns` AS t ON t.`country_id` = c.`id`
        LEFT JOIN
    `stadiums` AS s ON t.`id` = s.`town_id`
        LEFT JOIN
    `teams` AS te ON te.`stadium_id` = s.`id`
        LEFT JOIN
    `players` AS p ON p.`team_id` = te.`id`
GROUP BY c.`name`
ORDER BY `total_count_of_players` DESC , c.`name`;

# Ex 10
DELIMITER $$
CREATE FUNCTION udf_stadium_players_count (stadium_name VARCHAR(30)) 
RETURNS INTEGER
DETERMINISTIC
BEGIN
	RETURN (SELECT 
    COUNT(p.`id`) AS 'total_count_of_players'
FROM
    `stadiums` AS s 
        LEFT JOIN
    `teams` AS te ON te.`stadium_id` = s.`id`
        LEFT JOIN
    `players` AS p ON p.`team_id` = te.`id`
WHERE s.`name` = stadium_name);
END $$
DELIMITER ;

SELECT udf_stadium_players_count ('Linklinks') as `count`; 

# Ex 11
DELIMITER $$
CREATE PROCEDURE `udp_find_playmaker` (min_dribble_points INT, team_name VARCHAR(45) )
BEGIN
		SELECT concat(p.`first_name`, ' ', p.`last_name`) AS 'full_name', p.`age`, p.`salary`, sd.`dribbling`, sd.`speed`, t.`name` AS 'team_name'
		FROM `players` AS p
		JOIN `skills_data` AS sd
		ON sd.`id` = p.`skills_data_id`
		JOIN `teams` AS t
		ON p.`team_id` = t.`id`
		WHERE sd.`dribbling` > min_dribble_points AND t.`name` = team_name AND sd.`speed` > (select avg(`speed`) FROM skills_data)
		ORDER BY sd.`speed` DESC
		LIMIT 1;
END $$
DELIMITER ;

CALL udp_find_playmaker (20, 'Skyble');



