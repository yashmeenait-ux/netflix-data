# Data Dictionary

## netflix_titles / FactTitles

| Field | Meaning |
|---|---|
| show_id | Unique title identifier |
| type | Movie or TV Show |
| title | Title name |
| date_added | Date added to catalog |
| release_year | Original release year |
| rating | Content rating |
| duration_minutes | Movie duration where applicable |
| duration_seasons | TV season count where applicable |
| description | Title description |

## Relationship tables

- `netflix_titles_directors`: show_id, director
- `netflix_titles_countries`: show_id, country
- `netflix_titles_cast`: show_id, cast
- `netflix_titles_category`: show_id, listed_in
