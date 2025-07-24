WITH wage_history AS (
    SELECT 
        industry_branch_code,
        industry_branch_name,
        year,
        avg_wage,
        LAG(avg_wage) OVER (PARTITION BY industry_branch_code ORDER BY year) AS prev_year_wage
    FROM 
        t_david_stefanik_project_sql_primary_final
)
SELECT 
    industry_branch_code,
    industry_branch_name,
    year,
    avg_wage,
    prev_year_wage,
    avg_wage - prev_year_wage AS wage_diff,
    CASE 
        WHEN prev_year_wage IS NULL THEN 'N/A'
        WHEN avg_wage > prev_year_wage THEN 'Increase'
        WHEN avg_wage < prev_year_wage THEN 'Decrease'
        ELSE 'No change'
    END AS wage_trend
FROM wage_history
ORDER BY industry_branch_code, year;
