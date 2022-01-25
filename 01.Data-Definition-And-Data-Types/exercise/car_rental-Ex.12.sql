CREATE DATABASE `car_rental`;
USE `car_rental`;

CREATE TABLE `categories` (
	`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
    `category` VARCHAR(30) NOT NULL,
    `daily_rate` DECIMAL NOT NULL,
    `weekly_rate` DECIMAL NOT NULL,
    `monthly_rate` DECIMAL NOT NULL,
	`weekend_rate` DECIMAL NOT NULL
);

CREATE TABLE `cars`(
	`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `plate_number` VARCHAR(10) NOT NULL UNIQUE,
    `make` VARCHAR(50),
    `model` VARCHAR(50) NOT NULL,
    `car_year` INT,
    `category_id` INT NOT NULL,
    `doors` INT,
    `picture` BLOB,
    `car_condition` TEXT,
    `available` BOOL NOT NULL,
    CONSTRAINT fk_cars_categories
    FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
);

CREATE TABLE `employees` (
	`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`first_name` VARCHAR(30) NOT NULL,
	`last_name` VARCHAR(30) NOT NULL,
	`title` VARCHAR(50) NOT NULL,
	`notes` TEXT
);

CREATE TABLE `customers` (
	`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    `driver_licence_number` VARCHAR(20) NOT NULL, 
    `full_name` VARCHAR(200) NOT NULL,
    `address` VARCHAR(200),
    `city` VARCHAR(30),
    `zip_code` INT,
    `notes` TEXT
);

CREATE TABLE `rental_orders` (
	`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `employee_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `car_id` INT NOT NULL,
    `car_condition` VARCHAR(20),
    `tank_level` VARCHAR(20),
    `kilometrage_start` DOUBLE, 
    `kilometrage_end` DOUBLE,
    `total_kilometrage` DOUBLE, 
    `start_date` DATE NOT NULL,
    `end_date` DATE NOT NULL,
    `total_days` INT NOT NULL,
    `rate_applied` DOUBLE,
    `tax_rate` DECIMAL,
    `order_status` VARCHAR(70), 
    `notes` TEXT,
     CONSTRAINT fk_rental_orders_employees
    FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`),
     CONSTRAINT fk_rental_orders_customers
    FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
     CONSTRAINT fk_rental_orders_cars
    FOREIGN KEY (`car_id`) REFERENCES `cars` (`id`)
);

INSERT INTO `categories`
	(`category`, `daily_rate`, `weekly_rate`, `monthly_rate`, `weekend_rate`)
VALUES
	('Compact',15.6,90.4,300.9,25.3),
    ('SUV',30.3,150.8,500.1,45.67),
    ('Limousine',45.8,250.4,850.6,75.7);

INSERT INTO `cars` 
	(`plate_number`, `make`, `model`, `car_year`, `category_id`, `doors`, `picture`, `car_condition`, `available`)
VALUES
	('A8972KB','VW','Polo',2017,1,4,NULL,'Excellent condition',true),
    ('CB3462AA','Audi','A3',2018,2,5,NULL,'Brand new',false),
    ('CB3783CH','Audi','A8',2017,3,4,NULL,'Brand new',true);

INSERT INTO `employees` 
	(`first_name`, `last_name`, `title`)
VALUES
	('Qnko','Halilov', 'Office director'),
    ('Pesho','Peshev', 'Order processing'), 
    ('Gosho','Goshev', 'Car Managment');
    
INSERT INTO `customers` 
	(`driver_licence_number`, `full_name`, `city`)
VALUES
	(456635892, 'Chefo Chefov','Varna'),
    (326373434, 'Mima Georgieva','Milioni'),
    (120958035, 'Ivan Draganov','Poduene');
    
INSERT INTO `rental_orders` 
(`employee_id`, `customer_id`, `car_id`, `start_date`, `end_date`, `total_days`) 
VALUES (1, 1, 2, "2019-11-29", "2019-12-05", 6);
INSERT INTO `rental_orders`
 (`employee_id`, `customer_id`, `car_id`, `start_date`, `end_date`, `total_days`)
 VALUES (2, 1, 2, "2020-01-01", "2020-01-03", 2);
INSERT INTO `rental_orders` 
(`employee_id`, `customer_id`, `car_id`, `start_date`, `end_date`, `total_days`)
 VALUES (2, 3, 2, "2019-12-12", "2019-12-15", 3);
