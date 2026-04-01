create database birds_analysis;

use birds_analysis;

select count(*) from bird_data;

alter table bird_data
modify Date datetime;

select count(*) as total_records from bird_data;

select ecosystem ,count(*) as total from bird_data 
group by ecosystem
order by total desc;

select common_name , count(*) as total 
from bird_data
group by Common_Name
order by total desc
limit 10;

select month, count(*) as total 
from bird_data
group by month
order by month;
##seasonwise ANALysis 
SELECT 
    CASE 
        WHEN MONTH(Date) IN (12,1,2) THEN 'Winter'
        WHEN MONTH(Date) IN (3,4,5) THEN 'Spring'
        WHEN MONTH(Date) IN (6,7,8) THEN 'Summer'
        ELSE 'Fall'
    END AS Season,
    COUNT(*) AS total_observations
FROM bird_data
GROUP BY Season
ORDER BY total_observations DESC;

#group data by locationtype
select location_type , count(*) as total_observation
from bird_data
group by Location_Type
order by total_observation desc;

#Compare observations across different Plot_Name 
select plot_name , count(*) as total_observation 
from bird_data
group by plot_name 
order by total_observation desc;

# Count unique species (Scientific_Name) 
Select location_type , count(distinct Scientific_Name ) as unique_species
from bird_data
group by location_type
order by unique_species desc;

#Check the Interval_Length and ID_Method columns to identify the most common activity types (e.g., Singing).
select ID_method , count(*) as total_observation
from bird_data
group by ID_Method
order by total_observation;

select Interval_Length , count(*) as total_observation
from bird_data
group by Interval_Length
order by total_observation;

#Male and Female ratio 
SELECT 
    Scientific_Name,
    SUM(CASE WHEN Sex = 'Male' THEN 1 ELSE 0 END) AS Male_Count,
    SUM(CASE WHEN Sex = 'Female' THEN 1 ELSE 0 END) AS Female_Count,
    ROUND(
        SUM(CASE WHEN Sex = 'Male' THEN 1 ELSE 0 END) / 
        NULLIF(SUM(CASE WHEN Sex = 'Female' THEN 1 ELSE 0 END), 0),
        2
    ) AS Male_Female_Ratio
FROM bird_data
WHERE Sex IN ('Male', 'Female')
GROUP BY Scientific_Name
ORDER BY Male_Female_Ratio DESC;

# how Temperature, Humidity, Sky, and Wind impact observations.
SELECT 
    Sky,
    COUNT(DISTINCT Scientific_Name) AS unique_species
FROM bird_data
GROUP BY Sky;

SELECT 
    Round(Humidity,2) as humidy_level,
    COUNT(DISTINCT Scientific_Name) AS unique_species
FROM bird_data
GROUP BY Humidity;

SELECT 
    Round(Temperature,2) as temp,
    COUNT(DISTINCT Scientific_Name) AS unique_species
FROM bird_data
GROUP BY Temperature;

SELECT 
    wind,
    COUNT(DISTINCT Scientific_Name) AS unique_species
FROM bird_data
GROUP BY Wind;

#total observation by disturbance
SELECT 
    Disturbance,
    COUNT(*) AS total_observations
FROM bird_data
GROUP BY Disturbance
ORDER BY total_observations DESC;

SELECT 
    Disturbance,
    COUNT(DISTINCT Scientific_Name) AS unique_species
FROM bird_data
GROUP BY Disturbance
ORDER BY unique_species DESC;

SELECT 
    Scientific_Name,
    Distance,
    COUNT(*) AS total
FROM bird_data
GROUP BY Scientific_Name, Distance
ORDER BY Scientific_Name, total DESC;

Select Flyover_Observed , count(*) as total 
from bird_data
group by Flyover_Observed
order by total desc;

SELECT 
    Scientific_Name,
    SUM(CASE WHEN Flyover_Observed = 'TRUE' THEN 1 ELSE 0 END) AS flyover_count,
    COUNT(*) AS total,
    SUM(CASE WHEN Flyover_Observed = 'TRUE' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS percentage
FROM bird_data
GROUP BY Scientific_Name
ORDER BY percentage DESC;

SELECT 
    Observer,
    COUNT(DISTINCT Scientific_Name) AS unique_species
FROM bird_data
GROUP BY Observer
ORDER BY unique_species DESC;

SELECT 
    Visit,
    COUNT(*) AS total_observations
FROM bird_data
GROUP BY Visit
ORDER BY Visit;

SELECT 
    PIF_Watchlist_Status,
    COUNT(*) AS total
FROM bird_data
GROUP BY PIF_Watchlist_Status;

SELECT 
    COUNT(DISTINCT Scientific_Name) AS at_risk_species
FROM bird_data
WHERE PIF_Watchlist_Status = 'TRUE';
SELECT DISTINCT Scientific_Name 
FROM bird_data
WHERE PIF_Watchlist_Status = 'TRUE';

SELECT 
    Regional_Stewardship_Status,
    COUNT(*) AS total
FROM bird_data
GROUP BY Regional_Stewardship_Status;

SELECT 
    AOU_Code,
    COUNT(DISTINCT Scientific_Name) AS unique_species
FROM bird_data
GROUP BY AOU_Code
ORDER BY unique_species DESC;