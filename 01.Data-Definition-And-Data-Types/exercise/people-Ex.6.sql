CREATE SCHEMA `people`;
USE `people`;

CREATE TABLE `people`(
`id` INT UNIQUE PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(200) NOT NULL ,
`picture` BLOB,
`height` FLOAT(5,2) ,
`weight` FLOAT(5,2) ,
`gender` CHAR(1) NOT NULL,
`birthdate` DATE NOT NULL,
`biography` TEXT
);

INSERT INTO `people`
VALUES 
(1, 'Ivan', NULL, 1.78, 75.35, 'm', '1984-08-25', 'gskljffjelifjlhjgrl' ),
(2, 'Petar', NULL, 1.70, 80.75, 'm', '1989-11-05', 'gskljffjelijflkjgldrl'),
(3, 'Lili', NULL, 1.65, 57.75, 'f', '1995-04-19', 'gskljffjelgldrl'),
(4, 'Jenq', NULL, 1.72, 60.85, 'f', '1971-04-17', 'gskljffjelgldrlhjuhkgugv'),
(5, 'Mitko', NULL, 1.80, 82.34, 'm', '1990-12-01', 'gskljffjelgldrlhjuhk');
