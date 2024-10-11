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
;

UPDATE us_project.us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';
```
<img width="274" alt="image" src="https://github.com/user-attachments/assets/682898a6-b2e9-4cbf-a7e3-b2f2f78a4962">

```sql

```


- What are the top 10 states of income average mean and median?
```sql
# Find Mean & Median of each State, limit to top 10.
SELECT u.State_Name, ROUND(AVG(Mean),1) AS Avg_Mean, Round(AVG(Median),1) AS Avg_Median
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2 ASC
#ORDER BY 3 DESC
LIMIT 10;
```
<img width="175" alt="average income of mean and median" src="https://github.com/user-attachments/assets/c91e5916-6d40-4f2d-b5aa-57620ed2a027">


- How many countries have developed and are developing, also the average life expectancy?
```sql

```

- What is the correlation between average of BMI & Life Expectancy?
```sql

```

- What is the Total number of Adults who died at the end of the Year in the US using Rolling_Total?
```sql

```
