CREATE TABLE t_david_stefanik_project_sql_primary_final AS
SELECT
    p.payroll_year AS year,
    p.industry_branch_code,
    ib.name AS industry_branch_name,
    AVG(p.value) AS avg_wage
FROM
    czechia_payroll p
    JOIN czechia_payroll_industry_branch ib ON p.industry_branch_code = ib.code
WHERE
    p.value_type_code = '5958' -- průměrná mzda
GROUP BY
    p.payroll_year, p.industry_branch_code, ib.name
ORDER BY
    p.payroll_year, ib.name;