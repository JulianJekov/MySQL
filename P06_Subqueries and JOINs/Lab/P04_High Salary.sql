SELECT 
    COUNT(*)
FROM
    `employees` e
WHERE
    `salary` > (SELECT 
            AVG(`salary`)
        FROM
            `employees` e1);