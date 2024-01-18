DELIMITER $$

CREATE FUNCTION ufn_get_salary_level (received_salary DECIMAL(19,4))
RETURNS VARCHAR(7)
DETERMINISTIC
BEGIN
	DECLARE salary_level VARCHAR(7);
    SET salary_level := (
		CASE 
        WHEN received_salary < 30000 THEN 'Low'
        WHEN received_salary <= 50000 THEN 'Average'
        ELSE 'High'
        END
    );
    RETURN salary_level;
END $$

DELIMITER ;

SELECT ufn_get_salary_level (43300.00);