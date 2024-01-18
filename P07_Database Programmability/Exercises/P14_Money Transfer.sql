DELIMITER $$
CREATE PROCEDURE usp_transfer_money (from_id INT, to_id INT, money_amount DECIMAL(19,4))
BEGIN
	START TRANSACTION;
    IF(money_amount <= 0 OR (SELECT `balance` FROM `accounts` AS a WHERE a.`id` = from_id) < money_amount
    OR from_id = to_id
    OR (SELECT `id` FROM `accounts` WHERE `id` = from_id) IS NULL
    OR (SELECT `id` FROM `accounts` WHERE `id` = to_id) IS NULL)
    THEN
    ROLLBACK;
    ELSE
		UPDATE `accounts` AS a SET a.`balance` = a.`balance` - money_amount
		WHERE a.`id` = from_id;
        UPDATE `accounts` AS a SET a.`balance` = a.`balance` + money_amount
		WHERE a.`id` = to_id;
    END IF;
END $$

CALL usp_transfer_money (1, 2, 10);