CREATE SCHEMA `gamebar`;
USE `gamebar`;

CREATE TABLE `employees`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(45) NOT NULL,
`last_name` VARCHAR(45) NOT NULL
);

CREATE TABLE `categories`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(45) NOT NULL
);

CREATE TABLE `products`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(45) NOT NULL,
`category_id` INT NOT NULL
);

INSERT INTO `employees`(`first_name`, `last_name`)
VALUES
('Ivan', 'Ivanov'),
('Petar', 'Petrov'),
('Ina', 'Indjova');

ALTER TABLE `employees`
ADD COLUMN `middle_name` VARCHAR(45);

ALTER TABLE `products`
ADD CONSTRAINT fk_products_categories 
FOREIGN KEY `products` (`category_id`) REFERENCES `categories` (`id`);

ALTER TABLE `employees`
MODIFY COLUMN `middle_name` VARCHAR(100);
