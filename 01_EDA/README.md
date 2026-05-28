# 📊 SQL Data Analysis: Remote Data Engineer Job Market

![EDA Project Overview](../images/1_1_Project1_EDA.png)

This project explores the remote Data Engineer job market using real-world job posting data. Through targeted SQL queries, it identifies the most in-demand skills, highest-paying technologies, and the optimal tech stack to learn based on a custom scoring algorithm.

## 🎯 Project Overview

Instead of just looking at basic counts, this analysis queries a relational star schema data warehouse to extract actionable career insights. The project is broken down into three core analytical scripts:

1. [`01_top_demanded_skills.sql`](./01_top_demanded_skills.sql) – **Demand Analysis:** Uses multi-table joins to identify the top 10 most requested skills for remote Data Engineers.
2. [`02_top_paying_skills.sql`](./02_top_paying_skills.sql) – **Salary Trends:** Calculates the median salary for skills. Applies a `HAVING` clause to filter out niche skills (requiring >100 job postings) to find the 25 most lucrative technologies.
3. [`03_optimal_skills.sql`](./03_optimal_skills.sql) – **Value Optimization:** Balances demand and compensation to find the "sweet spot." This query calculates an `optimal_score` by normalizing demand using a natural logarithm (`LN()`) and multiplying it by the median salary.

---

## 📐 Data Architecture & Tech Stack

![Data Warehouse Schema](../images/1_2_Data_Warehouse.png)

The analysis is performed on a **star schema** database using **DuckDB** for fast OLAP queries. 

*   **Fact Table:** `job_postings_fact` (salaries, job titles, remote status)
*   **Dimension Table:** `skills_dim` (skill names)
*   **Bridge Table:** `skills_job_dim` (resolves the many-to-many relationship between postings and skills)

---

## 💻 SQL Techniques Utilized

This project demonstrates proficiency in writing production-ready, analytical SQL, including:

*   **Complex Joins:** Utilizing multiple `INNER JOIN` operations to connect facts and dimensions through a bridge table.
*   **Statistical Aggregations:** Using `MEDIAN()` for accurate salary representation (avoiding skew from outliers) alongside `COUNT()`.
*   **Mathematical Transformations:** Applying logarithmic scaling (`LN()`) and arithmetic operations to create derived metrics (`optimal_score`).
*   **Advanced Filtering:** Combining standard `WHERE` conditions (boolean flags, `IS NOT NULL`) with `HAVING` clauses to establish baseline sample sizes.

---

## 📂 Repository Structure

```text
1_EDA/
├── 01_top_demanded_skills.sql    
├── 02_top_paying_skills.sql      
├── 03_optimal_skills.sql         
└── README.md