# Business Requirements Document

## 1. Business Objective

Create an interactive content-catalog analytics solution that allows content strategy and programming stakeholders to understand the composition, growth, geographic representation and category mix of the catalog.

## 2. Stakeholders

- Content Strategy Manager
- Content Acquisition Team
- Regional Content Team
- Programming / Editorial Team
- Business Analyst
- Data Analyst
- BI Developer
- Management

## 3. Functional Requirements

1. Show total catalog size.
2. Separate Movies and TV Shows.
3. Analyze catalog additions by month/year.
4. Compare additions across years.
5. Analyze country representation.
6. Analyze category representation.
7. Analyze ratings.
8. Analyze movie duration.
9. Allow filtering by type, rating, country, category and year.
10. Provide title-level detail for investigation.

## 4. Non-Functional Requirements

- Dashboard should load efficiently.
- Metrics must be reproducible in SQL and Power BI.
- Data-quality treatments must be documented.
- The model should support additional catalog records.
- Business definitions must be consistent across Excel, SQL and Power BI.

## 5. Acceptance Criteria

- Total title KPI matches SQL.
- Movie and TV Show counts reconcile with the source after documented cleaning.
- Country/category counts reconcile with relationship tables.
- Date trend uses a proper calendar table.
- Filters cross-filter all relevant visuals.
- Every dashboard visual answers a defined business question.
