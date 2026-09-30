# Power BI Build Guide

## 1. Import

Load the processed CSVs from `data/processed/`:

- titles.csv
- countries.csv
- categories.csv
- directors.csv
- cast.csv

## 2. Model

Use `titles` as the central title table. Create one-to-many relationships from `titles[show_id]` to each bridge table. For date analysis, create a dedicated `DimDate` table and relate `DimDate[Date]` to `titles[date_added]`.

For category/country slicers, bridge tables are multi-valued. Keep filter direction controlled to avoid ambiguous relationship paths.

## 3. Theme

Use a clean executive BI layout:

- Dark or neutral background
- One accent color
- KPI cards at top
- 4–6 visuals per page
- Consistent slicers
- Minimal decorative elements

## 4. Validation

Before presenting the dashboard, compare KPI values with `sql/03_business_eda.sql` outputs.

## 5. Five-page report

1. Executive Dashboard
2. Content Growth
3. Geography
4. Category & Format
5. Catalog Explorer
