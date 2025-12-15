-- STORED LOGIC SCRIPT FOR SDG5_DB (Procedures, Views, Triggers)

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;

-- --------------------------------------------------------
-- 1. STORED PROCEDURE: Add_New_Employee
-- --------------------------------------------------------

DELIMITER $$
CREATE PROCEDURE `Add_New_Employee`(
    IN e_employee_id INT,
    IN e_name VARCHAR(150),
    IN e_age INT,
    IN e_academical_achievement VARCHAR(100),
    IN e_sex CHAR(1),
    IN e_job_title VARCHAR(100),
    IN e_date_hired DATE,
    IN e_department_id INT
)
BEGIN
    -- Declare Exit Handler for SQL exceptions (like Duplicate Entry or FK violation)
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback the transaction on any SQL error
        ROLLBACK;
        -- Signal a custom error 45000 (Generic SQL Error)
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'SQL ERROR: Failed to insert employee record. Check for duplicate ID or invalid foreign keys.';
    END;

    -- 1. Validation Check: Ensure the sex parameter is valid ('M' or 'F')
    IF UPPER(e_sex) NOT IN ('M', 'F') THEN
        -- Signal a custom error 45001 (Validation Error)
        SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Validation Error: Gender must be "M" or "F".';
    END IF;

    -- Start Transaction
    START TRANSACTION;

    -- 2. Insertion
    INSERT INTO `employee` (
        `employee_id`, `name`, `age`, `academical_achievement`, 
        `sex`, `job_title`, `date_hired`, `department_id`
    ) VALUES (
        e_employee_id, e_name, e_age, e_academical_achievement, 
        e_sex, e_job_title, e_date_hired, e_department_id
    );

    -- Commit the transaction if insertion is successful
    COMMIT;
END $$
DELIMITER ;

-- --------------------------------------------------------
-- 2. VIEW: Comprehensive_Complaint_Position_Analysis
-- --------------------------------------------------------

-- This VIEW calculates the total number of complaints per employee position (job_title).
-- It demonstrates how complex join logic can be simplified for reporting.
CREATE VIEW `Comprehensive_Complaint_Position_Analysis` AS
SELECT
    e.job_title,
    COUNT(wc.complaint_id) AS total_complaints,
    COUNT(DISTINCT wc.employee_id) AS total_employees_with_complaints
FROM
    employee e
JOIN
    workplace_complaint wc ON e.employee_id = wc.employee_id
GROUP BY
    e.job_title
ORDER BY
    total_complaints DESC;

-- --------------------------------------------------------
-- 3. TRIGGER: validate_and_clear_notes_on_update
-- (Merged logic: Validation + Clear Notes on Reopen)
-- --------------------------------------------------------

-- Drop any existing triggers with conflicting time/event
DROP TRIGGER IF EXISTS clear_notes_on_reopen;
DROP TRIGGER IF EXISTS validate_status_on_update; 

DELIMITER $$
CREATE TRIGGER `validate_and_clear_notes_on_update` BEFORE UPDATE ON `workplace_complaint` FOR EACH ROW
BEGIN
    -- 1. Validation Logic: Ensure the new status is one of the allowed ENUM values.
    IF FIND_IN_SET(NEW.status, 'pending,filed,investigating,resolved') = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERROR: Status must be one of "pending, filed, investigating," or "resolved" only.';
    END IF;

    -- 2. Clear Notes on Reopen Logic: 
    -- If the complaint status is changed FROM 'resolved' TO anything else (reopened), 
    -- clear the old resolution notes to ensure the new investigation starts clean.
    IF OLD.status = 'resolved' AND NEW.status != 'resolved' THEN
        SET NEW.resolution_notes = NULL;
    END IF;
END $$
DELIMITER ;

COMMIT;
