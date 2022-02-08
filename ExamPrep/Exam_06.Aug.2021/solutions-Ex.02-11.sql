# Ex 02
INSERT INTO `games` (`name`, `rating`, `budget`, `team_id`)
SELECT lower(reverse(substring(`name`, 2))), `id`, `leader_id` * 1000, `id`
FROM teams
WHERE `id` BETWEEN 1 AND 9;

# Ex 03
UPDATE `employees`
SET `salary` = `salary` + 1000
WHERE `id` IN (SELECT `leader_id` FROM `teams`) AND `age` < 40 AND `salary` < 5000;

# Ex 04
DELETE FROM `games`
WHERE `release_date` IS NULL AND `id` NOT IN (SELECT `game_id` FROM `games_categories`);

# Ex 05
SELECT `first_name`, `last_name`, `age`, `salary`, `happiness_level`
FROM `employees`
ORDER BY `salary`, `id`;

# Ex 06
SELECT 
    t.`name` AS 'team_name',
    a.`name` AS 'address_name',
    CHAR_LENGTH(a.`name`) AS 'count_of_characters'
FROM
    `teams` AS t
        JOIN
    `offices` AS o ON t.`office_id` = o.`id`
        JOIN
    `addresses` AS a ON a.`id` = o.`address_id`
WHERE
    o.`website` IS NOT NULL
ORDER BY `team_name` , `address_name`;

# Ex 07
SELECT 
    c.`name`,
    COUNT(g.`id`) AS 'games_count',
    ROUND(AVG(g.`budget`), 2) AS 'avg_budget',
    MAX(g.`rating`) AS 'max_rating'
FROM
    `categories` AS c
        JOIN
    `games_categories` AS gc ON gc.`category_id` = c.`id`
        JOIN
    `games` AS g ON g.`id` = gc.`game_id`
GROUP BY c.`name`
HAVING `max_rating` >= 9.5
ORDER BY `games_count` DESC , c.`name`;

# Ex 08
SELECT 
    g.`name`,
    g.`release_date`,
    CONCAT(SUBSTRING(g.`description`, 1, 10), '...') AS 'summary',
    (CASE
        WHEN MONTH(g.`release_date`) IN (1 , 2, 3) THEN 'Q1'
        WHEN MONTH(g.`release_date`) IN (4 , 5, 6) THEN 'Q2'
        WHEN MONTH(g.`release_date`) IN (7 , 8, 9) THEN 'Q3'
        ELSE 'Q4'
    END) AS 'quarter',
    t.`name` AS 'team_name'
FROM
    `games` AS g
        JOIN
    `teams` AS t ON g.`team_id` = t.`id`
WHERE
    g.`name` LIKE '%2'
        AND MONTH(g.`release_date`) % 2 = 0
        AND YEAR(g.`release_date`) = 2022
ORDER BY `quarter`;

# Ex 09
SELECT 
    g.`name`,
    IF(g.`budget` < 50000,
        'Normal budget',
        'Insufficient budget') AS 'budget_level',
    t.`name` AS 'team_name',
    a.`name` AS 'address_name'
FROM
    `games` AS g
        JOIN
    `teams` AS t ON g.`team_id` = t.`id`
        JOIN
    `offices` AS o ON t.`office_id` = o.`id`
        JOIN
    `addresses` AS a ON o.`address_id` = a.`id`
WHERE
    g.`release_date` IS NULL
        AND g.`id` NOT IN (SELECT 
            `game_id`
        FROM
            `games_categories`)
ORDER BY g.`name`;

# Ex 10
DELIMITER $$
CREATE FUNCTION `udf_game_info_by_name`(game_name VARCHAR (20))
RETURNS TEXT
DETERMINISTIC
BEGIN
	RETURN (SELECT concat('The ', g.`name`, ' is developed by a ', t.`name`, ' in an office with an address ', a.`name`)
			FROM `games` AS g 
            JOIN `teams` AS t
            ON g.`team_id` = t.`id`
            JOIN `offices` AS o
            ON t.`office_id` = o.`id`
            JOIN `addresses` AS a
            ON a.`id` = o.`address_id`
            WHERE g.`name` = game_name);
END $$
DELIMITER ;

SELECT udf_game_info_by_name('Fix San') AS info;

# Ex 11
DELIMITER $$
CREATE PROCEDURE `udp_update_budget` (min_game_rating FLOAT)
BEGIN
	UPDATE `games`
	SET `budget` = `budget` + 100000, `release_date` = date_add(`release_date`, INTERVAL 1 YEAR)
	WHERE `rating` > min_game_rating AND `release_date` IS NOT NULL AND `id` NOT IN (SELECT `game_id` FROM `games_categories`);
END $$
DELIMITER ;

CALL udp_update_budget (8);

SELECT *
FROM games
WHERE `rating` > 8 AND `release_date` IS NOT NULL AND `id` NOT IN (SELECT `game_id` FROM `games_categories`);
			
