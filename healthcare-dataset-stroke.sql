CREATE TABLE healthcare (
    id INT PRIMARY KEY,
    gender TEXT,
    age INT,
    hypertension INT,
    heart_disease INT,
    ever_married Text,
    work_type text,
    Residence_type TEXT,
	avg_glucose_level float,
	bmi float,
	smoking_status Text,
	storke int
);

select * from healthcare



-- List male and female who had a stroke
select gender, count(*) as gender_who_had_a_storke
from healthcare
where storke=1
group by gender;

-- Find all patients older than 60
select age from
healthcare 
where age<60;

--so get the id, age, and gender of all female patients.
select id,age,gender
from healthcare
where gender='Female'

-- List patients sorted by avg_glucose_level from highest to lowest.
select avg_glucose_level,id
from healthcare
order by avg_glucose_level
desc;

-- Find all ages who have never smoked
select age,id from healthcare
where smoking_status='never smoked'

-- Count how many patients had a stroke vs. did not.
select storke,count(*) as patient_
from healthcare
group by storke;

-- Find the average age of patients who had a stroke vs. those who didn't.
select storke, avg(age) as age_of_patient
from healthcare
group by storke;

-- Find the average bmi grouped by gender.
select gender, avg(bmi) as avg_bmi_gender
from healthcare
group by gender;

-- Count how many patients have both hypertension and heart_disease.
select sum(hypertension) as hypertension_patients ,
sum(heart_disease) as heart_disease_patients
from healthcare;

-- . Count how many patients had a stroke vs. did not.
select sum(storke) as storke_count, count(*)
- sum(storke) as no_storke_count
from healthcare

-- Find the average age of patients who had a stroke vs. those who didn't.
select avg(storke) as avg_count , count(*)
- avg(storke) as avg_who_didnt
from healthcare

-- Count the number of patients by work_type.
select work_type,count(*)
from healthcare
group by work_type

-- Find work types where the average avg_glucose_level is above 110.

select work_type, avg(avg_glucose_level) as average_glucose
from healthcare
group by work_type, avg_glucose_level
having avg(avg_glucose_level)>110;

-- Find smoking statuses where more than 100 patients had a stroke.

select smoking_status ,count(*)
from healthcare
where storke = '1' 
group by smoking_status
having smoking_status='smokes';

-- What percentage of patients with hypertension = 1 had a stroke, compared to those with hypertension = 0?
select hypertension, avg(storke) * 100 as percentage
from healthcare
group by hypertension;

-- What's the stroke rate (%) by Residence_type (Urban vs Rural)?
select Residence_type, round(avg(storke) * 100,2) as percentage
from healthcare
group by Residence_type;

-- . Create age buckets (e.g., 0–20, 21–40, 41–60, 61+) using CASE WHEN, then count stroke occurrences in each bucket.
select 
case
	when age between 0 and 20 then '0-20'
	when age between 21 and 40 then '21-40'
	when age between 41 and 60 then '41-60'
	else '61+'
end as age_bucket,
count(*) as storke_count
from healthcare
where storke = 1
group by age_bucket

-- Categorize bmi into "Underweight", "Normal", "Overweight", "Obese" and find stroke rate per category.
select
case 
	when bmi < 18.5 then 'underweight'
	when bmi < 25 then 'Normal'
	when bmi < 30 then 'Overweight'
	else 'Obese'
end as bmi_category,
avg(storke) *100 as storke_rate
from healthcare
group by 
case
	when bmi < 18.5 then 'underweight'
	when bmi < 25 then 'Normal'
	when bmi < 30 then 'Overweight'
	else 'Obese'
end;
