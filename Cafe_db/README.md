# Cafe Database Management Project

## 1. Background and Overview

This project highlights SQL queries used to analyze and manage a cafe database, focusing on retrieving insights about coffee shops, menu items, and sales trends.

## Table of Contents
- [Project Overview](#project-overview)
- Data Structure and Schema
- Executive Summary

## 2. Data Structure and Overview
The database consists of the following tables:

![drawSQL-image-export-2025-02-21](https://github.com/user-attachments/assets/874d8f54-9998-46fb-b5a6-d74050ed586f)

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

#### `Cafe_Menu`
- `cafe_id` (Foreign Key referencing Cafe_Shops)
- `menu_id` (Foreign Key referencing Menu_Items)

## 3. Executive Summary
### Overview of finding
- Popular drinks include Cappuccino and Caramel-based coffee.
- Some cafes have exclusive menu items not available elsewhere.
- Certain cities have more diverse tea options.
- some cafes do not have outlets, but mostly do.

This project demonstrates how SQL queries can drive data analysis and decision-making in the coffee shop industry.








