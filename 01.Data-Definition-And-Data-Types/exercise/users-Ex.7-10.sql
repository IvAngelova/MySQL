CREATE SCHEMA `users`;
USE `users`;

CREATE TABLE `users`(
`id` INT PRIMARY KEY UNIQUE AUTO_INCREMENT,
`username` VARCHAR(30) NOT NULL UNIQUE,
`password` VARCHAR(26) NOT NULL,
`profile_picture` BLOB,
`last_login_time` DATETIME,
`is_deleted` BOOL 
);

INSERT INTO `users`
VALUES
(1, 'ijcdld', '5uedhkd', NULL, '2021-12-08 12:45:23', true),
(2, 'ijcd', '5uerffdhkd', NULL, '2021-11-08 02:45:23', false),
(3, 'hfklrg', 'ldhkdd', NULL, '2021-11-08 10:05:03', false),
(4, 'h78lrg', 'lj09jhkdd', NULL, '2021-11-08 10:05:03', false),
(5, 'h78lpikdjhcld', 'ldfmjrlkg', NULL, '2021-10-18 22:15:02', false);


ALTER TABLE `users`
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users
PRIMARY KEY(`id`, `username`);

ALTER TABLE `users`
MODIFY COLUMN `last_login_time` TIMESTAMP;

ALTER TABLE `users`
CHANGE COLUMN `last_login_time` `last_login_time` DATETIME DEFAULT NOW();

ALTER TABLE `users`
DROP PRIMARY KEY,
ADD CONSTRAINT pk_id
PRIMARY KEY(`id`),
ADD CONSTRAINT uq_username
UNIQUE (`username`);






