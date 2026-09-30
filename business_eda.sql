USE NetflixContentAnalytics;
GO

-- 1. Catalog size
SELECT COUNT(DISTINCT show_id) AS total_titles FROM FactTitles;

-- 2. Movie vs TV Show mix
SELECT type, COUNT(DISTINCT show_id) AS titles,
       CAST(COUNT(DISTINCT show_id) * 100.0 / SUM(COUNT(DISTINCT show_id)) OVER() AS DECIMAL(6,2)) AS share_pct
FROM FactTitles
GROUP BY type ORDER BY titles DESC;

-- 3. Titles added by year
SELECT added_year, COUNT(*) AS titles_added
FROM FactTitles WHERE added_year IS NOT NULL
GROUP BY added_year ORDER BY added_year;

-- 4. Monthly additions
SELECT YEAR(date_added) AS add_year, MONTH(date_added) AS add_month,
       COUNT(*) AS titles_added
FROM FactTitles WHERE date_added IS NOT NULL
GROUP BY YEAR(date_added), MONTH(date_added)
ORDER BY add_year, add_month;

-- 5. YoY catalog additions
WITH yearly AS (
    SELECT added_year, COUNT(*) AS titles_added
    FROM FactTitles
    WHERE added_year IS NOT NULL
    GROUP BY added_year
)
SELECT added_year, titles_added,
       LAG(titles_added) OVER(ORDER BY added_year) AS previous_year,
       CAST((titles_added - LAG(titles_added) OVER(ORDER BY added_year)) * 100.0 /
            NULLIF(LAG(titles_added) OVER(ORDER BY added_year),0) AS DECIMAL(8,2)) AS yoy_growth_pct
FROM yearly ORDER BY added_year;

-- 6. Top countries
SELECT TOP 20 country, COUNT(DISTINCT show_id) AS titles
FROM BridgeCountry
GROUP BY country ORDER BY titles DESC;

-- 7. Top categories
SELECT TOP 20 category, COUNT(DISTINCT show_id) AS titles
FROM BridgeCategory
GROUP BY category ORDER BY titles DESC;

-- 8. Ratings
SELECT rating, COUNT(*) AS titles
FROM FactTitles WHERE rating IS NOT NULL
GROUP BY rating ORDER BY titles DESC;

-- 9. Average movie duration
SELECT CAST(AVG(CAST(duration_minutes AS FLOAT)) AS DECIMAL(10,2)) AS avg_movie_duration
FROM FactTitles WHERE type = 'Movie' AND duration_minutes IS NOT NULL;

-- 10. Duration buckets
SELECT duration_bucket, COUNT(*) AS movies
FROM FactTitles WHERE type = 'Movie'
GROUP BY duration_bucket ORDER BY movies DESC;

-- 11. Countries by content type
SELECT TOP 20 c.country,
       COUNT(DISTINCT CASE WHEN t.type='Movie' THEN t.show_id END) AS movies,
       COUNT(DISTINCT CASE WHEN t.type='TV Show' THEN t.show_id END) AS tv_shows
FROM BridgeCountry c
JOIN FactTitles t ON t.show_id=c.show_id
GROUP BY c.country
ORDER BY movies + tv_shows DESC;

-- 12. Categories by content type
SELECT t.type, c.category, COUNT(DISTINCT t.show_id) AS titles
FROM FactTitles t
JOIN BridgeCategory c ON c.show_id=t.show_id
GROUP BY t.type, c.category
ORDER BY t.type, titles DESC;

-- 13. Directors with most titles
SELECT TOP 20 director, COUNT(DISTINCT show_id) AS titles
FROM BridgeDirector
GROUP BY director ORDER BY titles DESC;

-- 14. Titles with three or more categories
SELECT TOP 20 t.title, COUNT(*) AS category_count
FROM FactTitles t
JOIN BridgeCategory c ON c.show_id=t.show_id
GROUP BY t.show_id, t.title
HAVING COUNT(*) >= 3
ORDER BY category_count DESC, t.title;

-- 15. Release year mix
SELECT release_year, type, COUNT(*) AS titles
FROM FactTitles
WHERE release_year IS NOT NULL
GROUP BY release_year, type
ORDER BY release_year, type;
