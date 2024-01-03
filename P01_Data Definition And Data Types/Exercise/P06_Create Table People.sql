CREATE TABLE `people` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(200) NOT NULL,
    `picture` BLOB,
    `height` DECIMAL(10, 2),
    `weight` DECIMAL(10, 2),
    `gender` ENUM('m', 'f') NOT NULL,
    `birthdate` DATE NOT NULL,
    `biography` TEXT
);

INSERT INTO  `people` (`name`, `gender`, `birthdate`) 
VALUES 
('Pesho', 'm', DATE (NOW())),
('Gosho', 'm', DATE (NOW())),
('Tosho', 'm', DATE (NOW())),
('Ivan', 'm', DATE (NOW())),
('Julian', 'm', DATE (NOW()));
