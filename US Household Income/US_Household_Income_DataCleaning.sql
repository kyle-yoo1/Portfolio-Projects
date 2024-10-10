# Dohoon Yoo
# US Household Income Data Cleaning

SELECT *
FROM us_project.us_household_income;

SELECT *
FROM us_project.us_household_income_statistics;

ALTER TABLE us_project.us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`;
----------------------------------------------------------------------------------------

SELECT COUNT(id)
FROM us_project.us_household_income;

SELECT COUNT(id)
FROM us_project.us_household_income_statistics;

SELECT id, COUNT(id)
FROM us_project.us_household_income
GROUP BY id
HAVING COUNT(id) > 1;


SELECT row_id,
id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
FROM us_project.us_household_income
;

SELECT *
FROM (
	SELECT row_id,
	id,
	ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
	FROM us_project.us_household_income
) duplicates
WHERE row_num > 1
;


DELETE FROM us_household_income
WHERE row_id IN (
	SELECT row_id
	FROM (
		SELECT row_id,
		id,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
		FROM us_project.us_household_income
	) duplicates
	WHERE row_num > 1);
-----------------------------------------------------------------------------

SELECT DISTINCT State_Name
FROM us_project.us_household_income
ORDER BY 1
;

UPDATE us_project.us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georgia';

UPDATE us_project.us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';
-----------------------------------------------------------
# Missing Place
SELECT *
FROM us_project.us_household_income
WHERE Place = ' '
ORDER BY 1;

# Cleaning County name
SELECT *
FROM us_project.us_household_income
WHERE County = 'Autauga County'
ORDER BY 1;

# Updating missing information
UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont';
-----------------------------------------------------------------------------
# Cleaning TYPE
SELECT Type, COUNT(Type) AS Count_Type
FROM us_project.us_household_income
GROUP BY Type
#ORDER BY 1
;

# Updating Borough & Boroughs
UPDATE us_household_income
SET Type = 'Borous_household_incomeugh'
WHERE Type = 'Boroughs';
--------------------------------------------------------------

#SELECT ALand, AWater
SELECT ALand, AWater
FROM us_project.us_household_income
#WHERE (AWater = 0 OR AWater = ' ' OR AWater IS NULL)
WHERE (ALand = 0 OR ALand = ' ' OR ALand IS NULL);








