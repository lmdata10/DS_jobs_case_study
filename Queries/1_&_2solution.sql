/*
 Question 1:
 You're a Compensation analyst employed by an MNC. Your Assignment is to Pinpoint Countries that offers 
 full remote work for the title 'managers’ with salaries that exceeds $90,000 USD
 */
SELECT DISTINCT company_location
FROM salaries
WHERE job_title LIKE '%manager%'
    AND salary_in_usd > 90000
    AND remote_ratio = 100;
    
/*Question2:
 As a remote work advocate Working for a progressive HR tech startup that places its freshers’ clients IN large tech 
 firms, you're tasked with identifying the top five Countries with the greatest number of 
 large (company size) companies.
 */
SELECT company_location,
    COUNT(*) as number_of_large_companies
FROM salaries
WHERE company_size = "L"
    AND experience_level = "EN"
GROUP BY company_location
ORDER BY number_of_large_companies DESC
LIMIT 5;
