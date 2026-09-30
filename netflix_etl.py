from pathlib import Path
import pandas as pd
import numpy as np

ROOT = Path(__file__).resolve().parents[1]
RAW = ROOT / 'data' / 'raw' / 'netflix_titles.xlsx'
OUT = ROOT / 'data' / 'processed'
OUT.mkdir(parents=True, exist_ok=True)


def main():
    titles = pd.read_excel(RAW, sheet_name='netflix_titles')
    directors = pd.read_excel(RAW, sheet_name='netflix_titles_directors')
    countries = pd.read_excel(RAW, sheet_name='netflix_titles_countries')
    cast = pd.read_excel(RAW, sheet_name='netflix_titles_cast')
    categories = pd.read_excel(RAW, sheet_name='netflix_titles_category')

    frames = [titles, directors, countries, cast, categories]
    for df in frames:
        df.columns = [str(c).strip().lower() for c in df.columns]

    titles['show_id'] = pd.to_numeric(titles['show_id'], errors='coerce')
    titles['release_year'] = pd.to_numeric(titles['release_year'], errors='coerce')
    titles['date_added'] = pd.to_datetime(titles['date_added'], errors='coerce')
    titles['duration_minutes'] = pd.to_numeric(titles['duration_minutes'], errors='coerce')
    titles['duration_seasons'] = pd.to_numeric(titles['duration_seasons'], errors='coerce')

    titles = titles.drop_duplicates('show_id').dropna(subset=['show_id', 'title']).copy()
    titles['show_id'] = titles['show_id'].astype(int)
    titles['added_year'] = titles['date_added'].dt.year
    titles['added_month'] = titles['date_added'].dt.month
    titles['added_month_name'] = titles['date_added'].dt.month_name()
    titles['content_age_years'] = np.where(
        titles['release_year'].notna() & titles['added_year'].notna(),
        titles['added_year'] - titles['release_year'], np.nan)
    titles['duration_bucket'] = pd.cut(
        titles['duration_minutes'],
        bins=[0, 60, 90, 120, 180, np.inf],
        labels=['≤60 min', '61–90 min', '91–120 min', '121–180 min', '180+ min'],
        include_lowest=True)

    relationship_specs = [
        (directors, 'director', 'directors.csv'),
        (countries, 'country', 'countries.csv'),
        (cast, 'cast', 'cast.csv'),
        (categories, 'listed_in', 'categories.csv')]

    titles.to_csv(OUT / 'titles.csv', index=False)
    valid_ids = set(titles['show_id'])
    for df, col, filename in relationship_specs:
        df['show_id'] = pd.to_numeric(df['show_id'], errors='coerce')
        df = df.dropna(subset=['show_id', col]).drop_duplicates()
        df['show_id'] = df['show_id'].astype(int)
        df = df[df['show_id'].isin(valid_ids)]
        df.to_csv(OUT / filename, index=False)

    print(f'ETL complete. Clean titles: {len(titles):,}')


if __name__ == '__main__':
    main()
