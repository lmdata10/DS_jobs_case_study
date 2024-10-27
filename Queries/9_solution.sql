/* Question-9:
As a consultant for a client exploring a transition to a different domain in the data industry, your task is to recommend a suitable domain 
based on the client’s input (such as years of experience, employment type, company location, and size). For example, 
if a data analyst wants to transition to data science or data engineering, your recommendation should be based on current industry trends 
and average salaries. This guidance will help the client focus on acquiring the right skills for their desired career path.
*/

DELIMITER / / CREATE PROCEDURE get_avg_salary (
    IN exp_level VARCHAR(2),
    IN emp_type VARCHAR(3),
    IN comp_location VARCHAR(2),
    IN comp_size VARCHAR(2)
) BEGIN
SELECT
    job_title,
    experience_level,
    company_location,
    company_size,
    employment_type,
    ROUND(AVG(salary), 2) AS avg_salary
FROM
    salaries
WHERE
    experience_level = exp_level
    AND company_location = comp_location
    AND company_size = comp_size
    AND employment_type = emp_type
GROUP BY
    experience_level,
    employment_type,
    company_location,
    company_size,
    job_title
ORDER BY
    avg_salary DESC;
END / / DELIMITER;

/*By setting a delimiter, we’re instructing MySQL to treat all statements within the block as a single unit, 
ensuring they are not executed or parsed separately until the custom delimiter is reached.
*/

CALL get_avg_salary('EN', 'FT', 'AU', 'M') 

DROP PROCEDURE get_avg_salary