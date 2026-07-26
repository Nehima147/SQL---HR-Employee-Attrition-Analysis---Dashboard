**HR Attrition Analysis using SQL & Excel Dashboard**

**Project Overview**

I wanted to work on a project that would help me apply SQL to a real business scenario instead of simply practicing queries. For this project, I used the IBM HR Analytics Employee Attrition dataset to analyze employee turnover, salary trends, job roles, overtime, and other workforce factors. After completing the SQL analysis, I summarized the findings in an interactive Excel dashboard.

**Objective**

The objective of this project was to identify the factors contributing to employee attrition and present meaningful insights that can support HR decision-making and employee retention strategies.

**Dataset**

- Dataset: IBM HR Analytics Employee Attrition Dataset
- Total Employees: 1,470
- Total Columns: 35
- Analysis performed on cleaned employee data after removing unnecessary fields.

 **Tools Used**

 - PostgreSQL
 - Microsoft Excel

**Workbook Structure**

**Raw_Data**

Contains the original dataset without any modifications.

**Cleaned_Data**

Includes the cleaned dataset after removing columns with no analytical value and preparing the data for SQL analysis.

**SQL_Queries_Output**

Contains the results of all SQL queries used during the analysis. The queries are grouped into different business areas such as workforce overview, compensation, work environment, and employee demographics.

**Dashboard**

An interactive Excel dashboard built using the SQL query outputs to visualize the key findings.

 **SQL Concepts Used**

- SELECT
- WHERE
- GROUP BY
- ORDER BY
- Aggregate Functions
- CASE Statements
- Common Table Expressions (CTEs)
- Window Functions

**Analysis Performed**

The analysis focuses on:

- Workforce and attrition overview
- Department-wise attrition
- Job role analysis
- Salary and compensation analysis
- Overtime analysis
- Age group analysis
- Work-life balance analysis
- Business travel analysis
- Employee tenure analysis

**Key Insights**

- Overall employee attrition rate is **16.12%**.
- **Sales Representatives** recorded the highest attrition rate among all job roles.
- Employees earning **lower monthly income** showed significantly higher attrition than higher income groups.
- Employees **working overtime** experienced much higher attrition compared to employees who did not work overtime.
- Younger employees **(18–25 years)** recorded the highest attrition rate.
- The **Sales department** had the highest employee turnover among all departments.
- Employees with **poor work-life balance** were more likely to leave the organization.
- A high-risk employee group identified using **overtime, frequent travel, and low job satisfaction** showed the highest attrition rate.

**Recommendations**

- Strengthen onboarding and engagement programs for new employees.
- Improve retention initiatives for high-risk job roles.
- Review compensation for lower salary groups.
- Encourage a healthier work-life balance by reducing excessive overtime.
- Provide career development opportunities to improve long-term employee retention.

**How to Use**

1.Import the cleaned dataset into PostgreSQL.

2.Execute the SQL queries to generate the analysis.

3.Review the query outputs available in the workbook.

4.Explore the Excel dashboard to understand the key insights visually.
