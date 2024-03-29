SELECT 
    `first_name`, `last_name`, `name` AS `town`, `address_text`
FROM
    `employees` AS e
        JOIN
    `addresses` AS a ON e.address_id = a.address_id
        JOIN
    `towns` AS t ON t.town_id = a.town_id
ORDER BY `first_name` , `last_name`
LIMIT 5;