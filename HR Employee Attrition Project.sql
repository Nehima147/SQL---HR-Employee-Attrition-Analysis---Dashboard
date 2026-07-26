Drop table if exists HR_Data;

Create table HR_Data(
S_NO SERIAL PRIMARY KEY,
Age INTEGER,
Attrition VARCHAR(50),
BusinessTravel VARCHAR(100),
DailyRate INTEGER,
Department VARCHAR(100),
DistanceFromHome INTEGER,
Education INTEGER,
EducationField VARCHAR(100),
EmployeeCount INTEGER ,
EmployeeNumber INTEGER unique,
EnvironmentSatisfaction INTEGER,
Gender VARCHAR(10),
HourlyRate INTEGER,
JobInvolvement INTEGER,
JobLevel INTEGER,
JobRole VARCHAR(100),
JobSatisfaction INTEGER,
MaritalStatus VARCHAR(30),
MonthlyIncome INTEGER,
MonthlyRate INTEGER,
NumCompaniesWorked INTEGER,
Over18 CHAR(1),
OverTime VARCHAR(30)  ,
PercentSalaryHike INTEGER,
PerformanceRating INTEGER,
RelationshipSatisfaction INTEGER,
StandardHours INTEGER,
StockOptionLevel INTEGER,
TotalWorkingYears INTEGER,
TrainingTimesLastYear INTEGER,
WorkLifeBalance INTEGER,
YearsAtCompany INTEGER,
YearsInCurrentRole INTEGER,
YearsSinceLastPromotion INTEGER,
YearsWithCurrManager INTEGER);

Select * from HR_Data;

--DATA CLEANING
--Total records
Select count(*) from HR_Data;
--Duplicate records
Select EmployeeNumber,Count(*)from HR_Data
Group by EmployeeNumber
Having count(*)>1;

--NULL Values
Select * from HR_Data
where Attrition is null
    or BusinessTravel is null
	or Department is null
	or Gender is null
	or MonthlyIncome is null
	or JobRole is null
    or Age is null;

--Checking unique values
Select distinct Attrition from HR_Data;
Select distinct Department from HR_Data;
Select distinct Gender from HR_Data;
Select distinct OverTime from HR_Data;
Select distinct BusinessTravel from HR_Data
Select distinct EmployeeCount from HR_Data;
Select distinct JobRole from HR_Data;
Select distinct Over18 from HR_Data;
Select distinct standardhours from HR_Data;

--Removing unwanted columns
Alter table Hr_data 
Drop column Over18,
Drop column StandardHours,
Drop column MonthlyRate,
Drop column HourlyRate,
Drop column EmployeeCount;
--Age range 
Select Min(Age) as Min_age,
       Max(Age) as Max_age
from HR_Data;	
--Inconsistant age checking
select age, count(*) as employee_age
from HR_Data
Group by age
order by age;

--MonthlyIncome Range
Select Min(MonthlyIncome) as Min_Income,
       Max(MonthlyIncome) as Max_Income
from HR_Data;
--Years At Company Range
Select Min(YearsAtCompany) as Min_years_at_company,
       Max(YearsAtCompany) as Max_years_at_company
from HR_Data;	

--Attrition
Select Attrition , count(*) as Employee_Attrition_count 
from HR_Data
Group by Attrition;

-- EDA
Select count(*) As Total_Employee,
       Round(Avg(Age),2) As Avg_Age,
	   Round(Avg(MonthlyIncome),2) As Avg_Monthly_Income
From Hr_Data;

--Overall Attrition rate
Select Round(100.0 * sum(case when Attrition='Yes' then 1 else 0 end)/count(*),2)
As attrition_rate from Hr_Data;

--Highest Attrition rate in department 
Select Department , 
Round(100.0 * sum(case when Attrition='Yes' then 1 else 0 end)/count(*),2)
As attrition_rate from Hr_Data
Group by Department
Order by attrition_rate desc;

--Highest Attrition rate in Job roles
Select Jobrole,
Round(100.0 * Sum(case when Attrition='Yes' then 1 else 0 end)/Count(*),2)
As attrition_rate from Hr_Data
Group by Jobrole
Order by attrition_rate desc;
       
--Does Overtime affect Attrition
Select Overtime ,
Round(100.0 * sum(case when Attrition ='Yes' then 1 else 0 end)/count(*),2)
As attrition_rate from Hr_data
Group by Overtime
Order by attrition_rate DESC;

--Does Buisness travel frequently affect Attrition
Select BusinessTravel,
Round(100.0 * sum(case when Attrition = 'Yes' then 1 else 0 end)/count(*),2)
As attrition_rate from Hr_Data
Group by BusinessTravel
Order by attrition_rate DESC;

--Does Distance affect Attrition
Select (case 
 when Distancefromhome <=15 then 'Short Commute' else 'Long commute'end)
 as Commute_Group , 
 Round(100.0 * sum (case when Attrition = 'Yes' then 1 else 0 end)/count(*),2)
 as attrition_rate
 from Hr_Data
 Group by Commute_Group 
 Order by attrition_rate desc;

--Montly Income differ between Employees who stay vs left
Select Attrition, Round(AVG(MonthlyIncome),2) as Avg_Monthly_Income from Hr_data 
Group by Attrition
Order by Avg_Monthly_Income Desc;

