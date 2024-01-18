-- CREATE FUNCTION ufn_get_salary_level (received_salary DECIMAL(19,4))
-- RETURNS VARCHAR(7)
-- 	
--     RETURN (
-- 		CASE 
--         WHEN received_salary < 30000 THEN 'Low'
--         WHEN received_salary <= 50000 THEN 'Average'
--         ELSE 'High'
--         END
--     );

DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level (salary_level VARCHAR(7))
BEGIN
	SELECT `first_name`, `last_name`
    FROM `employees`
    WHERE ufn_get_salary_level(`salary`) = salary_level
    ORDER BY `first_name` DESC, `last_name` DESC;
END $$

DELIMITER ;

CALL usp_get_employees_by_salary_level ('High');