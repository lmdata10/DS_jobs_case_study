/*Question 5:
You’ve been hired by a leading HR consultancy to analyze salaries across various countries. Your goal is to determine which country offers 
the highest average salary for each job title, enabling your consultancy to recommend the best locations for job placements.
*/

WITH cte1 AS(
    SELECT
        company_location AS Country,
        job_title,
        AVG(salary_in_usd) AS avg_salary   -- Average salary by location and job
    FROM salaries
    GROUP BY company_location, job_title
    ),
    cte2 AS(
    SELECT
        *,
        DENSE_RANK() OVER(PARTITION BY job_title ORDER BY avg_salary) as drnk -- Assigning rank grouping by job
    FROM cte1
    )
    SELECT
        *      -- Filtering out the Highest Job
    FROM cte2
    WHERE drnk = 1;
