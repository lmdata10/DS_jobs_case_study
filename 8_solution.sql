/* Question-8:
As a compensation specialist at a Fortune 500 company, you’re tasked with analyzing salary trends by experience level and job title. 
Your goal is to calculate the average percentage increase in salary between 2023 and 2024, 
helping your company remain competitive in the talent market.
*/

WITH cte AS(
    SELECT
        experience_level,
        job_title,
        work_year,
        AVG(salary_in_usd) AS avg_salary
    FROM salaries
    GROUP BY experience_level, job_title,work_year
),
cte2 AS(
    SELECT
        experience_level,
        job_title,
        MAX(CASE WHEN work_year = 2023 THEN avg_salary END) AS avg_salary_23,
        MAX(CASE WHEN work_year = 2024 THEN avg_salary END) AS avg_salary_24
    FROM cte
    GROUP BY experience_level, job_title
)

SELECT 
    *,
    ROUND(((avg_salary_24-avg_salary_23)/avg_salary_23)*100,2) AS chg_pct
FROM cte2
WHERE avg_salary_23 AND avg_salary_24 IS NOT NULL
