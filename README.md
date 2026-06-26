# CI/CD Data Contract Enforcer

**Automated schema validation and continuous integration for analytical data pipelines.**

This repository demonstrates a production-grade CI/CD pipeline that treats data as a reliable product. By shifting data quality checks to the build phase, it prevents unannounced upstream schema changes from silently breaking downstream ML models and executive dashboards.

---

## The Business Problem

In modern data architectures, upstream software engineers frequently alter database schemas—renaming columns, changing data types, or dropping fields—without notifying the data team. When these changes flow into the data warehouse unchecked, they cause:
* Downstream dashboard failures and corrupted business intelligence metrics.
* Expensive engineering hours diverted to emergency pipeline debugging.
* Degradation of stakeholder trust in data reliability.

## The Solution

This project implements a preventative gatekeeper using dbt data contracts and GitHub Actions. Instead of finding out data is broken after it hits production, this workflow intercepts invalid schema changes at the pull request level. If the incoming data structure violates the pre-defined YAML contract, the CI/CD runner blocks the merge.

## Architecture & Workflow

The enforcement mechanism operates through a strict agreement between data producers and data consumers:

1. **Schema Definition (`stg_orders.yml`):** Strict YAML configurations define the exact column names, data types, and constraints required for all downstream analytical models.
2. **Automated CI/CD Runner:** Upon opening a Pull Request to the main branch, GitHub Actions provisions a sterile virtual environment.
3. **Isolated Testing:** The runner securely authenticates with Snowflake, builds a temporary staging schema, and executes `dbt run`.
4. **Validation & Enforcement:** dbt evaluates the incoming data against the contract. If a violation is detected (e.g., a required column was renamed upstream), the build fails with a non-zero exit code, and GitHub automatically locks the pull request.

## Tech Stack

* **Data Transformation & Contracts:** dbt (Data Build Tool)
* **Cloud Data Warehouse:** Snowflake
* **CI/CD Orchestration:** GitHub Actions
* **Languages:** SQL, YAML, Python

---

## Local Setup & Testing

To replicate this environment or run the contracts locally:

**1. Clone and Initialize**
```bash
git clone [https://github.com/aymannassri/data-contract-enforcer.git](https://github.com/aymannassri/data-contract-enforcer.git)
cd data-contract-enforcer
python -m venv venv
source venv/bin/activate  # On Windows: .\venv\Scripts\activate
pip install dbt-snowflake
```

**2. Configure Profile**
Update your `~/.dbt/profiles.yml` with your specific Snowflake credentials, targeting the `SYSADMIN` role.

**3. Run the Pipeline**
```bash
dbt debug
dbt run
```

---

*Designed and engineered by **Ayman Nassri** — Data Engineer*
[View my Malt Profile](https://www.malt.fr/profile/aymannassri)