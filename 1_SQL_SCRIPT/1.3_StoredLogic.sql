-- STORED LOGIC SCRIPT FOR SDG5_DB (Procedures, Views, Triggers)

DELIMITER $$

-- Procedure to Add New Employee with Error Handling
CREATE PROCEDURE `Add_New_Employee` (
    IN `e_employee_id` INT, IN `e_name` VARCHAR(255), IN `e_age` INT, 
    IN `e_academical_achievement` VARCHAR(255), IN `e_sex` CHAR(1), 
    IN `e_job_title` VARCHAR(255), IN `e_date_hired` DATE, 
    IN `p_department_id` INT, IN `p_company_id` INT
) BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'SQL ERROR: Transaction rolled back.';
    END;

    IF UPPER(e_sex) NOT IN ('M', 'F') THEN
        SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Validation Error: Sex must be M or F.';
    END IF;

    START TRANSACTION;
    INSERT INTO employee (employee_id, name, age, academical_achievement, sex, job_title, date_hired, department_id, company_id)
    VALUES (e_employee_id, e_name, e_age, e_academical_achievement, UPPER(e_sex), e_job_title, e_date_hired, p_department_id, p_company_id);
    COMMIT;
END$$

-- Trigger to validate status
CREATE TRIGGER `validate_status_on_update` BEFORE UPDATE ON `workplace_complaint` FOR EACH ROW 
BEGIN
    IF FIND_IN_SET(NEW.status, 'pending,filed,investigating,resolved') = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: Status must be pending, filed, investigating, or resolved.';
    END IF;
END$$

DELIMITER ;

-- View for Position Levels
CREATE VIEW `employee_position_levels` AS 
SELECT `employee_id`, `sex`, `academical_achievement`,
CASE 
    WHEN `job_title` LIKE '%Manager%' OR `job_title` LIKE '%Supervisor%' OR `job_title` LIKE 'Senior %' OR `job_title` LIKE '%Analyst%' THEN 'High Position'
    WHEN `job_title` LIKE '%Support%' OR `job_title` LIKE '%Assistant%' THEN 'Low Position'
    ELSE 'Other/Unclassified'
END AS `position_level` FROM `employee`;
