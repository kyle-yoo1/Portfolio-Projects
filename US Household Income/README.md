# US Household Income Statistics & Geographical Locations

## About Dataset
This data contains detailed geographic information about different regions within US states, which makes it suitable for analyzing these:
- Identifiers:
  -  Row_ID: unique identifier for each row
  -  ID: another unique identifier for each place
- Geographic Information:
  - State_Code: code for each state
  - State_Name: states in the US (ex. Alabama)
  - State_ab: state abbreviation (ex. AL for Alabama)
  - County: name of county within the state
  - City: name of city within the state
  - Place: a specific place within the city or county 
  - Type: type of area (Track, City, Place)
  - Zip_Code: postal ZIP code
  - Area_Code: telephone area code
- Spatial Data:
  - ALand: land areas in square meters
  - AWater: water areas in square meters
  - Lat: Latitude
  - Lon: Longitude
- Other:
  - Primary
## Exploratory Data Analysis (EDA)
- Which top 10 states have the Largest Land areas and Largest Water areas?
```sql
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY 2 DESC # ALand
#ORDER BY 3 DESC # AWater
LIMIT 10;
# OUTCOME:
# Top 10 States Land: Texas -> Michigan (Left pic, left)
# Top 10 States Water: Michigan -> Wisconsin (Right pic, right)
```
<img width="188" alt="largest land" src="https://github.com/user-attachments/assets/5c5ed352-3610-4e68-9a0b-120bc4890bdf">
<img width="191" alt="largest water" src="https://github.com/user-attachments/assets/23e47b3e-d73b-4bda-8ee6-d23dc61e485d">

- Clean the data: accurate state name
```sql
SELECT u.State_Name, County, Type, `Primary`, Mean, Median
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0 # where mean is not 0

UPDATE us_project.us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';
```
<img width="274" alt="image" src="https://github.com/user-attachments/assets/682898a6-b2e9-4cbf-a7e3-b2f2f78a4962">

- What are the 10 states of income mean and median, top 10 & bottom 10?
```sql
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
# OUTCOME:
# Bottom 10 States Mea: Puerto Rico -> Idaho (Left pic, Avg_Mean)
# Top 10 States Mean: Columbia -> New York (right pic, Avg_Mean)
```
<img width="175" alt="Income of mean and median-bottom 10" src="https://github.com/user-attachments/assets/ddd9434b-98f6-4607-8e5a-75302b9575ec">
<img width="190" alt="Income of mean and median-top 10" src="https://github.com/user-attachments/assets/b02c28c5-27c9-4de3-9a73-fd91893e4900">

- Find the income average of mean and median of each Type, list count.
```sql
SELECT Type, COUNT(Type), ROUND(AVG(Mean),1) AS Avg_Mean, Round(AVG(Median),1) AS Avg_Median
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 20
;
```
<img width="226" alt="type,count" src="https://github.com/user-attachments/assets/fbbc5551-58b3-40e0-9bc6-028cbefeda97">

- What is the average Mean and Median income of each state and city, order by mean?
```sql
SELECT u.State_Name, City, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
GROUP BY u.State_Name, City
ORDER BY ROUND(AVG(Mean),1) DESC
LIMIT 10;
```
<img width="323" alt="average mean,medium in each state and city" src="https://github.com/user-attachments/assets/8d2ff656-e3b6-4e76-a759-dda47e8b6757">

