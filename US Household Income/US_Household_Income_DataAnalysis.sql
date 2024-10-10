# Dohoon Yoo
# US Household Incomee Exploratory Data Analysis
--------------------------------------------------------
# Area of the Land & Water

#SELECT State_Name, County, City, ALand, AWater
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY 3 DESC
LIMIT 10
;

# Mean was 0 = dirty data
SELECT u.State_Name, County, Type, `Primary`, Mean, Median
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
;

UPDATE us_project.us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';
-------------------------------------------------------------------------------------------------

# Find Mean & Median of each State, limit to top 10.
SELECT u.State_Name, ROUND(AVG(Mean),1) AS Avg_Mean, Round(AVG(Median),1) AS Avg_Median
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 3 DESC
LIMIT 10;


# Finding out the highest and lowest Average Mean & Median Income of each State.
SELECT u.State_Name, COUNT(Type), ROUND(AVG(Mean),1) AS Avg_Mean, Round(AVG(Median),1) AS Avg_Median
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
HAVING COUNT(Type) > 100
ORDER BY 4 DESC
LIMIT 20
;

SELECT *
FROM us_household_income
WHERE Type = 'Community';
-------------------------------------------------------------------------

# Average of Mean & Median of Each State Name and City
SELECT u.State_Name, City, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
GROUP BY u.State_Name, City
ORDER BY ROUND(AVG(Mean),1) DESC
LIMIT 10

;




