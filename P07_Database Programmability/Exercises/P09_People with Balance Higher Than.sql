DELIMITER $$

CREATE PROCEDURE usp_get_holders_with_balance_higher_than (money DECIMAL(19,4))
BEGIN
    SELECT `first_name`, `last_name`
	FROM `account_holders` AS ah
	JOIN `accounts` AS a ON a.`account_holder_id` = ah.`id`
	GROUP BY `account_holder_id`
	HAVING SUM(a.`balance`) > money
	ORDER BY ah.`id`;
END $$

DELIMITER ;

CALL usp_get_holders_with_balance_higher_than(7000);
