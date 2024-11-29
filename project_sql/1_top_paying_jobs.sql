/*We will find out----
 -Top 10 highset-paying Data Analyst roles that are available remotely
 -Foucing on the job postings with specified salaries(remove nulls)
*/

SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS compnay_name
FROM
    job_postings_fact

LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_location ='Anywhere' AND 
    job_title = 'Data Analyst' AND
    salary_year_avg IS NOT NULL

ORDER BY 
    salary_year_avg DESC
LIMIT 10
