DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(50))
BEGIN
	SELECT `first_name`, `last_name`
    FROM `employees` AS e
    JOIN `addresses` AS a ON a.`address_id` = e.`address_id`
    JOIN `towns` AS t ON t.`town_id` = a.`town_id`
    WHERE t.`name` = town_name
    ORDER BY `first_name`, `last_name`, `employee_id`;
END $$

DELIMITER ;

CALL usp_get_employees_from_town ('Sofia');