CREATE TABLE t_david_stefanik_project_SQL_secondary_final AS
SELECT
    c.iso3 AS country_code,
    c.country AS country_name,
    e.year,
    e.gdp,
    e.gini,
    e.population
FROM
    countries c
    JOIN economies e ON c.country = e.country
WHERE
    c.continent = 'Europe'
    AND e.year IN (SELECT DISTINCT year FROM t_david_stefanik_project_sql_primary_final)
ORDER BY
    c.country, e.year;