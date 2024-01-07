CREATE TABLE `mountains` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL
);

CREATE TABLE `peaks` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL,
`mountain_id` INT
);

ALTER TABLE `peaks`
ADD CONSTRAINT `fk_peeks_mountans`
FOREIGN KEY (`mountain_id`)
REFERENCES `mountains` (`id`);