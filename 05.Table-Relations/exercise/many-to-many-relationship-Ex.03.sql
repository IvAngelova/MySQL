# Ex 03
CREATE SCHEMA `many-to-many`;
use `many-to-many`;

CREATE TABLE `students` (
`student_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(20) not NULL
);

INSERT INTO `students`
VALUES
(1, 'Mila'),
(2, 'Toni'),
(3, 'Ron');

CREATE TABLE `exams`(
`exam_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(20) NOT NULL
);

ALTER TABLE `exams` AUTO_INCREMENT = 101;
INSERT INTO `exams` (`name`)
VALUES
('Spring MVC'),
('Neo4j'),
('Oracle 11g');

CREATE TABLE `students_exams` (
`student_id` INT,
`exam_id` INT,
CONSTRAINT pk_students_exams
PRIMARY KEY (`student_id`, `exam_id`),
CONSTRAINT fk_students_exams_students
FOREIGN KEY (`student_id`)
REFERENCES `students`(`student_id`),
CONSTRAINT fk_students_exams_exams
FOREIGN KEY (`exam_id`)
REFERENCES `exams`(`exam_id`)
);

INSERT INTO `students_exams` 
VALUES
(1,	101),
(1,	102),
(2,	101),
(3,	103),
(2,	102),
(2, 103);

