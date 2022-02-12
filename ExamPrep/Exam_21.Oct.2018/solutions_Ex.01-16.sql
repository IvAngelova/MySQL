# Ex 01
INSERT INTO `travel_cards` (`card_number`, `job_during_journey`, `colonist_id`, `journey_id`)
SELECT 
(CASE
	WHEN `birth_date` > '1980-01-01' THEN concat(year(`birth_date`), day(`birth_date`), left(`ucn` , 4))
	ELSE concat(year(`birth_date`), month(`birth_date`), right(`ucn` , 4))
 END) ,
 (CASE
	WHEN `id` % 2 = 0 THEN 'Pilot'
	WHEN `id` % 3 = 0 THEN 'Cook'
    ELSE 'Engineer'
  END), 
  `id`, left(`ucn`, 1)
FROM colonists
WHERE id BETWEEN 96 AND 100;

# Ex 02
UPDATE `journeys`
SET `purpose` = (CASE
					WHEN `id` % 2 = 0 THEN 'Medical'
					WHEN `id` % 3 = 0 THEN 'Technical'
					WHEN `id` % 5 = 0 THEN 'Educational'
					WHEN `id` % 7 = 0 THEN 'Military'
                    ELSE `purpose`
				END);
                
# Ex 03
DELETE FROM colonists
WHERE `id` NOT IN (SELECT `colonist_id` FROM travel_cards);

# Ex 04
SELECT 
    card_number, job_during_journey
FROM
    travel_cards
ORDER BY card_number;

# Ex 05
SELECT 
    id, CONCAT(first_name, ' ', last_name) AS 'full_name', ucn
FROM
    colonists
ORDER BY first_name , last_name , id;

# Ex 06
SELECT 
    id, journey_start, journey_end
FROM
    journeys
WHERE
    purpose = 'Military'
ORDER BY journey_start;

# Ex 07
SELECT 
    c.id, CONCAT(c.first_name, ' ', c.last_name) AS 'full_name'
FROM
    colonists AS c
        JOIN
    travel_cards AS tc ON tc.colonist_id = c.id
WHERE
    tc.job_during_journey = 'Pilot'
ORDER BY id;

# Ex 08
SELECT 
   count(c.`id`) AS 'count'
FROM
    colonists AS c
        JOIN
    travel_cards AS tc ON tc.colonist_id = c.id
		JOIN 
	journeys AS j ON j.id = tc.journey_id
WHERE
    j.purpose = 'Technical';
    
# Ex 09
SELECT 
    ss.`name`, sp.`name`
FROM
    spaceships AS ss
        JOIN
    journeys AS j ON ss.id = j.spaceship_id
        JOIN
    spaceports AS sp ON sp.id = j.destination_spaceport_id
ORDER BY `light_speed_rate` DESC
LIMIT 1;

# Ex 10
SELECT 
    ss.`name`, ss.`manufacturer`
FROM
    spaceships AS ss
        JOIN
    `journeys` AS j ON ss.`id` = j.`spaceship_id`
        JOIN
    `travel_cards` AS tc ON j.`id` = tc.`journey_id`
        JOIN
    `colonists` AS c ON tc.`colonist_id` = c.`id`
WHERE
    c.`birth_date` < '2019-01-01'
        AND c.`birth_date` > '1989-01-01'
        AND tc.`job_during_journey` = 'Pilot'
ORDER BY ss.`name`;

# Ex 11
SELECT 
    p.`name`, s.`name`
FROM
    planets AS p
        LEFT JOIN
    `spaceports` AS s ON p.`id` = s.`planet_id`
        LEFT JOIN
    `journeys` AS j ON s.`id` = j.`destination_spaceport_id`
WHERE
    j.`purpose` = 'Educational'
ORDER BY s.`name` DESC;

# Ex 12
SELECT 
    p.`name`, COUNT(j.`id`) AS 'journeys_count'
FROM
    `planets` AS p
        JOIN
    `spaceports` AS s ON p.`id` = s.`planet_id`
        JOIN
    `journeys` AS j ON s.`id` = j.`destination_spaceport_id`
GROUP BY p.`name`
ORDER BY `journeys_count` DESC , p.`name`;

# Ex 13
SELECT 
    j.`id`, p.`name`, s.`name`, j.`purpose`
FROM
    `journeys` AS j
        JOIN
    `spaceports` AS s ON j.`destination_spaceport_id` = s.`id`
        JOIN
    `planets` AS p ON p.`id` = s.`planet_id`
ORDER BY TIMESTAMPDIFF(day,
    `journey_start`,
    `journey_end`)
LIMIT 1;

# Ex 14
SELECT tc.`job_during_journey` AS 'job_name'
FROM travel_cards AS tc
JOIN `colonists` AS c
ON c.`id` = tc.`colonist_id`
JOIN `journeys` AS j
ON tc.`journey_id` = j.`id`
WHERE j.`id` = (SELECT `id`
				FROM `journeys`
				ORDER BY timestampdiff(day, `journey_start`, `journey_end`) DESC
				LIMIT 1)
GROUP BY tc.`job_during_journey`
ORDER BY count(c.`id`)
LIMIT 1;

# Ex 15

DELIMITER //
CREATE FUNCTION udf_count_colonists_by_destination_planet(planet_name VARCHAR(30))
  RETURNS INT
  DETERMINISTIC
  BEGIN
    RETURN (SELECT count(tc.colonist_id)
      FROM  travel_cards tc
      JOIN journeys j on tc.journey_id = j.id
      JOIN spaceports s on j.destination_spaceport_id = s.id
      JOIN planets p on s.planet_id = p.id
      WHERE p.name = planet_name
    );
  END //
DELIMITER ;

SELECT p.name, udf_count_colonists_by_destination_planet('Otroyphus') AS count
FROM planets AS p
WHERE p.name = 'Otroyphus';

# Ex 16

DELIMITER //
CREATE PROCEDURE udp_modify_spaceship_light_speed_rate(spaceship_name VARCHAR(50), light_speed_rate_increse INT(11))
  BEGIN
    if (SELECT count(ss.name) FROM spaceships ss WHERE ss.name = spaceship_name > 0) THEN
      UPDATE spaceships ss
        SET ss.light_speed_rate = ss.light_speed_rate + light_speed_rate_increse
        WHERE name = spaceship_name;
    ELSE
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Spaceship you are trying to modify does not exists.';
      ROLLBACK;
    END IF;
  END //
  
DELIMITER ;

 
    






