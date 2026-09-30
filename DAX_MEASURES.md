# DAX Measures

```DAX
Total Titles = DISTINCTCOUNT(titles[show_id])

Movies = CALCULATE([Total Titles], titles[type] = "Movie")

TV Shows = CALCULATE([Total Titles], titles[type] = "TV Show")

Movie Share % = DIVIDE([Movies], [Total Titles])

TV Show Share % = DIVIDE([TV Shows], [Total Titles])

Average Movie Duration =
CALCULATE(
    AVERAGE(titles[duration_minutes]),
    titles[type] = "Movie"
)

Titles Added =
CALCULATE(
    [Total Titles],
    NOT ISBLANK(titles[date_added])
)

Previous Year Titles Added =
CALCULATE(
    [Titles Added],
    DATEADD(DimDate[Date], -1, YEAR)
)

YoY Additions Growth % =
DIVIDE(
    [Titles Added] - [Previous Year Titles Added],
    [Previous Year Titles Added]
)
```
