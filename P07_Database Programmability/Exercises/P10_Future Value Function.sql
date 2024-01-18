DELIMITER $$

CREATE FUNCTION ufn_calculate_future_value (sum DECIMAL(19,4), yearrly_interested_rate DOUBLE, years INT)
RETURNS DECIMAL(19,4)
DETERMINISTIC
BEGIN
	DECLARE future_value_of_the_initial_sum DECIMAL(19,4);
    SET future_value_of_the_initial_sum := (
		sum * (POW(1 + yearrly_interested_rate, years))
    );
    RETURN future_value_of_the_initial_sum;
END $$

DELIMITER ;

SELECT ufn_calculate_future_value(1000, 0.5, 5) AS 'Output';