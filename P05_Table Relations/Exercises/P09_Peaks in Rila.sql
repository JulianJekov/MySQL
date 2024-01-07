SELECT 
    `mountain_range`,
    `peak_name`,
    `elevation` AS 'peak_elevation'
FROM
    `mountains` m
        JOIN
    `peaks` p ON m.`id` = p.`mountain_id`
WHERE
    `mountain_range` = 'Rila'
ORDER BY p.`elevation` DESC;