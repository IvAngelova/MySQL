CREATE SCHEMA `movies`;
USE `movies`;

CREATE TABLE `directors` (
`id` INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
`director_name` VARCHAR(50) NOT NULL,
`notes` TEXT
);

CREATE TABLE `genres` (
`id` INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
`genre_name` VARCHAR(50) NOT NULL,
`notes` TEXT
);

CREATE TABLE `categories` (
`id` INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
`category_name` VARCHAR(50) NOT NULL,
`notes` TEXT
);

CREATE TABLE `movies` (
`id` INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
`title` VARCHAR(50) NOT NULL UNIQUE,
`director_id` INT,
`copyright_year` DATE,
`length` INT,
`genre_id` INT ,
`category_id` INT ,
`rating` FLOAT,
`notes` TEXT,
CONSTRAINT fk_movies_directors
FOREIGN KEY (`director_id`) REFERENCES `directors` (`id`),
CONSTRAINT fk_movies_genres
FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`),
CONSTRAINT fk_movies_categories
FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
);


INSERT INTO `directors`
VALUES
(1, 'Ivan', 'KHCKD,HVCK,'),
(2, 'Dragan', 'rgthnbygnh,'),
(3, 'Petkan', 'KHCKkfjff'),
(4, 'Ivanka', 'KHCKkfjfxgfxgbfxf'),
(5, 'Mona', 'KHCKkfjffghrikgvhkfbgff');

INSERT INTO `genres`
VALUES
(1, 'Horror', 'KHCKD,HVCK,'),
(2, 'Comedy', 'rgthnbygnh,'),
(3, 'Romance', 'KHCKkfjff'),
(4, 'Action', 'KHCKkfjfxgfxgbfxf'),
(5, 'Thriller', 'KHCKkfjffghrikgvhkfbgff');

INSERT INTO `categories`
VALUES
(1, 'PG6', 'KHCKD,HVCK,'),
(2, 'PG13', 'rgthnbygnh,'),
(3, 'PG16', 'KHCKkfjff'),
(4, 'PG18', 'KHCKkfjfxgfxgbfxf'),
(5, 'PG0', 'KHCKkfjffghrikgvhkfbgff');

INSERT INTO `movies`
VALUES
(1, 'kcnddkbv', 1, '2020-09-01', NULL, 5, 3, 5.0, 'KHCKD,HVCK,'),
(2, 'RFGRG', 5, '2020-09-01', NULL, 2, 4, 3.0, 'KHCKD,HVCK,'),
(3, 'dfgdxxhb', 2, '2020-09-01', NULL, 1, 3, 2.0, 'KHCKD,HVCK,'),
(4, 'zfdgtbn', 4, '2020-09-01', NULL, 2, 5, 1.0, 'KHCKD,HVCK,'),
(5, 'zfrgrbhgft', 3, '2020-09-01', NULL, 4, 1, 4.5, 'KHCKD,HVCK,');
