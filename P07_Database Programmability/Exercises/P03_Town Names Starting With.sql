DELIMITER $$

CREATE PROCEDURE usp_get_towns_starting_with (start_letter VARCHAR(50))
BEGIN
	SELECT `name` AS 'town_name'
	FROM `towns`
	WHERE `name` LIKE CONCAT(start_letter, '%')
	ORDER BY `town_name`;
END $$

DELIMITER ;

CALL usp_get_towns_starting_with ('b');