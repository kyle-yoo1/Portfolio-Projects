# Life Expectancy (WHO) 
Statistical Analysis on Factors Influencing Life Expectancy

## Table of Contents
- [About Dataset](#about-dataset)
- [Exploratory Data Analysis (EDA)](#exploratory-data-analysis-(eda))

## About Dataset
This data is from the World Health Organization (WHO) which keeps track of the health status as well as many other related factors for all countries, considered data from 2007-2022 (15 years) for 193 countries for detailed analysis.

Factor Including:
- Demographics and Country Information:
  - Country: 193 countries
  - Year: from 2007 - 2022 (15 years)
  - Status: developed or developing
- Health Metrics:
  - Life expectancy: average lifespan of individuals in the country
  - Adult mortality: death rate of both sexes (probability of dying between 15 and 100 years per 1000 population)
  - Infant deaths: numbers of deaths of infants under 1 year old per 1000 population
  - Under-five deaths: numbers of deaths of babies under 5 years old per 1000 population
  - BMI: average body mass index of individuals in the country
  - Thinness 1-19 years: Prevalence of underweight individuals aged 1-19
  - Thinness 5-9 years: Prevalence of underweight individuals aged 5-9
  - Schooling: average years of schooling
- Disease Information:
  - Measles: number of reported cases per 1000 population
  - Polio: number of reported cases per 1000 population
  - Diphtheria: number of reported cases per 1000 population
  - HIV/AIDS: percentage of HIV/AIDS
- Economic Information:
  - GDP: Gross Domestic Product
  - Percentage expenditure: percentage of GDP per capita (%)
- Other:
  - Row_ID: Unique identifier for each data

## Exploratory Data Analysis (EDA)
- What is the Lowest and Highest of life expactancy each country has & Life increased over 15 years (Max - Min)
```sql
SELECT Country,
MIN(`Life expectancy`),
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15_Years DESC;
```
<img width="547" alt="1" src="https://github.com/user-attachments/assets/4530a93a-76ce-4e59-9eb8-160c9fd56624">


- Average Life Expectancy in each year from 2007 - 2022
```sql
SELECT Year, ROUND(AVG(`Life expectancy`),2) AS Avg_Life_Exp
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
AND `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year;
```
<img width="109" alt="2" src="https://github.com/user-attachments/assets/944cfc5a-fcf5-49d8-8c22-944e2968a497">

- What is the correlation between Average of GDP & Average of Life Expectancy?
```sql
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Exp, ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Avg_Life_Exp > 0
AND GDP > 0
ORDER BY GDP DESC
#ORDER BY GDP ASC
#ORDER BY Avg_Life_Exp ASC;
```
<img width="337" alt="3" src="https://github.com/user-attachments/assets/1963a570-c73d-4ac0-adb8-25258825048e">


- What is the average of high GDP and low GDP using CASE STATEMENT?
```sql
SELECT
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Exp,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) Low_GDP_Life_Exp
FROM world_life_expectancy;
# OUTPUT:
# High GDP = 1326 rows that have a GDP higher than 1500, and their average life expectancy is 74.
# Low GDP = 1612 rows that have a GDP lower than 1500, and their average life expectancy is 64.
```
<img width="349" alt="highGDP vs lowGDP" src="https://github.com/user-attachments/assets/b5426811-1190-416b-8862-0280ad900d9d">

- How many countries have developed and are developing, also the average life expectancy?
```sql
SELECT Status, COUNT(DISTINCT Country) AS Count_Country, ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Exp
FROM world_life_expectancy
GROUP BY Status;
# OUTPUT:
# There are 32 countries that are developed with an average life expectancy of 79.
# There are 161 countries that are still developing with an average life expectancy of 67.
```
<img width="206" alt="4" src="https://github.com/user-attachments/assets/74ffd17f-f8cc-4b43-a81e-6a14710e8b63">

- What is the correlation between average of BMI & Life Expectancy?
```sql
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Avg_Life_Exp, ROUND(AVG(BMI),1) AS Avg_BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Avg_Life_Exp > 0
AND Avg_BMI > 0
#ORDER BY Avg_BMI DESC
ORDER BY Avg_BMI ASC;
```
<img width="358" alt="image" src="https://github.com/user-attachments/assets/6aa5b254-ff98-478c-990b-f63b26ca9f11">

- What is the Total number of Adults who died at the end of the Year in the US using Rolling_Total?
```sql
SELECT Country, Year, `Life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER (PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
#WHERE Country LIKE '%United%'
WHERE Country LIKE '%America';
```
<img width="479" alt="6" src="https://github.com/user-attachments/assets/b42430b2-e463-4b66-a28d-237fd4ecb434">


