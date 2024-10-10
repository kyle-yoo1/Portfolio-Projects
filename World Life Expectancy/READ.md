# Life Expectancy (WHO) 
Statistical Analysis on Factors Influencing Life Expectancy

## About Dataset
This data is from the World Health Organization (WHO) which keeps track of the health status as well as many other related factors for all countries, considered data from 2007-2022 (15 years) for 193 countries for detailed analysis.

Factor Including:

1. Demographics and Country Information:
- Country: 193 countries
- Year: from 2007 - 2022 (15 years)
- Status: developed or developing

2. Health Metrics:
- Life expectancy: average lifespan of individuals in the country
- Adult mortality: death rate of both sexes (probability of dying between 15 and 100 years per 1000 population)
- Infant deaths: numbers of deaths of infants under 1 year old per 1000 population
- Under-five deaths: numbers of deaths of babies under 5 years old per 1000 population
- BMI: average body mass index of individuals in the country
- Thinness 1-19 years: Prevalence of underweight individuals aged 1-19
- Thinness 5-9 years: Prevalence of underweight individuals aged 5-9
- Schooling: average years of schooling

3. Disease Information:
- Measles: number of reported cases per 1000 population
- Polio: number of reported cases per 1000 population
- Diphtheria: number of reported cases per 1000 population
- HIV/AIDS: percentage of HIV/AIDS

4. Economic Information:
- GDP: Gross Domestic Product
- Percentage expenditure: percentage of GDP per capita(%)

5. Other
- Row_ID: Unique identifier for each data

## Exploratory Data Analysis (EDA)
- Lowest and Highest of life expactancy each country has & Life increased over 15 years (Max - Min)
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
- Average Life Expectancy in each year from 2007 - 2022
```sql
SELECT Year, ROUND(AVG(`Life expectancy`),2) AS Avg_Life_Exp
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
AND `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year;
```



