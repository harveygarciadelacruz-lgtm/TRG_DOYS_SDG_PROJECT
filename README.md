# TRG_DOYS_SDG_PROJECT

**Project Overview:**
 
The sdg5_db is a relational database designed to track, manage, and analyze workplace dynamics with a focus on Sustainable Development Goal 5: Gender Equality. It monitors employee demographics, departmental structures, and workplace complaints—specifically targeting issues like harassment, promotion bias, and pay equality.

**Problem Statement:**

This system is built to help organizations identify patterns of discrimination and ensure a fair working environment through data-driven analysis of position levels and complaint resolutions.


**The system implements core DBMS concepts such as:**

- **Relational table design** for employees, departments, companies, policies, and complaints
- **Primary and foreign key constraints** to maintain data integrity
- **Stored procedures** to safely insert validated employee records using transactions
- **Triggers** to enforce complaint status rules and automatically handle reopened cases
- **Views** to analyze complaints by gender, educational attainment, and position level


**Core Tables**

- company – Stores company information
- department – Departments under each company
- employee– Employee demographic and job details
- rules – Workplace policies (e.g., harassment, pay equality)
- workplace_complaint – Employee complaints and case status

**Relationships**

- Employees belong to departments and companies
- Complaints are linked to employees and specific rules
- Foreign key constraints enforce referential integrity

**Technologies Used:**

- MySQL / MariaDB
- phpMyAdmin
- SQL (DDL, DML, Triggers, Procedures, Views)

**How to Run the Project:**

1. Open **phpMyAdmin** or any MySQL client
2. Create a database named:
   ```sql
   CREATE DATABASE sdg5_db;
3. Import the provided SQL file sdg5_db.sql
4. Ensure the database server supports: Triggers, Stored Procedures, Views

**5. Individual Contributions:**

**Andrada, Jack Zyruz:**
2.1. Functional Requirements and Non-Functional Requirements,
2.3. Schema Normalization Analysis,
3.1. Core DBMS Concepts Used,
3.2. ER Diagram,
4.1. Test Cases,
4.2. ACID Compliance Test,

**Condino, Zyann Kyle:**
3.1. Core DBMS Concepts Used,
3.2. ER Diagram,
3.3. Transaction Flowchart,
4.1. Test Cases,
4.2. ACID Compliance Test,
Github

**Dela Cruz, Harvey:**
1.1 Project Overview & UN SDG Target,
1.2. Problem Statement,
3.1. Core DBMS Concepts Used, 
3.2. ER Diagram,
5.1. Conclusion,
PPT,
Github

**Macabangon, John Carlo:**
3.2. ER Diagram,
3.3. Transaction Flowchart,
4.2. ACID Compliance Test,
PPT

**Monte, Manuel:**
2.1. Functional Requirements and Non-Functional Requirements,
2.2. Data Requirements, 
4.2. ACID Compliance Test









