DELIMITER $$
CREATE PROCEDURE usp_withdraw_money (account_id INT, money_amount DECIMAL(19,4))
BEGIN
	DECLARE balance_left DECIMAL(19,4);
    SET balance_left :=(
		SELECT `balance`
        FROM `accounts` AS a
        WHERE a.`id` = account_id
    );
	START TRANSACTION;
	IF(money_amount <= 0 OR balance_left - money_amount < 0) THEN
		ROLLBACK;
    ELSE
		UPDATE `accounts` AS a SET a.`balance` = a.`balance` - money_amount
		WHERE a.`id` = account_id;
    END IF;
END $$

DELIMITER ;

CALL usp_withdraw_money (1, 10);