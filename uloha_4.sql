WITH avg_wage AS (
    SELECT
        payroll_year AS year,
        AVG(value) AS avg_wage
    FROM czechia_payroll
    WHERE value_type_code = '5958'
    GROUP BY payroll_year
),
wage_growth AS (
    SELECT 
        a.year,
        ((a.avg_wage - b.avg_wage) / b.avg_wage) * 100 AS wage_growth_percent
    FROM avg_wage a
    JOIN avg_wage b ON a.year = b.year + 1
),
food_price AS (
    SELECT
        EXTRACT(YEAR FROM date_from) AS year,
        AVG(value) AS avg_food_price
    FROM czechia_price
    WHERE category_code IN (
        '111101', '111201', '111301', '111401', '111602', '112101', '112201', '112401',
        '113301', '114201', '114101', '115101', '115201', '115401', '116101', '116201',
        '116301', '116401', '116501', '117101', '117201', '117401', '121101', '212101',
        '213101', '215001', '200001'
    )
    GROUP BY EXTRACT(YEAR FROM date_from)
),
food_growth AS (
    SELECT 
        a.year,
        ((a.avg_food_price - b.avg_food_price) / b.avg_food_price) * 100 AS food_growth_percent
    FROM food_price a
    JOIN food_price b ON a.year = b.year + 1
)
SELECT 
    f.year,
    ROUND(f.food_growth_percent::numeric, 2) AS food_growth_percent,
    ROUND(w.wage_growth_percent::numeric, 2) AS wage_growth_percent,
    ROUND((f.food_growth_percent - w.wage_growth_percent)::numeric, 2) AS difference_percent
FROM food_growth f
JOIN wage_growth w ON f.year = w.year
WHERE (f.food_growth_percent - w.wage_growth_percent) > 10
ORDER BY f.year;
