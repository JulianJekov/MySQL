DELIMITER $$

CREATE FUNCTION udf_average_alumni_grade_by_course_name(course_name VARCHAR(60))
RETURNS DECIMAL (19,2)
DETERMINISTIC
BEGIN
RETURN (
SELECT AVG(sc.`grade`)
FROM `students_courses` AS sc
JOIN `students` AS s ON sc.`student_id` = s.`id`
JOIN `courses` AS c ON sc.`course_id` = c.`id`
WHERE c.`name` = course_name AND s.`is_graduated` = 1
);
END $$