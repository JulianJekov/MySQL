SELECT `id`, `first_name`, `last_name`, `job_title`, `department_id`, `salary`
FROM `employees`
ORDER BY `salary` DESC
LIMIT 1;

-- CREATE VIEW

CREATE VIEW `v_top_paid_employee` AS
	SELECT * FROM `employees`
	ORDER BY `salary` DESC
	LIMIT 1;

SELECT * FROM `v_top_paid_employee`;