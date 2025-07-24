WITH yearly_prices AS (
    SELECT 
        pc.name AS category_name,
        EXTRACT(YEAR FROM p.date_from) AS year,
        AVG(p.value) AS avg_price
    FROM 
        czechia_price p
        JOIN czechia_price_category pc ON p.category_code = pc.code
    GROUP BY 
        pc.name, EXTRACT(YEAR FROM p.date_from)
),
price_changes AS (
    SELECT 
        p1.category_name,
        p1.year,
        ((p1.avg_price - p0.avg_price) / p0.avg_price) * 100 AS yoy_increase_percent
    FROM 
        yearly_prices p1
        JOIN yearly_prices p0 
            ON p1.category_name = p0.category_name AND p1.year = p0.year + 1
),
avg_growth_by_category AS (
    SELECT 
        category_name,
        AVG(yoy_increase_percent) AS avg_yoy_growth_percent
    FROM 
        price_changes
    GROUP BY 
        category_name
)
SELECT 
    category_name,
    avg_yoy_growth_percent
FROM 
    avg_growth_by_category
ORDER BY 
    avg_yoy_growth_percent ASC
LIMIT 1;
