CREATE TABLE `notification_emails` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`recipient` INT NOT NULL,
`subject` VARCHAR (50) NOT NULL,
`body` TEXT NOT NULL 
);

DELIMITER $$

CREATE TRIGGER trigger_email_on_changed_balance
AFTER INSERT
ON `logs`
FOR EACH ROW
BEGIN
	INSERT INTO `notification_emails` (`recipient`, `subject`, `body`)
    VALUES (
			NEW.`account_id`,
			CONCAT('Balance change for account: ', NEW.`account_id`),
            CONCAT_WS(' ', 'On', NOW(), 'your balance was changed from', NEW.`old_sum`, 'to', NEW.`new_sum`, '.')
            );
END $$