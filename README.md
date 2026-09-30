# Netflix Content Strategy & Catalog Analysis

End-to-End Business Analytics Project

**Python • SQL • Excel • Power BI • Business Intelligence**

## Business Objective
Analyze Netflix catalog metadata to understand content composition, catalog additions, geographic representation, category mix, ratings, and movie duration.

> The supplied dataset does not contain revenue, subscribers, viewing hours, content cost, profit, or customer behavior. This project therefore focuses on catalog metadata.

## Repository Structure
```text
Netflix-Content-Strategy-Analytics/
├── data/
│   ├── raw/
│   └── processed/
├── images/
├── index.html
├── Netflix_Business_Analysis_Report.xlsx
├── netflix_etl.py
├── database_schema.sql
├── data_profiling.sql
├── business_eda.sql
├── DAX_MEASURES.md
├── POWER_BI_BUILD_GUIDE.md
├── DATA_DICTIONARY.md
├── BUSINESS_REQUIREMENTS.md
├── BUSINESS_ANALYSIS_REPORT.md
├── INTERVIEW_PREP.md
├── README.md
└── .gitignore
```

## Dashboard
Open `index.html` in a browser.

## Python ETL
```powershell
python -m pip install pandas openpyxl
python netflix_etl.py
```

## Power BI
Use `POWER_BI_BUILD_GUIDE.md` and `DAX_MEASURES.md` to build the Power BI version. A `.pbix` file is not included until the dashboard is created and saved in Power BI Desktop.

## Project Workflow
Python ETL → SQL profiling/EDA → Excel reporting → Power BI dashboard → business insights.
