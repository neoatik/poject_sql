/* We will find out 
The most optimal skills for Data Analyst
For this we need to find out the High demanded skills and
most payings skills
*/

WITH demanded_skills AS(
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demanded_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short='Data Analyst' AND
        job_work_from_home = True 
    GROUP BY
        skills_dim.skill_id
    ORDER BY
        demanded_count DESC
), average_salary AS(
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salry

    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short='Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = True 
    GROUP BY
        skills_job_dim.skill_id
    ORDER BY
        avg_salry DESC
)

SELECT
    demanded_skills.skill_id,
    demanded_skills.skills,
    demanded_count,
    avg_salry
FROM 
    demanded_skills
INNER JOIN average_salary ON demanded_skills.skill_id = average_salary.skill_id
WHERE demanded_count >10
ORDER BY
    avg_salry DESC,
    demanded_count
LIMIT 25

----------------  Without using the CTE ------------------------------
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demanded_count,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salry
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salry DESC,
    demanded_count
LIMIT 25