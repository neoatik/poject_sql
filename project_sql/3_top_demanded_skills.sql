/* What we will do ---
 we will find out the top 5 high demanded skills
 for the the "Data Analyst" role

For that we need to use COUNT 
*/

SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demanded_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short='Data Analyst' AND
    job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    demanded_count DESC
LIMIT 5