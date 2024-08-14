# Dohoon (Kyle) Yoo
# Portfolio Project - World Life Expectancy (Data Cleaning)

SELECT *
FROM world_life_expectancy
;
-----------------------------------------------------------------------------
# Identify Duplicate data

SELECT Country, Year, CONCAT(Country,Year), COUNT(CONCAT(Country,Year))
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country,Year)
HAVING COUNT(CONCAT(Country,Year)) > 1
;
-------------------------------------------------------------------------------------
# Identify Row_Num > 1 with ROW_ID
SELECT *
FROM (
	SELECT Row_ID, CONCAT(Country,Year),
	ROW_NUMBER() OVER( PARTITION BY CONCAT(Country,Year) ORDER BY CONCAT(Country,Year)) AS Row_Num
	FROM world_life_expectancy
	) AS Row_table
WHERE Row_Num > 1
;

# Delete Row_Num > 2 (3 Rows)
DELETE FROM world_life_expectancy
WHERE
	Row_ID IN (
    SELECT Row_ID
FROM (
	SELECT Row_ID,
    CONCAT(Country,Year),
	ROW_NUMBER() OVER( PARTITION BY CONCAT(Country,Year) ORDER BY CONCAT(Country,Year)) AS Row_Num
	FROM world_life_expectancy
	) AS Row_table
WHERE Row_Num > 1
)
;
--------------------------------------------------------------------------------------------------------------
# Status should be either 'Developing' OR 'Developed'
SELECT *
FROM world_life_expectancy
WHERE Status = ''
;

SELECT *
FROM world_life_expectancy
WHERE Status IS NULL
;

SELECT DISTINCT(Status)
FROM world_life_expectancy
WHERE Status <> ''
;

SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status = 'Developing';


UPDATE world_life_expectancy
SET Status = 'Developing'
WHERE Country IN (SELECT DISTINCT(Country)
				FROM world_life_expectancy
				WHERE Status = 'Developing');
                
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developed'
;

SELECT *
FROM world_life_expectancy
WHERE Country = 'United States of America'
;

---------------------------------------------------------------------------------------
# Missing Data in Life expectancy
# Using previous and next year to calculate average year of missing data in life expectancy

SELECT *
FROM world_life_expectancy
#WHERE `Life expectancy` = ''
;

SELECT Country, Year, `Life expectancy`
FROM world_life_expectancy
#WHERE `Life expectancy` = ''
;

SELECT t1.Country, t1.Year, t1.`Life expectancy`,
t2.Country, t2.Year, t2.`Life expectancy`,
t3.Country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy`+ t3.`Life expectancy`) /2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = ''
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy`+ t3.`Life expectancy`) /2,1)
WHERE t1.`Life expectancy` = ''
;

SELECT *
FROM world_life_expectancy
#WHERE `Life expectancy` = ''
;





    
