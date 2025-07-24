WITH avg_wage_by_year AS (
    SELECT
        year,
        AVG(avg_wage) AS avg_wage
    FROM t_david_stefanik_project_sql_primary_final
    GROUP BY year
),
bread_price AS (
    SELECT
        EXTRACT(YEAR FROM p.date_from) AS year,
        AVG(p.value) AS bread_price
    FROM czechia_price p
    JOIN czechia_price_category c ON p.category_code = c.code
    WHERE c.code = '111301' -- Chléb konzumní kmínový
    GROUP BY year
),
milk_price AS (
    SELECT
        EXTRACT(YEAR FROM p.date_from) AS year,
        AVG(p.value) AS milk_price
    FROM czechia_price p
    JOIN czechia_price_category c ON p.category_code = c.code
    WHERE c.code = '114201' -- Mléko polotučné pasterované
    GROUP BY year
),
combined AS (
    SELECT
        w.year,
        w.avg_wage,
        m.milk_price,
        b.bread_price,
        (w.avg_wage / m.milk_price) AS liters_of_milk,
        (w.avg_wage / b.bread_price) AS kilos_of_bread
    FROM avg_wage_by_year w
    JOIN milk_price m ON w.year = m.year
    JOIN bread_price b ON w.year = b.year
),
years_to_compare AS (
    SELECT *
    FROM combined
    WHERE year IN (
        (SELECT MIN(year) FROM combined),
        (SELECT MAX(year) FROM combined)
    )
)
SELECT
    year,
    ROUND(avg_wage::numeric, 2) AS avg_wage_czk,
    ROUND(milk_price::numeric, 2) AS milk_price_czk,     -- nyní opravdu cena mléka
    ROUND(liters_of_milk::numeric, 0) AS liters_of_milk,
    ROUND(bread_price::numeric, 2) AS bread_price_czk,   -- nyní opravdu cena chleba
    ROUND(kilos_of_bread::numeric, 0) AS kilos_of_bread
FROM years_to_compare
ORDER BY year;
