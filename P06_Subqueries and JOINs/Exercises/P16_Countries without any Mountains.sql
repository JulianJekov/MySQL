SELECT 
    COUNT(c.`country_code`)
FROM
    `countries` AS c
        LEFT JOIN
    `mountains_countries` AS mc ON mc.`country_code` = c.`country_code`
        LEFT JOIN
    `mountains` AS m ON m.`id` = mc.`mountain_id`
WHERE
    m.`id` IS NULL;