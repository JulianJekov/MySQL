INSERT INTO `courses` (`name`, `duration_hours`, `start_date`, `teacher_name`, `description`, `university_id`)
SELECT 
CONCAT(c.`teacher_name`, ' ', 'course'), 
CHAR_LENGTH(c.`name`) / 10, 
DATE_ADD(c.`start_date`, interval 5 day),
REVERSE(c.`teacher_name`),
CONCAT('Course', ' ', c.`teacher_name`, REVERSE(c.`description`)),
DAY(c.`start_date`)
FROM `courses` AS c
WHERE c.`id` <= 5;