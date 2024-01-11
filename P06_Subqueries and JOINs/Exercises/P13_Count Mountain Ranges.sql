SELECT 
    c.`country_code`,
    COUNT(mc.`country_code`) AS 'mountain_range'
FROM
    `countries` AS c
        JOIN
    `mountains_countries` AS mc ON c.`country_code` = mc.`country_code`
WHERE
    mc.`country_code` IN ('US' , 'RU', 'BG')
GROUP BY mc.`country_code`
ORDER BY `mountain_range` DESC;

---------------------------------

SELECT 
    c.`country_code`,
    COUNT(m.`mountain_range`) AS 'mountain_range'
FROM
    `mountains` AS m
        JOIN
    `mountains_countries` AS c ON m.`id` = c.`mountain_id`
WHERE
    c.`country_code` IN ('BG' , 'US', 'RU')
GROUP BY `mountain_range`
ORDER BY `mountain_range`;