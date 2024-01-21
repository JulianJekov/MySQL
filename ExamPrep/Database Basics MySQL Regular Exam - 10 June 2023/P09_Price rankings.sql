SELECT u.`name`, c.`name`, u.`address`, 
CASE
WHEN u.`tuition_fee` < 800 THEN 'cheap'
WHEN u.`tuition_fee` < 1200 THEN 'normal'
WHEN u.`tuition_fee` < 2500 THEN 'high'
ELSE 'expensive'
END
AS 'price_rank',
u.`tuition_fee`
FROM `universities` AS u
JOIN `cities` AS c ON u.`city_id` = c.`id`
ORDER BY u.`tuition_fee`;