# Ex 01
CREATE TABLE `mountains` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30) NOT NULL
);

CREATE TABLE `peaks` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30) NOT NULL,
`mountain_id` INT,
CONSTRAINT fk_peaks_mountains
FOREIGN KEY (`mountain_id`)
REFERENCES `mountains`(`id`)
);

# Ex 02
SELECT c.`id` AS 'driver_id', v.`vehicle_type`, concat(c.`first_name`, ' ', c.`last_name`) AS 'driver_name' 
FROM `campers` AS c
JOIN `vehicles` AS v
ON c.`id` = v.`driver_id`;

# Ex 03
SELECT r.`starting_point`, r.`end_point`, r.`leader_id` , concat(c.`first_name`, ' ', c.`last_name`) AS 'leader_name'
FROM `routes` AS r
JOIN `campers` AS c
ON c.`id` = r.`leader_id`;

# Ex 04
CREATE TABLE `mountains` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30) NOT NULL
);

CREATE TABLE `peaks` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30) NOT NULL,
`mountain_id` INT,
CONSTRAINT fk_peaks_mountains
FOREIGN KEY (`mountain_id`)
REFERENCES `mountains`(`id`)
ON DELETE CASCADE
);
