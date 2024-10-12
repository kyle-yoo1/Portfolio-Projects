# Dohoon Yoo
# US Household Income Exploratory Data Analysis
--------------------------------------------------------
# Area of the Land & Water

SELECT State_Name, County, City, ALand, AWater;

SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
# ORDER BY 3 DESC
LIMIT 10
;



# Mean was 0 = dirty data
SELECT u.State_Name, County, Type, `Primary`, Mean, Median
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0 # where mean is not 0
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
ORDER BY 2 DESC
#ORDER BY 2 ASC
#ORDER BY 3 DESC
LIMIT 10;


# Find the income average of mean and median of each Type, list count.
SELECT Type, COUNT(Type), ROUND(AVG(Mean),1) AS Avg_Mean, Round(AVG(Median),1) AS Avg_Median
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 20
;

SELECT *
FROM us_household_income
WHERE Type = 'Community';
-------------------------------------------------------------------------

# What is the average income of Mean and Median of each state and city?
SELECT u.State_Name, City, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
GROUP BY u.State_Name, City
ORDER BY ROUND(AVG(Mean),1) DESC
LIMIT 10;




