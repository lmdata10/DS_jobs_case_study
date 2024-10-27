/*Question-6:
As a business consultant for a multinational corporation, your task is to analyze salary trends across different locations. 
Your objective is to identify countries where the average salary has increased consistently over 
the last three years (current year and previous two years), providing insights into regions with sustained salary growth.
*/


WITH salary_aggregation AS (
    SELECT
        company_location,
        work_year,
        AVG(salary_in_usd) AS avg_salary
    FROM salaries
    WHERE work_year BETWEEN YEAR(CURRENT_DATE()) - 2 AND YEAR(CURRENT_DATE())
    GROUP BY company_location, work_year
    ORDER BY company_location
),
pivoted_salaries AS (
    SELECT
        company_location,
        MAX(CASE WHEN work_year = YEAR(CURRENT_DATE()) THEN avg_salary END) AS avg_salary_24,
        MAX(CASE WHEN work_year = YEAR(CURRENT_DATE()) - 1 THEN avg_salary END) AS avg_salary_23,
        MAX(CASE WHEN work_year = YEAR(CURRENT_DATE()) - 2 THEN avg_salary END) AS avg_salary_22
    FROM salary_aggregation
    GROUP BY company_location
)
SELECT
    company_location,
    avg_salary_24,
    avg_salary_23,
    avg_salary_22
FROM pivoted_salaries
WHERE avg_salary_24 > avg_salary_23
  AND avg_salary_23 > avg_salary_22
ORDER BY company_location;