--Departments with highest average salary
Select Department , Round(Avg(MonthlyIncome),2) as Avg_monthly_income
from Hr_Data
Group by Department
Order by Avg_monthly_income desc;

--Does Job satisfication affects the attrition
Select JobSatisfaction , 
Round(100.0 * sum(case when Attrition ='Yes'then 1 else 0 end)/count(*),2)
as attrition_rate 
from Hr_Data
Group by JobSatisfaction
Order by attrition_rate desc;

-- Does Work life balance affects the attrition 
Select WorkLifeBalance , 
Round(100.0 * sum(case when Attrition ='Yes'then 1 else 0 end)/count(*),2)
as attrition_rate 
from Hr_Data
Group by WorkLifeBalance
Order by attrition_rate desc;

--Education field that has highest Attrition
Select EducationField,
Round(100.0 * sum(case when Attrition = 'Yes' then 1 else 0 end)/count(*),2)
as attrition_rate
from Hr_Data
Group by EducationField
Order by attrition_rate desc;

--Does recently promoted employees affects the attrition
Select 
(Case 
  when YearsSinceLastPromotion <=5 then 'Recently Promoted' else 'Not Recently Promoted'end) 
as Prmotion_Category,
Round(100.0 * sum(case when Attrition = 'Yes' then 1 else 0 end)/count(*),2)
as attrition_rate
from Hr_Data
Group by Prmotion_Category
Order by attrition_rate desc;

--Age groups that has highest attritions
Select 
  Case 
      When Age <=25 then '18-25'
	  When Age <=35 then '26-35'
	  When Age <=45 then '36-45'
	  When Age <=55 then '46-55'
	  Else '55+'
End As Age_Group,
Round(100.0 * sum(case when Attrition = 'Yes'then 1 else 0 end)/count(*),2)
As Attrition_Rate
from Hr_Data
Group by Age_Group
Order by Attrition_Rate desc;

--Employees earn more than their average department salary
Select employeenumber, department , MonthlyIncome
from Hr_data e
where MonthlyIncome > 
         (Select Avg(MonthlyIncome) from Hr_data d where e.department=d.department);

-- Top 3 highest paying roles
Select Jobrole,
Round(Avg(MonthlyIncome),2) as Avg_Sal 
from Hr_Data
Group by Jobrole
Order by Avg_Sal Desc
Limit 3;

--Attrition by gender and martial status
Select Gender, MaritalStatus,
Round(100.0 * sum(case when Attrition = 'Yes' then 1 else 0 end )/ count(*),2)
As Attrition_rate
From Hr_Data
Group by Gender, MaritalStatus
Order by Attrition_rate Desc;

--Does More Trainig sessions affects the attrition

Select TrainingTimesLastYear , 
Round(100.0 * sum(case when Attrition ='Yes'then 1 else 0 end)/count(*),2)
as attrition_rate 
from Hr_Data
Group by TrainingTimesLastYear
Order by attrition_rate desc;

--Managers Retain employees best
Select 
  Case  
      when YearsWithCurrManager <=5 then '0-5'
      when YearsWithCurrManager <=10 then '6-10'
	  Else '10+'
End as Years_with_Manager,
Round(100.0 * sum(case when Attrition ='Yes' then 1 else 0 end)/count(*),2)
As Attrition_Rate from Hr_Data
Group by Years_with_Manager
Order by Attrition_Rate desc;

--Attrition Rate by Monthly Income
Select 
    Case 
	   When MonthlyIncome <=2000 then '<=2K'
	   When MonthlyIncome <=5000 then '3K-5K'
	   When MonthlyIncome <=8000 then '6K-8K'
	   When MonthlyIncome <=12000 then '8K-12K'
	   When MonthlyIncome <=15000 then '12K-15K'
	   Else '15k+'
End As Monthly_Income_Range,
Round(100.0 * sum(Case when Attrition = 'Yes' then 1 else 0 end)/count(*),2)
As attrition_rate from Hr_Data
Group By Monthly_Income_Range
Order BY attrition_rate desc;


--High risk Employees
With High_Risk As
    (Select * from Hr_Data 
	 where OverTime='Yes'
	 And Jobsatisfaction <=2
	 And BusinessTravel = 'Travel_Frequently')
	
Select count(*) As High_risk,
Round(100.0 * sum(case when Attrition ='Yes' then 1 else 0 end)/count(*),2)
As Attrition_Rate
From High_Risk;

With High_Risk As
    (Select * from Hr_Data 
	 where OverTime='Yes'
	 And Jobsatisfaction <=2
	 And BusinessTravel = 'Travel_Frequently')
	 select * from High_Risk;

--Avg Years at company
Select Round(Avg(YearsAtCompany),2) as Avg_Years_at_Company from Hr_Data;
	
--Department Ranking According to the Attrition
Select Department,
Round(100.0 * Sum(Case when Attrition = 'Yes' then 1 else 0 end )/count(*),2)
As Attrition_Rate,
Dense_rank() over(order by 
               100.0 * Sum(Case when Attrition = 'Yes' then 1 else 0 end )/count(*) Desc)
As dept_rank
from Hr_Data
Group by Department
Order by dept_rank;

--Avg Job satisfaction
Select Round(Avg(Jobsatisfaction),2) from Hr_Data;