WITH wage_changes AS (
    SELECT
        year,
        AVG(avg_wage) AS avg_wage
    FROM t_david_stefanik_project_sql_primary_final
    GROUP BY year
),
wage_diff AS (
    SELECT
        w1.year,
        (w1.avg_wage - w0.avg_wage) / w0.avg_wage AS wage_growth
    FROM wage_changes w1
    JOIN wage_changes w0 ON w1.year = w0.year + 1
),
gdp_changes AS (
    SELECT
        year,
        gdp
    FROM t_david_stefanik_project_sql_secondary_final
    WHERE country_code = 'CZE'
),
gdp_diff AS (
    SELECT
        g1.year,
        (g1.gdp - g0.gdp) / g0.gdp AS gdp_growth
    FROM gdp_changes g1
    JOIN gdp_changes g0 ON g1.year = g0.year + 1
),
food_prices AS (
    SELECT
        EXTRACT(YEAR FROM date_from) AS year,
        category_code,
        AVG(value) AS avg_price
    FROM czechia_price
    WHERE category_code IN (
        111101, 111201, 111301, 111602, 112101, 112401, 113301, 114201, 114101,
        114401, 115101, 115201, 115102, 116101, 116102, 116201, 117101, 117401,
        118100, 212101, 212201, 2000001
    )
    GROUP BY EXTRACT(YEAR FROM date_from), category_code
),
price_diff AS (
    SELECT
        p1.year,
        p1.category_code,
        (p1.avg_price - p0.avg_price) / p0.avg_price AS price_growth
    FROM food_prices p1
    JOIN food_prices p0 ON p1.year = p0.year + 1 AND p1.category_code = p0.category_code
)
SELECT
    gdp_diff.year,
    ROUND(gdp_growth::numeric, 2) AS gdp_growth_pct,
    ROUND(wage_growth::numeric, 2) AS wage_growth_pct,
    price_diff.category_code,
    ROUND(price_diff.price_growth::numeric, 2) AS food_price_growth_pct
FROM gdp_diff
LEFT JOIN wage_diff ON gdp_diff.year = wage_diff.year
LEFT JOIN price_diff ON gdp_diff.year = price_diff.year
ORDER BY gdp_diff.year, price_diff.category_code;
