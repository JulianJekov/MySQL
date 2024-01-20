DELIMITER $$

CREATE PROCEDURE udp_special_offer(first_name VARCHAR(50))
BEGIN
UPDATE `property_offers` AS po
JOIN `agents` AS a ON po.`agent_id` = a.`id`
SET po.`price` = po.`price` * 0.9
WHERE a.`first_name` = first_name;
END $$

DELIMITER ;

CALL udp_special_offer('Hans');

SELECT `first_name`, po.`price` 
FROM `agents` AS a
JOIN `property_offers` AS po ON a.`id` = po.`agent_id`
WHERE a.`first_name` = 'Hans';