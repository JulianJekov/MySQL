SELECT `id`, 
concat(`first_name`, ' ', `last_name`) AS 'Full name',
`job_title` AS 'Job title',
`salary` AS 'Salary'
FROM `employees`
WHERE `salary` > 1000.00
ORDER BY `id`;