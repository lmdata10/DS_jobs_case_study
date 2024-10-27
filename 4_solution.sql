/*Question-4
As a data analyst at a global recruitment agency, your task is to identify locations 
where entry-level average salaries exceed the market average for the same job title and experience level, 
helping your agency guide candidates toward more lucrative opportunities.
*/

WITH job_avg AS (
    SELECT
        job_title,
        AVG(salary_in_usd) AS avg_salary
    FROM salaries
    WHERE experience_level = 'EN'
    GROUP BY job_title
),
country_job_avg AS (
    SELECT
        company_location AS location,
        job_title,
        AVG(salary_in_usd) AS country_avg_salary
    FROM salaries
    WHERE experience_level = 'EN'
    GROUP BY company_location, job_title
)
SELECT
    c.location,
    j.job_title,
    j.avg_salary,
    c.country_avg_salary
FROM job_avg j
INNER JOIN country_job_avg c
    ON j.job_title = c.job_title
WHERE c.country_avg_salary > j.avg_salary;