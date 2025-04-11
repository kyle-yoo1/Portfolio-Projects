# SQL Murder Mystery
## Project Overview
A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a murder that occurred sometime on Jan.15, 2018 and that it took place in SQL City. Start by retrieving the corresponding crime scene report from the police department’s database.

## Entity Relationship Diagram (ERD)
Primary Keys are unqiue identifiers, ensuring no duplicates. They are represented by gold icons 🔑.

Foreign Keys are arrow 🏹 connecting related data across tables, establishing relationships.

![schema](https://github.com/user-attachments/assets/703f3e56-dc55-40d7-8523-26805f880770)

### Key Clues to Crime Scene Report
- The crime is a “murder” →  `type` field
- The crime scene occurred on “Jan 15, 2018 (20180115)” → `date` field
- The crime scene occurred at “SQL City” → `city` field

## Step-by-Step Highlights
### Step 1: Retrieve Crime Scene Report
```sql
SELECT *
FROM crime_scene_report;
```
<img width="470" alt="1" src="https://github.com/user-attachments/assets/0dacbd3a-6534-4104-aa9a-7d5963938e9a" />

### Step 2: Filter Crime Scenes by Type
```sql 
SELECT *
FROM crime_scene_report
WHERE type = "murder";
```
<img width="443" alt="2" src="https://github.com/user-attachments/assets/6e1ac8bd-c646-4cdf-a1a8-7ba333600ada" />


### Step 3: Narrow Down Crime Scenes by Date and City
```sql 
SELECT *
FROM crime_scene_report
WHERE type = "murder"
AND date = 20180115
AND city = "SQL City";
```
<img width="421" alt="3" src="https://github.com/user-attachments/assets/0c6d610c-d9e9-4699-b70c-65c8a73cf58d" />
=> First witness’s address is “Northwestern Dr’
=> Second witness's name is “Annabel”, and lives at “Franklin Ave”

### Step 4: Explore Person Table
```sql
SELECT *
FROM person;
LIMIT 5;
```
<img width="497" alt="4" src="https://github.com/user-attachments/assets/fa817f27-dd12-4220-943a-66ccbfe00372" />

### Step 5: Identify the First Witness’s Location
```sql
SELECT *
FROM person
WHERE address_street_name = "Northwestern Dr"
ORDER BY address_number DESC
LIMIT 5;<img width="439" alt="5" src="https://github.com/user-attachments/assets/7fde7425-9969-4191-a9b9-2e1c648a46d2" />
```
⇒ First witness name is Morty Schapiro with id 14887, license_id 118009, and ssn 111564949.

### Step 6: Locate Second Witness by Name and Address
```sql
SELECT *
FROM person
WHERE name LIKE '%Annabel%'
AND address_street_name = "Franklin Ave";
```
<img width="423" alt="6" src="https://github.com/user-attachments/assets/2ed58008-4ea0-4f1c-a166-923a722fc14d" />

⇒ Second witness name is Annabel Miller with id 16371, license_id 490173, and ssn 318771143.

### STEP 7: Review Witness Interviews
```sql
SELECT  *
FROM interview
WHERE person_id IN ("14887", "16371");
```
<img width="423" alt="7" src="https://github.com/user-attachments/assets/490ac378-abff-43d7-bff4-864f60febbe0" />

- **Key Cues**
    - Murderer is a man and a member of a gym called "Get Fit Now Gym" and has a gold membership no. starting from "48Z".
    - He was working out at the gym on 9th Jan.
    - He drives a car with car plate containing "H42W".

