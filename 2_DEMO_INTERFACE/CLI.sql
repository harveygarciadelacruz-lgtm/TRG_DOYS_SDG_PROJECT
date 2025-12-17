-- OPEN CLI --
mysql -u root
USE sdg5_db;

-- ---------------------------------------------------------
-- [FR3] DEMONSTRATION: TRANSACTIONAL STORED PROCEDURE
-- ---------------------------------------------------------
-- Logic: Calls your 'Add_New_Employee' procedure.

-- 1. Success Case: Valid data
CALL Add_New_Employee(888, 'Gabriela Silang', 30, 'Master\'s Degree', 'F', 'Operations Manager', '2025-12-17', 1, 1);

-- Verify the record was added to your 'employee' table
SELECT * FROM employee WHERE employee_id = 888;

-- 2. Error Handling Case: Invalid Gender
-- Your procedure checks if sex is 'M' or 'F'. This will trigger your SIGNAL SQLSTATE.
CALL Add_New_Employee(889, 'Invalid User', 22, 'None', 'X', 'Staff', '2025-01-01', 1, 1);


-- ---------------------------------------------------------
-- [FR4] DEMONSTRATION: THE THREE REPORT QUERIES
-- ---------------------------------------------------------
-- Logic: Uses the actual Views and Tables in your SQL code.

-- Report 1: Using View 'comprehensive_complaint_position_analysis'
SELECT * FROM comprehensive_complaint_position_analysis;

-- Report 2: Using View 'employee_position_levels'
SELECT * FROM employee_position_levels;

-- Report 3: Custom Summary from your 'workplace_complaint' table
-- This shows the total count of cases by their current status
SELECT status, COUNT(*) AS Total_Count 
FROM workplace_complaint 
GROUP BY status;


-- ---------------------------------------------------------
-- [VALIDATION] DEMONSTRATION: TRIGGERS
-- ---------------------------------------------------------
-- Logic: Proves your 'validate_status_on_update' trigger works.

-- This update will be REJECTED because 'deleted' is not allowed in your ENUM/Trigger logic
UPDATE workplace_complaint SET status = 'deleted' WHERE complaint_id = 1;
