/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/

SELECT
    skills_dim.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 1) AS median_salary,
    -- COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*))) / 1_000_000, 2) AS optimal_score
FROM 
    job_postings_fact AS jpf
INNER JOIN 
    skills_job_dim ON jpf.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = TRUE
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY 
    skills_dim.skills
HAVING 
    COUNT(jpf.*) > 100
ORDER BY 
    optimal_score DESC
LIMIT 25;

/*

Key Insights
- Top Optimization: Terraform achieves the highest priority score by balancing a premium $184K median salary with highly active market demand.
- Volume Anchors: Python and SQL remain mandatory foundations, offering massive job security (>1,100 posts) and solid $130K+ medians.
- High-Yield Ecosystems: AWS, Spark, and Airflow dominate as the most financially rewarding cloud infrastructure and data processing standards.
- Ideal Technical Profile: Candidates who bridge core data development (Python/SQL) with Cloud DevOps (AWS/Terraform/Airflow) command the highest market value.


┌────────────┬───────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ ln_demand_count │ optimal_score │
│  varchar   │    double     │     double      │    double     │
├────────────┼───────────────┼─────────────────┼───────────────┤
│ terraform  │      184000.0 │             5.3 │          0.97 │
│ python     │      135000.0 │             7.0 │          0.95 │
│ sql        │      130000.0 │             7.0 │          0.91 │
│ aws        │      137320.3 │             6.7 │          0.91 │
│ airflow    │      150000.0 │             6.0 │          0.89 │
│ spark      │      140000.0 │             6.2 │          0.87 │
│ snowflake  │      135500.0 │             6.1 │          0.82 │
│ kafka      │      145000.0 │             5.7 │          0.82 │
│ azure      │      128000.0 │             6.2 │          0.79 │
│ java       │      135000.0 │             5.7 │          0.77 │
│ scala      │      137290.5 │             5.5 │          0.76 │
│ kubernetes │      150500.0 │             5.0 │          0.75 │
│ git        │      140000.0 │             5.3 │          0.75 │
│ databricks │      132750.0 │             5.6 │          0.74 │
│ redshift   │      130000.0 │             5.6 │          0.73 │
│ gcp        │      136000.0 │             5.3 │          0.72 │
│ nosql      │      134415.0 │             5.3 │          0.71 │
│ hadoop     │      135000.0 │             5.3 │          0.71 │
│ pyspark    │      140000.0 │             5.0 │           0.7 │
│ mongodb    │      135750.0 │             4.9 │          0.67 │
│ docker     │      135000.0 │             5.0 │          0.67 │
│ go         │      140000.0 │             4.7 │          0.66 │
│ r          │      134775.0 │             4.9 │          0.66 │
│ github     │      135000.0 │             4.8 │          0.65 │
│ bigquery   │      135000.0 │             4.8 │          0.65 │
└────────────┴───────────────┴─────────────────┴───────────────┘
*/
