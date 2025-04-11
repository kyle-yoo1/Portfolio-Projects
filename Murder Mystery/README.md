# Murder Mystery Project (SQL)
## Project Overview
A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a murder that occurred sometime on Jan.15, 2018 and that it took place in SQL City. Start by retrieving the corresponding crime scene report from the police department’s database.

## Entity Relationship Diagram (ERD)
- Primary Keys are unqiue identifiers, ensuring no duplicates. They are represented by gold icons 🔑.

- Foreign Keys are arrow 🏹 connecting related data across tables, establishing relationships.

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

### STEP 8: Check Gym Checks-Ins using Clues
```sql
SELECT *
FROM get_fit_now_check_in
WHERE membership_id LIKE '48Z%'
AND check_in_date = "20180109";
```
<img width="310" alt="8" src="https://github.com/user-attachments/assets/70f7bf90-affa-4c5b-a5f5-eb3100e8dc37" />

### STEP 9: Verify Gender and Car Plate Number
```sql
SELECT *
FROM driver_license
WHERE gender = "male"
AND plate_number LIKE '%H42W%';
```
<img width="446" alt="9" src="https://github.com/user-attachments/assets/a056cbe6-7b8c-48a3-9f36-81dd788b12db" />

### STEP 10: Gather Additional Information about Potential Suspects
```sql
SELECT *
FROM person
WHERE license_id IN ("423327", "664760");
```
<img width="436" alt="10" src="https://github.com/user-attachments/assets/65e82359-72d6-4e1e-9cf0-696e0e0b6677" />

### STEP 11: Finalize Suspect Identification
```sql
SELECT *
FROM get_fit_now_member
WHERE person_id IN ("51739", "67318");
```
<img width="403" alt="11" src="https://github.com/user-attachments/assets/c9e175ed-e2d8-4edd-938e-d0adbc8d799f" />

⇒ person_id & id 67318, name Jeremy Bowers

### STEP 12: Confirm Solution in the Database
```sql
INSERT INTO solution VALUES (1, "Jeremy Bowers");
SELECT value FROM solution;
```
<img width="503" alt="12" src="https://github.com/user-attachments/assets/cd76a9c5-e08d-4c53-92e4-fc172f27bf12" />

### STEP 13: Analyze Murderer’s Interview
```sql
SELECT *
FROM person
WHERE name = "Jeremy Bowers";

SELECT *
FROM interview
WHERE person_id = "67318";
```
<img width="503" alt="13" src="https://github.com/user-attachments/assets/185a8fcd-01bf-4296-8bf1-0c0b6d615590" />


- **Key Cues**
    - The real villain is a female, approximately 5'5" (65") or 5'7" (67") tall.
    - She has red hair and drives a Tesla Model S.
    - She attended the SQL Symphony Concert 3 times in December 2017.
 
### STEP 14: Identify Telsa Model S Owners
```sql
SELECT *
FROM drivers_license
WHERE gender = "female"
	AND hair_color = "red"
	AND height BETWEEN 65 AND 67
	AND car_make = "Telsa"
	AND car_model = "Model S";
```
<img width="447" alt="14" src="https://github.com/user-attachments/assets/8bbafbfa-bf0d-4c1a-b65e-7b117fe29228" />

### STEP 15: Retrieve Personal Details of Potential Suspects
```sql
SELECT *
FROM person
WHERE license_id IN ("202298", "291182", "918773");
```
<img width="441" alt="15" src="https://github.com/user-attachments/assets/dbd4bf0d-3a0b-4438-a103-11471649de9e" />

### STEP 16: Determine SQL Symphony Concert Attendees
```sql
SELECT person_id, event_name, COUNT(*) AS event_count
FROM facebook_event_checkin
WHERE person_id IN ("78881", "90700", "99716")
GROUP BY person_id, event_name;
```
<img width="233" alt="16" src="https://github.com/user-attachments/assets/8d1e9c81-8abf-459f-9239-98c859955252" />

### STEP 17: Find The True Villain
```sql
SELECT *
FROM person
WHERE id = 99716;
```
<img width="437" alt="17" src="https://github.com/user-attachments/assets/101a43f7-f6fb-43e9-8824-17605c8594c0" />

### STEP 18: Confirm The Culprit
```sql
INSERT INTO solution VALUES (1, 'Miranda Priestly');
SELECT value FROM solution;
```
<img width="503" alt="18" src="https://github.com/user-attachments/assets/8f825d68-f722-45b3-85ad-272a5df1ae3d" />

## What I learned:
- How to navigate a complex relational database schema usign SQL alone
- Importance of breaking down large analytical problems into logical steps
- Enhanced my ability to connect disparate data points into one cohesive narrative
- Praticed investigative thinking through a fun, real-world inspired dataset







