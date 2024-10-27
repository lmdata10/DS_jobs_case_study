/* In year 2024, due to increase demand in data industry , there was  increase in salaries of data field employees.
    Entry Level-35%  of the salary.
    Mid junior – 30% of the salary.
    Immediate senior level- 22% of the salary.
    Expert level- 20% of the salary.
    Director – 15% of the salary.
you have to update the salaries accordingly and update it back in the original database. */

UPDATE ds_jobs
SET salary_in_usd = 
    CASE 
        WHEN experience_level = 'EN' THEN salary_in_usd * 1.35 
        WHEN experience_level = 'MI' THEN salary_in_usd * 1.30  
        WHEN experience_level = 'SE' THEN salary_in_usd * 1.22  
        WHEN experience_level = 'EX' THEN salary_in_usd * 1.20  
        WHEN experience_level = 'DX' THEN salary_in_usd * 1.15  
        ELSE salary_in_usd 
    END
WHERE work_year = 2024; 