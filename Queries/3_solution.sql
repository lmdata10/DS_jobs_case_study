/*Question:3
 Imagine you’re a data scientist working for a workforce management platform. Your goal is to calculate the 
 percentage of employees in fully remote roles with salaries exceeding $100,000 USD. 
 This analysis will highlight the appeal of high-paying remote positions in today’s job market.
 */
WITH cte1 AS (
    SELECT COUNT(*) AS total_emp
    FROM salaries
    WHERE salary_in_usd > 100000 -- Total employees with salary > 100,000
),
cte2 AS (
    SELECT COUNT(*) AS remote_emp
    FROM salaries
    WHERE remote_ratio = 100
        AND salary_in_usd > 100000 -- Remote employees with salary > 100,000
)
SELECT ROUND((cte2.remote_emp * 100.0) / cte1.total_emp, 2) AS pct_remote_work
FROM cte1,
    cte2;


-- Variable Approach
SET @total = (
    SELECT COUNT(*)
    FROM salaries
    WHERE salary_in_usd > 100000);

SET @rm_count = (
    SELECT COUNT(*)
    FROM salaries
    WHERE remote_ratio = 100
        AND salary_in_usd > 100000);

SET @pct = (
    SELECT ROUND((SELECT @rm_count) / (SELECT @total)*100,2));

SELECT @pct AS Percentage