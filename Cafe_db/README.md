# Cafe Database Management Project

## 1. Background and Project Overview

This project highlights SQL queries used to analyze and manage a cafe database, focusing on retrieving insights about coffee shops, menu items, and sales trends.

## Table of Contents
- [Background and Project Overview](#Background-and-Project-Overview)
- [Data Structure and Schema](#Data-Structure-and-Schema)
- [Exploratory Data Analysis (EDA)](#Exploratory-Data-Analysis-(EDA))

## 2. Data Structure and Schema
The database consists of the following tables:

![drawSQL-image-export-2025-02-21 (2)](https://github.com/user-attachments/assets/c5a63ed7-545b-4f0c-a2b4-93661c3438d0)


#### `Cities`
- `city_id` (Primary Key)
- `city_name`

#### `Cafe_Shops`
- `cafe_id` (Primary Key)
- `cafe_name`
- `city_id` (Foreign Key referencing Cities)
- `outlet`

#### `Menu_Items`
- `menu_id` (Primary Key)
- `cafe_id` (Foreign Key referencing Cafe_Shops)
- `item_name`
- `category`
  
## 3. Exploratory Data Analysis (EDA)
- Query 1: Find and Count all cafe in Bellevue city.
```sql
SELECT cs.cafe_name, c.city_name
FROM cafe_shops cs
JOIN cities c ON cs.city_id = c.city_id
WHERE c.city_name = 'Bellevue';
```
<img width="150" alt="cafe_q1" src="https://github.com/user-attachments/assets/da8f49b2-e32a-40b4-8748-89cb11381694" />
<br><br>
- Query 2: What menu items are there at Mercurys Coffee Co?
```sql
SELECT m.item_name, m.category
FROM menu_items m
JOIN cafe_shops cs ON m.cafe_id = cs.cafe_id
WHERE cs.cafe_name LIKE '%Mercurys%';
```
<img width="188" alt="cafe_q2" src="https://github.com/user-attachments/assets/9baa410f-512a-485a-98a1-d1f5c825073c" />

<br><be>

- Query 3: What are the unique coffees that include 'Cararel' in Mercurys Coffee (No duplicate)?
```sql
SELECT DISTINCT m.item_name, m.category
FROM menu_items m
JOIN cafe_shops cs ON m.cafe_id = cs.cafe_id
WHERE cs.cafe_name LIKE '%Mercurys%' AND m.item_name LIKE '%caramel%';
```
<img width="196" alt="cafe_q3" src="https://github.com/user-attachments/assets/bee75b26-add3-4b97-b092-f48e539ce89d" />

<br><br>
- Query 4: How many cafes are there in each city? (Need to update)
```sql
SELECT c.city_name, COUNT(cs.cafe_id) AS total_cafes
FROM Cities c
LEFT JOIN Cafe_Shops cs ON c.city_id = cs.city_id
GROUP BY c.city_name
ORDER BY total_cafes DESC;
```
<img width="119" alt="cafe_q4" src="https://github.com/user-attachments/assets/815b3d7d-f460-4ea1-920c-9e18a06b9fbc" />











## 4. Executive Summary
### Overview of finding
- Popular drinks include Cappuccino and Caramel-based coffee.
- Some cafes have exclusive menu items not available elsewhere.
- Certain cities have more diverse tea options.
- some cafes do not have outlets, but mostly do.

This project demonstrates how SQL queries can drive data analysis and decision-making in the coffee shop industry.








