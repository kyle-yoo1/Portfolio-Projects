USE cafe;

-- Cities Table
CREATE TABLE Cities (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL UNIQUE
);

-- Cafe Shops Table
CREATE TABLE Cafe_Shops (
    cafe_id INT AUTO_INCREMENT PRIMARY KEY,
    cafe_name VARCHAR(100) NOT NULL,
    city_id INT,
    outlet VARCHAR(3),
    FOREIGN KEY (city_id) REFERENCES Cities(city_id) 
);

-- Menu Items Table
CREATE TABLE Menu_Items (
    menu_id INT AUTO_INCREMENT PRIMARY KEY,
    cafe_id INT,
    item_name VARCHAR(100) NOT NULL,
    category VARCHAR(100),
    cafe_name varchar(100),
    FOREIGN KEY (cafe_id) REFERENCES Cafe_Shops(cafe_id) 
);





