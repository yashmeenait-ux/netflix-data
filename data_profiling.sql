USE NetflixContentAnalytics;
GO

-- 1. Row count and duplicate IDs
SELECT COUNT(*) AS total_titles FROM FactTitles;
SELECT show_id, COUNT(*) AS duplicate_count
FROM FactTitles GROUP BY show_id HAVING COUNT(*) > 1;

-- 2. Missing values
SELECT
    SUM(CASE WHEN title IS NULL THEN 1 ELSE 0 END) AS missing_title,
    SUM(CASE WHEN type IS NULL THEN 1 ELSE 0 END) AS missing_type,
    SUM(CASE WHEN date_added IS NULL THEN 1 ELSE 0 END) AS missing_date_added,
    SUM(CASE WHEN release_year IS NULL THEN 1 ELSE 0 END) AS missing_release_year,
    SUM(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) AS missing_rating,
    SUM(CASE WHEN duration_minutes IS NULL THEN 1 ELSE 0 END) AS missing_movie_duration
FROM FactTitles;

-- 3. Unexpected content types
SELECT DISTINCT type FROM FactTitles ORDER BY type;

-- 4. Invalid numeric values
SELECT * FROM FactTitles
WHERE release_year < 1900 OR duration_minutes < 0 OR duration_seasons < 0;

-- 5. Orphan relationship rows
SELECT COUNT(*) AS orphan_countries
FROM BridgeCountry c LEFT JOIN FactTitles t ON t.show_id = c.show_id
WHERE t.show_id IS NULL;

SELECT COUNT(*) AS orphan_categories
FROM BridgeCategory c LEFT JOIN FactTitles t ON t.show_id = c.show_id
WHERE t.show_id IS NULL;

-- 6. Multi-valued relationship duplicates
SELECT show_id, country, COUNT(*) AS row_count
FROM BridgeCountry GROUP BY show_id, country HAVING COUNT(*) > 1;

SELECT show_id, category, COUNT(*) AS row_count
FROM BridgeCategory GROUP BY show_id, category HAVING COUNT(*) > 1;
