/* Question-7:
Picture yourself as a workforce strategist at a global HR tech startup. Your mission is to determine the percentage of fully remote roles 
for each experience level in 2021 and compare it with 2024 data, highlighting any significant changes in remote work adoption over the years.
*/

WITH cte AS(
SELECT experience_level, 
    COUNT(*) As total
FROM salaries
WHERE work_year = 2021
GROUP BY experience_level
),
cte2 AS(
SELECT experience_level, 
    COUNT(*) AS rmt_2021
FROM salaries
WHERE remote_ratio = 100
    AND work_year = 2021
GROUP BY experience_level
),
cte3 AS(
SELECT experience_level, 
    COUNT(*) As total_24
FROM salaries
WHERE work_year = 2024
GROUP BY experience_level
),
cte4 AS(
SELECT experience_level, 
    COUNT(*) AS rmt_2024
FROM salaries
WHERE remote_ratio = 100
    AND work_year = 2024
GROUP BY experience_level
)

SELECT a.experience_level,
    total,
    (rmt_2021/total) * 100 AS pct_2021,
    (rmt_2024/total_24) * 100 AS pct_2024
FROM cte a 
INNER JOIN cte2 b ON a.experience_level=b.experience_level
INNER JOIN cte3 c ON a.experience_level=c.experience_level
INNER JOIN cte4 d ON a.experience_level=d.experience_level


-- Optimized approach using CASE - WHEN - THEN

WITH experience_data AS (
    SELECT
        experience_level,
        SUM(CASE WHEN work_year = 2021 THEN 1 ELSE 0 END) AS total_2021,
        SUM(CASE WHEN work_year = 2021 AND remote_ratio = 100 THEN 1 ELSE 0 END) AS rmt_2021,
        SUM(CASE WHEN work_year = 2024 THEN 1 ELSE 0 END) AS total_2024,
        SUM(CASE WHEN work_year = 2024 AND remote_ratio = 100 THEN 1 ELSE 0 END) AS rmt_2024
    FROM salaries
    WHERE work_year IN (2021, 2024)
    GROUP BY experience_level
)
SELECT
    experience_level,
    total_2021,
    ROUND((rmt_2021/ total_2021) * 100, 2) AS pct_2021,
    total_2024,
    ROUND((rmt_2024/ total_2024) * 100, 2) AS pct_2024
FROM experience_data
WHERE total_2021 > 0 AND total_2024 > 0 -- This filter out ) if in case we fetch a zero from Case statement
ORDER BY experience_level;