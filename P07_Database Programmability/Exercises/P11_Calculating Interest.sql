-- CREATE FUNCTION ufn_calculate_future_value (sum DECIMAL(19,4), yearrly_interested_rate DOUBLE, years INT)
-- RETURNS DECIMAL(19,4)
-- RETURN (sum * (POW(1 + yearrly_interested_rate, years)));

DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account (id INT, interest_rate DECIMAL(19,4))
BEGIN
	SELECT a.`id` AS 'account_id', ah.`first_name`, ah.`last_name`, a.`balance` AS 'current_balance',
    ufn_calculate_future_value (a.`balance`, interest_rate, 5)
    FROM `account_holders` AS ah
    JOIN `accounts` AS a
    ON a.`account_holder_id` = ah.`id`
    WHERE a.`id` = id;
END $$

DELIMITER ;

CALL usp_calculate_future_value_for_account (2, 0.1);