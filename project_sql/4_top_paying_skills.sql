/* We will find ---
- the top 25 top paying skills fro Data Analyst roles and which are remote jobs
 For this average of salaries
*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salry

FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short='Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    avg_salry DESC
LIMIT 25