create database jobs_market_analysis
go 

use jobs_market_analysis
go


CREATE TABLE jobs_postings (
    title VARCHAR(255),
    company VARCHAR(255),
    location VARCHAR(255),
    salary_min INT,
    salary_max INT,
    contract_type VARCHAR(100),
    contract_time VARCHAR(100),
    category VARCHAR(255),
    city_searched VARCHAR(100),
    role_searched VARCHAR(100)
);

select count(*) from jobs_postings where city_searched = 'Mumbai' 
select count(*) from jobs_postings where city_searched = 'Gurgaon'
select count(*) from jobs_postings where city_searched = 'Bangalore'
select count(*) from jobs_postings where city_searched = 'Noida'
select count(*) from jobs_postings where city_searched = 'Pune'


select distinct city_searched , count(*) from jobs_postings group by city_searched;

-- 1. Postings and avg salary by role
SELECT role_searched,
       COUNT(*) AS total_postings,
       AVG((salary_min + salary_max) / 2.0) AS avg_salary
FROM jobs_postings
GROUP BY role_searched
ORDER BY total_postings DESC;

-- 2. Postings and avg salary by city
SELECT city_searched,
       COUNT(*) AS total_postings,
       AVG((salary_min + salary_max) / 2.0) AS avg_salary
FROM jobs_postings
GROUP BY city_searched
ORDER BY avg_salary DESC;

-- 3. % of postings with salary disclosed
SELECT 
    COUNT(CASE WHEN salary_min IS NOT NULL THEN 1 END) AS with_salary,
    COUNT(*) AS total,
    CAST(COUNT(CASE WHEN salary_min IS NOT NULL THEN 1 END) AS FLOAT) / COUNT(*) * 100 AS pct_with_salary
FROM jobs_postings;

-- 4. Top hiring companies
SELECT company, COUNT(*) AS postings
FROM jobs_postings
GROUP BY company
ORDER BY postings DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

-- 5. Top city per role, using RANK() + PARTITION BY 
SELECT role_searched, city_searched, postings, rnk
FROM (
    SELECT role_searched, city_searched,
           COUNT(*) AS postings,
           RANK() OVER (PARTITION BY role_searched ORDER BY COUNT(*) DESC) AS rnk
    FROM jobs_postings
    GROUP BY role_searched, city_searched
) ranked
WHERE rnk = 1;


--6. Top city per role, using CTE + RANK()
WITH city_counts AS (
    SELECT role_searched, city_searched, COUNT(*) AS postings
    FROM jobs_postings
    GROUP BY role_searched, city_searched
),
ranked AS (
    SELECT *, RANK() OVER (PARTITION BY role_searched ORDER BY postings DESC) AS rnk
    FROM city_counts
)
SELECT role_searched, city_searched, postings
FROM ranked
WHERE rnk = 1;


--7. % share of postings by role
SELECT role_searched,
       COUNT(*) AS postings,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS pct_share
FROM jobs_postings
GROUP BY role_searched
ORDER BY postings DESC;