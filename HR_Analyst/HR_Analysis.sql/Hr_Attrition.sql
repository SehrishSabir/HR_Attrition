USE hr_analyst;
SELECT * FROM hr_attrition LIMIT 10;
ALTER TABLE HR_Attrition_Cleaned RENAME TO hr_attrition;

# Q1. Total number of employees
SELECT COUNT(*) AS Total_Employees FROM hr_attrition;

# Q2. How many employees left the company?
Select Count(Attrition) as Employees_Left_company from hr_attrition
where Attrition = 'Yes';

# Q3. How many employees are still working in the company?
Select Count(*) as Employees_still_working from hr_attrition
where Attrition = 'No';

# Q4. What is the Attrition Rate (%)?
SELECT ROUND((COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0) / COUNT(*), 2 
) AS Attrition_Rate FROM hr_attrition;

# Q5. What is the average age of employees?
Select avg(Age) as Average_Age from hr_attrition;

# Q7. Which department has the highest number of employees?
SELECT Department, COUNT(*) AS Total_Employees FROM hr_attrition
GROUP BY Department
ORDER BY Total_Employees DESC
LIMIT 1

# Q8. Which job role has the highest number of employees?
SELECT JobRole, COUNT(*) AS Total_Employees FROM hr_attrition
GROUP BY JobRole
ORDER BY Total_Employees DESC
LIMIT 1;

# Q9. How many employees work overtime?  
Select count(*) as Employees_working_Overtime from hr_attrition
where OverTime = 'Yes';

# Q10. What is the gender distribution?
SELECT Gender, COUNT(*) AS Total_Employees from hr_attrition
group by Gender;

# Q11. Find the number of employees who left the company for each gender.
SELECT Gender ,Count(*) as No_of_Employees from hr_attrition
where Attrition = 'Yes'
group by Gender;

#Q.12 Find the number of employees who left the company  in each Gender and Department combination.
SELECT Department, Gender, Count(*) as No_of_Employees from hr_attrition
where Attrition = 'Yes'
group by Gender,Department ;

# Q13. Find the Attrition Rate (%) for each Department.
SELECT Department, SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Rate, COUNT(*)
FROM hr_attrition
GROUP BY Department;

# Q14 Which department has the highest attrition rate (%)?
SELECT Department, SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left, COUNT(*) as Total_employees
FROM hr_attrition
GROUP BY Department
Order by Employees_Left DESC;

#15 Do employees working overtime have higher attrition?
SELECT OverTime, Attrition from hr_attrition
where OverTime = 'Yes';

# Q16 Which age group is most likely to leave the company?
SELECT 
    CASE 
        WHEN Age <= 25 THEN 'Young (<=25)'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        ELSE '45+'
    END AS Age_Group,
    COUNT(*) AS Employees_Left
FROM hr_attrition
WHERE Attrition = 'Yes'
GROUP BY 
    CASE 
        WHEN Age <= 25 THEN 'Young (<=25)'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        ELSE '45+'
    END
ORDER BY Employees_Left DESC
LIMIT 1;

# Is income related to attrition?
SELECT 
    CASE 
        WHEN MonthlyIncome <= 3000 THEN 'Low Income'
        WHEN MonthlyIncome BETWEEN 3001 AND 6000 THEN 'Medium Income'
        ELSE 'High Income'
    END AS Income_Group,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS Attrition_Rate
FROM hr_attrition
GROUP BY  CASE 
        WHEN MonthlyIncome <= 3000 THEN 'Low Income'
        WHEN MonthlyIncome BETWEEN 3001 AND 6000 THEN 'Medium Income'
        ELSE 'High Income'
    END;
# Q17 How many employees are in each department?
SELECT Department, Count(*) as No_of_employees from hr_attrition
group by Department;

#Q18 Which department has the highest attrition?
Select Department, Count(*) as No_of_Employees from hr_attrition
where Attrition = 'Yes'
group by Department 
order by No_of_Employees Desc limit 1;

# Q. 14 Find the average monthly income of employees who have left the company vs who are still working.
SELECT count(*) as Total_Employees,  Attrition, Avg(MonthlyIncome) as Monthly_Income from hr_attrition 
group by Attrition; 

#Q15 Which Job Role has the highest average monthly income?
SELECT JobRole, Avg(MonthlyIncome) as Average_Monthly_Income from hr_attrition 
group by JobRole
order by Average_Monthly_Income  Desc limit 1;

# Q16 Which department has the highest average age?
SELECT Department ,Avg(Age) as Average_age from hr_attrition 
group by Department
order by Average_age  Desc limit 1;

