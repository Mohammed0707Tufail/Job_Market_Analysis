# Job Market Analysis (India)
Job market analysis using Adzuna API, Python, SQL Server and Power BI

Analysis of Data Analyst, Business Analyst, Data Scientist and Power BI Developer job postings across 5 Indian cities, using live data from the Adzuna API.

## Tools
Python (Pandas, Requests), Adzuna API, SQL Server, Power BI (dashboard coming soon)

## Project steps
1. **Data collection** (`01_Data Collection.py`): collected 3,563 job postings across 5 cities (Mumbai, Pune, Bangalore, Noida, Gurgaon) and 4 roles.
2. **Data cleaning** (`02_Data Cleaning.ipynb`): removed duplicates, handled missing values, fixed text formatting, and checked salary outliers. Result: 3,443 clean records.
3. **SQL analysis** (`03_SQL_Analysis.sql`): analyzed postings and salaries by role and city, top hiring companies, and top city per role using CTE and window functions.
4. **Dashboard:** Power BI dashboard (in progress).

## Key findings
- Data Scientist roles were 36% of all postings, with an average salary of about 16.2 LPA
- Business Analyst was 32% of postings, Data Analyst 25%, and Power BI Developer 7.5%
- Bangalore had the most postings (991), followed by Pune (861) and Mumbai (805)
- EXL was the top hiring company with 140 postings, followed by Amazon (57)

## Data files
- `Jobs_Old.csv`: raw data collected from the API
- `04_Jobs_Cleaned.csv`: cleaned data used for the analysis

## Notes and limitations
- Only about 21% of postings disclosed a salary, so salary figures are based on that smaller group.
- Some postings have a minimum salary of 0, which lowers the averages slightly.
- To run the collection script, get a free API key from Adzuna and replace YOUR_APP_ID and YOUR_APP_KEY in the script.
