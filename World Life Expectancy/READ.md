# World Life Expectancy Summary

## Exploratory Data Analysis (EDA)
- hello

```sql
SELECT state_name, SUM(Aland)
FROM ushouseholdincome
GROUP BY state_name
ORDER BY SUM(Aland) DESC
LIMIT 10;
```

