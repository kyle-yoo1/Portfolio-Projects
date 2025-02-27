-- Queries for Different Scenarios

SELECT * FROM cafe_shops;
SELECT * FROM cities;
SELECT * FROM menu_items;

-- Query 1: Retrieve and Count all cafe in bellevue city
SELECT cs.cafe_name, c.city_name
FROM cafe_shops cs
JOIN cities c ON cs.city_id = c.city_id
WHERE c.city_name = 'Bellevue';

-- Query 2: Retreive all menu items from Mercurys Coffee
SELECT m.item_name, m.category
FROM menu_items m
JOIN cafe_shops cs ON m.cafe_id = cs.cafe_id
WHERE cs.cafe_name LIKE '%Mercurys%';

-- Query 3: Find UNIQUE coffee that has 'Caramel' coffee drink in Mercurys Coffee (No duplicate)
SELECT DISTINCT m.item_name, m.category
FROM menu_items m
JOIN cafe_shops cs ON m.cafe_id = cs.cafe_id
WHERE cs.cafe_name LIKE '%Mercurys%' AND m.item_name LIKE '%caramel%';

-- Query 4: Count the number of cafes in each city (Need to update)
SELECT c.city_name, COUNT(cs.cafe_id) AS total_cafes
FROM Cities c
LEFT JOIN Cafe_Shops cs ON c.city_id = cs.city_id
GROUP BY c.city_name
ORDER BY total_cafes DESC;

-- Query 5: Retrieve all cafes that have outlet (YES)
SELECT cafe_name, city_id, outlet
FROM cafe_shops
WHERE outlet = 'YES';

-- Query 6: Count the number of menu items per cafe
SELECT cs.cafe_name, COUNT(m.menu_id) AS total_menu_items
FROM Cafe_Shops cs
LEFT JOIN Menu_Items m ON cs.cafe_id = m.cafe_id
GROUP BY cs.cafe_name
ORDER BY total_menu_items DESC;




