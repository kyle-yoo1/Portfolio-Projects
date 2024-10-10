# US Household Income Statistics & Geographical Locations

## About Dataset
This data contains detailed geographic information about different regions within US states, which makes it suitable for analyzing these:
- Identifiers:
  -  Row_ID: unique identifier for each row
  -  ID: another unique identifier for each place
- Geographic Information:
  - State_Code: code for each state
  - State_Name: states in US (Alabama)
  - State_ab: state abbreviation (AL for Alabama)
  - County: name of county within the state
  - City: name of city within the state
  - Place: specific place within the city or county 
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
- Which state has the Largest Land areas and Largest Water areas, limit the result to the top 10?
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


- Average Life Expectancy in each year from 2007 - 2022
```sql

```

- What is the correlation between Average of GDP & Average of Life Expectancy?
```sql

```


- What is the average of high GDP and low GDP using CASE STATEMENT?
```sql

```

- How many countries have developed and are developing, also the average life expectancy?
```sql

```

- What is the correlation between average of BMI & Life Expectancy?
```sql

```

- What is the Total number of Adults who died at the end of the Year in the US using Rolling_Total?
```sql

```
