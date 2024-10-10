# Dohoon(Kyle) Yoo
# World_Life_Expectancy - Exploratory Data Analysis
-------------------------------------------------
SELECT * FROM world_life_expectancy;

# Filter life expecancy over past 15 years
SELECT Country,
MIN(`Life expectancy`),
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Incerase_15_Years DESC
;

# Average Life Expectancy in each year
SELECT Year, ROUND(AVG(`Life expectancy`),2) AS Avg_Life_Exp
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
AND `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year
;
-----------------------------------------------------------------------------------------------------

# Correlation between Average of GDP & Life Expectancy
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Exp, ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND GDP > 0
ORDER BY GDP DESC
#ORDER BY GDP ASC
#ORDER BY Life_Exp ASC
;


# CASE STATEMENT
# Average of High GDP VS Low GDP
SELECT
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Exp,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) Low_GDP_Life_Exp
FROM world_life_expectancy
;
------------------------------------------------------------------------------------------
# Developing VS eveloped of Average Life Expectancy

SELECT Status, ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Exp
FROM world_life_expectancy
GROUP BY Status
;

-------------------------------------------------------------------------------------------------------------------------
#Status VS Country VS Average of Life Expectancy
# How many countries have developed and developing
SELECT Status, COUNT(DISTINCT Country) AS Count_Country, ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Exp
FROM world_life_expectancy
GROUP BY Status
;

---------------------------------------------------------------------------------------------------------------------------
# Correlation between Average of BMI & Life Expectancy

SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Exp, ROUND(AVG(BMI),1) AS Avg_BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Avg_Life_Exp > 0
AND Avg_BMI > 0
#ORDER BY Avg_BMI DESC
ORDER BY Avg_BMI ASC
;

------------------------------------------------------------------------------------------
# Total Adults died in End of Year (Using Rolling Total)

SELECT Country, Year, `Life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER (PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
#WHERE Country LIKE '%United%'
WHERE Country LIKE '%America'
;










