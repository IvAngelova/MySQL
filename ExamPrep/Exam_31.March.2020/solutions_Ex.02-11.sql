# Ex 02
INSERT INTO addresses (`address`, `town`, `country` , `user_id`)
SELECT `username`, `password`, `ip`, `age`
FROM `users`
WHERE `gender` = 'M';

# Ex 03
UPDATE addresses
SET `country` = CASE
					WHEN `country` LIKE 'B%' THEN 'Blocked'
					WHEN `country` LIKE 'T%' THEN 'Test'
					WHEN `country` LIKE 'P%' THEN 'In Progress'
                    ELSE `country` -- !!! Column `country` can not be NULL!
				END;
                
# Ex 04
DELETE FROM addresses
WHERE `id` % 3 = 0;

# Ex 05
SELECT username, gender, age
FROM users
ORDER BY age DESC, username;

# Ex 06
SELECT 
    p.`id`,
    p.`date`,
    p.`description`,
    COUNT(c.`id`) AS 'comments_count'
FROM
    `photos` AS p
        JOIN
    `comments` AS c ON p.`id` = c.`photo_id`
GROUP BY p.`id`
ORDER BY `comments_count` DESC , p.`id`
LIMIT 5;

# Ex 07
SELECT 
    CONCAT(u.`id`, ' ', u.`username`) AS 'id_username',
    u.`email`
FROM
    users AS u
        JOIN
    users_photos AS up ON u.`id` = up.`user_id`
WHERE
    up.`user_id` = up.`photo_id`
ORDER BY u.`id`;

# Ex 08
SELECT 
    p.`id` AS 'photo_id',
    COUNT(DISTINCT l.`id`) AS 'likes_count',
    COUNT(DISTINCT c.`id`) AS 'comments_count'
FROM
    photos AS p
        LEFT JOIN
    `comments` AS c ON c.`photo_id` = p.`id`
        LEFT JOIN
    `likes` AS l ON l.photo_id = p.id
GROUP BY p.`id`
ORDER BY `likes_count` DESC , `comments_count` DESC , p.`id`;

# Ex 09
SELECT 
    CONCAT(SUBSTRING(`description`, 1, 30), '...') AS 'summary',
    `date`
FROM
    `photos`
WHERE
    DAY(`date`) = 10
ORDER BY `date` DESC;


# Ex 10
DELIMITER $$
CREATE FUNCTION udf_users_photos_count(username VARCHAR(30)) 
RETURNS INTEGER
DETERMINISTIC
BEGIN
	RETURN (SELECT count(p.`id`)
			FROM `users` AS u
			JOIN `users_photos` AS up
			ON u.`id` = up.`user_id`
			JOIN `photos` AS p
			ON up.`photo_id` = p.`id`
			WHERE u.`username` = username);
END $$
DELIMITER ;

SELECT udf_users_photos_count('ssantryd') AS photosCount;

# Ex 11
DELIMITER $$
CREATE PROCEDURE `udp_modify_user`(address VARCHAR(30), town VARCHAR(30)) 
BEGIN
    UPDATE `users` AS u
	JOIN `addresses` AS a
	ON u.`id` = a.`user_id`
	SET u.`age` = u.`age` + 10
	WHERE a.`address` = address AND a.`town` = town; 
END $$
DELIMITER ;

CALL udp_modify_user ('97 Valley Edge Parkway', 'Divinópolis');
SELECT u.username, u.email,u.gender,u.age,u.job_title FROM users AS u
WHERE u.username = 'eblagden21';





