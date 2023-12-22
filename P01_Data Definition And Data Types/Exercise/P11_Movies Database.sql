CREATE DATABASE `movies`;

CREATE TABLE `directors`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `director_name` VARCHAR(20) NOT NULL,
    `notes` TEXT
);

CREATE TABLE `genres` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `genre_name` VARCHAR(20) NOT NULL,
    `notes` TEXT
);

CREATE TABLE `categories` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `category_name` VARCHAR(20) NOT NULL,
    `notes` TEXT
);

CREATE TABLE `movies` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `title` VARCHAR(50) NOT NULL,
    `director_id` INT,
    `copyright_year` INT,
    `length` INT,
    `genre_id` INT,
    `category_id` INT,
    `rating` DOUBLE, 
    `notes` TEXT
);

-- ALTER TABLE `movies`

-- ADD CONSTRAINT fk_movies_directors
-- FOREIGN KEY (`director_id`)
-- REFERENCES `directors` (`id`),

-- ADD CONSTRAINT fk_movies_genres
-- FOREIGN KEY (`genre_id`)
-- REFERENCES `genres` (`id`),

-- ADD CONSTRAINT fk_movies_categories
-- FOREIGN KEY (`category_id`)
-- REFERENCES `categories` (`id`);

INSERT INTO `directors` (`director_name`, `notes`) VALUE ('TestName', 'TestNotes'), ('TestName', 'TestNotes'), ('TestName', 'TestNotes'), ('TestName', 'TestNotes'), ('TestName', 'TestNotes');
INSERT INTO `genres` (`genre_name`, `notes`) VALUE ('TestName', 'TestNotes'), ('TestName', 'TestNotes'), ('TestName', 'TestNotes'), ('TestName', 'TestNotes'), ('TestName', 'TestNotes');
INSERT INTO `categories` (`category_name`, `notes`) VALUE ('TestName', 'TestNotes'), ('TestName', 'TestNotes'), ('TestName', 'TestNotes'), ('TestName', 'TestNotes'), ('TestName', 'TestNotes');

INSERT INTO `movies` (`title`) VALUES ('TitleTest');
INSERT INTO `movies` (`title`) VALUES ('TitleTest');
INSERT INTO `movies` (`title`) VALUES ('TitleTest');
INSERT INTO `movies` (`title`) VALUES ('TitleTest');
INSERT INTO `movies` (`title`) VALUES ('TitleTest');
