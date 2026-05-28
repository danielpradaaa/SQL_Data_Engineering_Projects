/*
Question: What are the highest-paying skills for data engineers?

* Calculate the median salary for each skill required in data engineer positions
* Focus on remote positions with specified salaries
* Include skill frequency to identify both salary and demand
* Why? Helps identify which skills command the highest compensation while also showing
how common those skills are, providing a more complete picture for skill development priorities
*/


SELECT
    skills_dim.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 1) AS median_salary,
    COUNT(jpf.*) AS demand_count
FROM 
    job_postings_fact AS jpf
INNER JOIN 
    skills_job_dim ON jpf.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = TRUE
GROUP BY 
    skills_dim.skills
HAVING 
    COUNT(jpf.*) > 100
ORDER BY 
    median_salary DESC
LIMIT 25;


/*

Key Insights

- Top Premium:** **Rust** leads compensation ($210K median) but remains a low-volume niche.
- The Sweet Spot:** **Terraform** and **Golang** combine top-tier pay ($184K) with massive market demand.
- Enterprise Tech:** High premiums ($150K–$175K+) persist for infrastructure and orchestration standards like **Airflow** and **Kubernetes**.
- Strategic ROI:** Pairing Infrastructure-as-Code (**Terraform**) with workflow orchestration (**Airflow**) yields the highest marketability and compensation leverage.

┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ rust       │      210000.0 │          232 │
│ golang     │      184000.0 │          912 │
│ terraform  │      184000.0 │         3248 │
│ spring     │      175500.0 │          364 │
│ neo4j      │      170000.0 │          277 │
│ gdpr       │      169615.5 │          582 │
│ zoom       │      168437.5 │          127 │
│ graphql    │      167500.0 │          445 │
│ mongo      │      162250.0 │          265 │
│ fastapi    │      157500.0 │          204 │
│ django     │      155000.0 │          265 │
│ bitbucket  │      155000.0 │          478 │
│ crystal    │      154223.5 │          129 │
│ atlassian  │      151500.0 │          249 │
│ c          │      151500.0 │          444 │
│ typescript │      151000.0 │          388 │
│ kubernetes │      150500.0 │         4202 │
│ ruby       │      150000.0 │          736 │
│ node       │      150000.0 │          179 │
│ css        │      150000.0 │          262 │
│ airflow    │      150000.0 │         9996 │
│ redis      │      149000.0 │          605 │
│ vmware     │      148798.3 │          136 │
│ ansible    │      148798.3 │          475 │
│ jupyter    │      147500.0 │          400 │
└────────────┴───────────────┴──────────────┘
*/
