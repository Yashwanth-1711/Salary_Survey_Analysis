-- Queries--


use Milestone;

-- 1.  Average Salary by Industry and Gender -- 

select Industry, Gender, Round(avg(Annual_Salary),2) as Avg_Salary 
from salary_survey 
group by Industry,Gender
order by Avg_salary Desc ,Industry,Gender;

-- ---------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------

-- 2. Total Salary Compensation by Job Title -- 

	Select Job_Title, Sum(Annual_Salary + Additional_Monetary_Compensation) as Total_Salary
	from salary_survey
	group by Job_Title
	order by Total_Salary Desc, Job_Title;

-- ---------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------

-- 3. Salary Distribution by Education Level -- 

Select Highest_Education, Round(Avg(Annual_Salary),2) as Avg_Salary, Round(Min(Annual_Salary),2) As Minimum_Salary, Round(Max(Annual_Salary),2) as Maximum_Salary
from salary_survey
Group by Highest_Education
order by Highest_Education;

-- ---------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------

-- 4. Number of Employees by Industry and Years of Experience -- 

Select count(Id) as Employees,Industry, (Years_of_Professional_Experience_in_Field) as Years_of_Experience
from Salary_Survey 
group by Industry,Years_of_Experience
order by Employees Desc,industry;

-- ---------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------

-- 5. Median Salary by Age Range and Gender --

WITH RankedSalaries AS (
    SELECT Age_range, Gender, Annual_Salary, ROW_NUMBER() OVER (PARTITION BY Age_range, Gender ORDER BY Annual_Salary) AS Row_Num,
	COUNT(*) OVER (PARTITION BY Age_range, Gender) AS Total_Count
    FROM Salary_Survey
)
SELECT Age_range, Gender, Round(AVG(Annual_Salary),2) AS Median_Salary
FROM RankedSalaries
WHERE Row_Num IN (FLOOR((Total_Count + 1) / 2.0), CEIL((Total_Count + 1) / 2.0))
GROUP BY Age_range, Gender
ORDER BY Age_range, Gender;


-- ---------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------


/* 6.  Job Titles with the Highest Salary in Each Country */

WITH MaxSalaryPerCountry AS (
    SELECT Country, MAX(Annual_Salary) AS Max_Salary
    FROM Salary_Survey
    GROUP BY Country
)
SELECT S.Job_Title, S.Country, S.Annual_Salary AS Max_Salary
FROM Salary_Survey S
JOIN MaxSalaryPerCountry M
ON S.Country = M.Country AND S.Annual_Salary = M.Max_Salary
ORDER BY Max_Salary Desc, S.Country;


-- ---------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------


/* 7. Average Salary by City and Industry */

SELECT city,Industry, Round(AVG(Annual_salary),2) AS average_salary
FROM salary_survey
GROUP BY city, industry
ORDER BY city, average_salary DESC; 


-- ---------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------


/* 8. Percentage of Employees with Additional Monetary Compensation by Gender*/

SELECT Gender, ROUND((COUNT(CASE WHEN Additional_Monetary_Compensation > 0 THEN 1 END) * 100.0) / COUNT(*), 2) AS Percentage_with_Compensation
FROM Salary_Survey
GROUP BY Gender;


-- ---------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------


/* 9. Total Compensation by Job Title and Years of Experience */

SELECT Job_Title, Years_of_professional_Experience_overall, 
    Round(SUM(annual_salary + Additional_Monetary_Compensation),2) AS Total_Compensation
FROM Salary_Survey
GROUP BY Job_Title,Years_of_professional_Experience_overall
ORDER BY Job_Title,Years_of_professional_Experience_overall;


-- ---------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------

/*10. Average Salary by Industry, Gender, and Education Level */

SELECT Industry,Gender,Highest_Education,ROUND(AVG(Annual_Salary), 2) AS Average_Salary
FROM salary_survey
GROUP BY Industry, Gender, Highest_education
ORDER BY Industry, Gender, Highest_education;
    
    
    

