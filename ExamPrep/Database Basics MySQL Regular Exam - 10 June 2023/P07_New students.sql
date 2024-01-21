SELECT 
CONCAT(s.`first_name`, ' ', s.`last_name`) AS 'fullname', 
SUBSTRING(s.`email`, 2, 10) AS 'username', 
REVERSE(s.`phone`) AS 'password'
FROM `students` AS s
LEFT JOIN `students_courses` AS sc ON s.`id` = sc.`student_id`
WHERE sc.`student_id` IS NULL
ORDER BY `password` DESC;