#Q17 ❓ Q16. For each department, show:
-- Department
-- Total Employees
-- Average Monthly Income
-- Only include departments where the average monthly income is greater than 6000.
SELECT Department, 
Count(*) as Total_Employees,
Avg(MonthlyIncome) as Average_Monthly_Income
from hr_attrition
group by Department
HAVING AVG(MonthlyIncome) > 6000 ;

# Q18. Which job roles have an average monthly income greater than 7000?
SELECT JobRole, Avg(MonthlyIncome) as Average_Monthly_Income from hr_attrition
group by JobRole
having Avg(MonthlyIncome) > 7000;

#Q18 Find the departments that have more than 200 employees.
SELECT Department, Count(*) as No_of_Employees from hr_attrition
group by Department
having Count(*) > 200;

# Q19. Find the average age of employees in each department, but show only those departments 
-- where the average age is greater than 35 years.
SELECT Department, Avg(Age) as Avg_Age from hr_attrition
group by Department
having Avg(Age) > 35;

# Q20. Find the job roles that have more than 50 employees and an average monthly income
-- greater than 7000.
SELECT JobRole ,avg(MonthlyIncome) as Monthly_Income, count(*) as No_of_Employees from hr_attrition
group by JobRole
having count(*) > 50 and avg(MonthlyIncome) > 7000 ;

# Q21. The HR Manager wants to know which departments are paying the highest salaries and 
-- whether those departments also have high attrition.
SELECT Department, COUNT(*) AS Total_Employees, Avg(MonthlyIncome) as Salary, 
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) as Attrition from hr_attrition
group by Department
ORDER BY Salary DESC, Attrition DESC;

# Q22. Management wants to identify high-risk job roles.
-- More than 30 employees have left the company.
SELECT JobRole, Count(*) as Attrition from hr_attrition
where Attrition = 'Yes'
group by JobRole
Having Count(*)  > 30
order by Attrition DESC;

#Q23 Find out whether employees who work overtime are more likely to leave the company 
-- compared to those who do not work overtime.”.
SELECT OverTime, COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left
FROM hr_attrition
GROUP BY OverTime;
 
 #Q24 Company wants to know which salary band is most at risk.
SELECT SalaryBand, count(*) as Attrition from hr_attrition
where Attrition = 'Yes'
group by SalaryBand
order by Attrition DESC;

#Q25 “Determine whether employees with more years of total work experience are more likely 
-- to stay in the company or leave, and identify if experienced employees are at higher 
-- retention risk or not.”
SELECT TotalWorkingYears ,count(*) as Total_Employees,
SUM(CASE WHEN Attrition ='Yes' THEN 1 ELSE 0 END) as Attrition from hr_attrition
group by TotalWorkingYears
order by TotalWorkingYears DESC;

#Q26 Compare Job Satisfaction across departments.
SELECT Department, Avg(JobSatisfaction) as Job_satisfaction from hr_attrition
group by Department;

#Q27 Identify departments with poor work-life balance.
SELECT Department, Avg(WorkLifeBalance) as Work_Life_Balance from hr_attrition
group by Department
order by Work_Life_Balance;

#Q28 “Determine whether employees with more years of total work experience are more likely 
-- to stay in the company or leave, and identify if experienced employees are at higher 
-- retention risk or not.”
SELECT TotalWorkingYears ,count(*) as Total_Employees,
SUM(CASE WHEN Attrition ='Yes' THEN 1 ELSE 0 END) as Attrition from hr_attrition
group by TotalWorkingYears
order by TotalWorkingYears DESC;

#Q29 “Identify which job roles are paying the highest average salaries and determine whether 
-- those same roles are successfully retaining employees or experiencing higher attrition.”
SELECT JobRole ,Avg(MonthlyIncome) as Monthly_Income, count(*) as Total_no_of_Employees ,
SUM( CASE WHEN Attrition = 'Yes' Then 1 ELSE 0 END ) as  Employees_Left from hr_attrition
group by JobRole
order by Monthly_Income DESC;

#Q30 “Are employees with high experience but no recent promotion more likely to leave?”
SELECT Count(*) as Total_no_of_Employees, TotalWorkingYears,
SUM( CASE WHEN Attrition = 'Yes' Then 1 ELSE 0 END ) as  Employees_Left from hr_attrition
group by TotalWorkingYears
order by TotalWorkingYears DESC;

#Q31 Does travel and long distance from home increase employee attrition?”
SELECT Count(*) as Total_no_of_Employees, Business_Travel, avg(DistanceFromHome) as Distance_From_Home , 
SUM( CASE WHEN Attrition = 'Yes' Then 1 ELSE 0 END ) as  Employees_Left from hr_attrition
group by Business_Travel
order by Distance_From_Home DESC;