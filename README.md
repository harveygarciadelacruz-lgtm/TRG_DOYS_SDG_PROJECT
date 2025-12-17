# TRG_DOYS_SDG_PROJECT

📌 Project Overview:
The sdg5_db is a relational database designed to track, manage, and analyze workplace dynamics with a focus on Sustainable Development Goal 5: Gender Equality. It monitors employee demographics, departmental structures, and workplace complaints—specifically targeting issues like harassment, promotion bias, and pay equality.

This system is built to help organizations identify patterns of discrimination and ensure a fair working environment through data-driven analysis of position levels and complaint resolutions.

🏗️ Database Architecture:
The database consists of 5 core tables and specialized views for analytical reporting:

•company: Stores information about corporate entities.
•department: Links departments to specific companies.
•employee: Contains detailed demographics (Sex, Age, Academical Achievement) and job details.
•rules: Defines workplace policies (e.g., Anti-Sexual Harassment, Parental Leave).
•workplace_complaint: Records specific incidents, their status (Pending, Investigating, Resolved), and resolution notes.

🛠️ Key Features:
1. Automated Status Validation
The system includes a Trigger (validate_status_on_update) that ensures the status of a complaint only moves between valid states: pending, filed, investigating, or resolved.

2. Transactional Integrity
A Stored Procedure (Add_New_Employee) is implemented to handle new hires. It includes:
•Input Validation: Ensures the sex field is restricted to 'M' or 'F'.
•Error Handling: Uses a ROLLBACK mechanism to prevent partial data entry if a duplicate ID or integrity violation occurs.

3. Smart Resolution Logic
A Trigger (clear_notes_on_reopen) automatically wipes resolution_notes if a previously "Resolved" case is reopened. This prevents outdated information from confusing active investigations.

4. Advanced Analytics Views

•employee_position_levels: Categorizes staff into "High Position" or "Low Position" based on keywords in their job titles (Manager, Supervisor, Assistant, etc.)

•comprehensive_complaint_position_analysis: A complex view that joins employees with complaints to analyze if certain complaint types (like promotion bias) are more prevalent among specific genders or academic backgrounds.
