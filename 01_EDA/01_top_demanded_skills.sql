/*
Question: What are the most in-demand skills for data engineers?

    - Identify the top 10 in-demand skills for data engineers
    - Focus on remote job postings

    Why?

    Retrieves the top 10 skills with the highest demand in the remote job market, providing 
    insights into the most valuable skills for data engineers seeking remote work.
*/

SELECT
    skills_dim.skills,
    COUNT(skills_dim.skill_id) AS demand_count
FROM 
    job_postings_fact AS jpf
INNER JOIN 
    skills_job_dim ON jpf.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = True
GROUP BY 
    skills_dim.skills
ORDER BY 
    demand_count DESC
LIMIT 10;



/*

Key Takeaways
- Baseline Competencies: SQL and Python remain non-negotiable core requirements.
- Cloud Infrastructure: AWS and Azure expertise is imperative for scaling modern architectures.
- Data Processing: Apache Spark continues to be the industry standard for big data.
- Modern Ecosystems: Demand is surging for proficiency in Airflow, Snowflake, and Databricks.
- Top 10 Completers: Java and GCP round out the most highly sought-after technical skills.

┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
└────────────┴──────────────┘
*/




















