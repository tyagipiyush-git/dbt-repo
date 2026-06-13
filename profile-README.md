<!--
  SETUP
  =====
  1. github.com/new → Repository name: tyagipiyush-git
  2. Add a README → Create
  3. Replace contents with everything below this comment → Commit
-->

# Piyush Tyagi

**Data Engineer** · New Delhi, India

I build **ETL/ELT pipelines** on AWS — ingesting, transforming, and delivering data for analytics and operations. Currently deepening **dbt** and **Databricks** for modern analytics engineering.

[`LinkedIn`](https://www.linkedin.com/in/piyush--tyagi/) · [`Email`](mailto:piyush.del.tyagi@gmail.com) · [`dbt-repo`](https://github.com/tyagipiyush-git/dbt-repo)

---

## Stack

**Languages & compute**
<br>
![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=flat&logo=postgresql&logoColor=white)
![PySpark](https://img.shields.io/badge/PySpark-E25A1C?style=flat&logo=apache-spark&logoColor=white)

**Cloud & orchestration**
<br>
![AWS](https://img.shields.io/badge/AWS-232F3E?style=flat&logo=amazon-aws&logoColor=white)
![Airflow](https://img.shields.io/badge/Airflow-017CEE?style=flat&logo=apache-airflow&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)

**Data platforms**
<br>
![Databricks](https://img.shields.io/badge/Databricks-FF3621?style=flat&logo=databricks&logoColor=white)
![dbt](https://img.shields.io/badge/dbt-FF694B?style=flat&logo=dbt&logoColor=white)
![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=flat&logo=snowflake&logoColor=white)

<details>
<summary><strong>Full toolkit</strong></summary>

| | |
|---|---|
| **Ingestion** | S3 · Lambda · Glue · ECS · FastAPI · GraphQL · Webhooks |
| **Storage** | PostgreSQL · MySQL · Redshift · DynamoDB · Parquet · JSON |
| **Delivery** | Tableau · Power BI · REST APIs |
| **DevOps** | Git · GitHub Actions · CI/CD · CloudWatch |

</details>

---

## How I work

```mermaid
flowchart LR
    A[Sources] --> B[Ingest]
    B --> C[Transform]
    C --> D[Serve]

    A -.- A1[APIs · Files · Shopify]
    B -.- B1[AWS · Lambda · S3]
    C -.- C1[PySpark · SQL · dbt]
    D -.- D1[Warehouse · Dashboards]
```

---

## Projects

### [dbt-repo](https://github.com/tyagipiyush-git/dbt-repo)

**dbt + Databricks · Medallion architecture**

Bronze staging → silver cleansing → gold aggregates. Includes custom macros, generic data tests, Jinja analyses, and layer-by-layer documentation.

```bash
cd dbt_learning && dbt run --select +silver && dbt test
```

### [sql-practice-arena](https://github.com/tyagipiyush-git/sql-practice-arena)

**Interactive SQL practice app** — hands-on query drills and exercises.

---

## Background

| | |
|---|---|
| **Now** | Data Engineer @ Flodata Analytics — real-time ETL, AWS, FastAPI, Shopify integrations |
| **Before** | Data Analyst @ GlobalLogic (Google AI/ML) · Intern @ Dot Communication |
| **Education** | B.Sc. (Hons) Mathematics — University of Delhi |

**Certifications:** HackerRank SQL Gold (5★) · Google Advanced Data Analytics (Coursera) · Trainity Bootcamp — 5th of 200+

<details>
<summary><strong>Currently exploring</strong></summary>

- Gold-layer KPI models in dbt
- CI/CD for dbt with GitHub Actions
- Medallion patterns on Databricks

</details>

---

<p align="left">
  <strong>Open to data engineering & analytics collaborations.</strong><br>
  <a href="https://www.linkedin.com/in/piyush--tyagi/">Connect on LinkedIn →</a>
</p>
