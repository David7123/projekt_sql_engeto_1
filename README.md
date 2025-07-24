# Datová analýza - Projekt z SQL

## Průvodní listina 

1. Popis projektu

Projekt se zaměřuje na analýzu životní úrovně obyvatelstva skrze srovnání dostupnosti základních potravin v České republice, a to s ohledem na průměrné příjmy jednotlivých odvětví v čase. V rámci tohoto projektu je cílem odpovědět na několik klíčových výzkumných otázek týkajících se toho, jaký je vývoj mezd, jaká je dostupnost vybraných potravin (například chleba a mléka) a zda se tyto ukazatele zlepšují nebo zhoršují. Projekt doplňuje také srovnání se zeměmi Evropy – především porovnání makroekonomických ukazatelů, jako jsou HDP, GINI koeficient a populace ve stejném období.

Analýza je připravena jako podklad pro tiskové oddělení k prezentaci na konferenci, která se věnuje problematice životní úrovně v Evropě. Výsledná datová sada umožní komplexní pohled na vývoj reálné kupní síly v rámci ČR a poskytne evropský kontext prostřednictvím ekonomických ukazatelů.

2. Popis tvorby primární tabulky

Primární tabulka shrnuje vývoj průměrných mezd v jednotlivých odvětvích České republiky za sledované roky. Jejím účelem je umožnit analýzu, jak se mění průměrné mzdy podle odvětví a jaký to má vliv na dostupnost základních potravin pro obyvatele.

Použité zdroje:

· czechia_payroll – údaje o mzdách v jednotlivých odvětvích za sledované období.

· czechia_payroll_industry_branch – číselník s názvy odvětví.

Vytvoření tabulky:

· Z tabulky czechia_payroll jsou vybírána data s typem hodnoty odpovídajícím „průměrné mzdě“ (value_type_code = '5958').

· Data jsou spojena s číselníkem odvětví pro získání jména odvětví.

· Pomocí agregační funkce je počítán průměr mzdy za odvětví a rok.

· Výsledek obsahuje sloupce: rok, kód odvětví, název odvětví a průměrná mzda.

3. Popis tvorby sekundární tabulky

Sekundární tabulka rozšiřuje analýzu o evropský kontext. Obsahuje klíčové makroekonomické údaje (HDP, GINI koeficient a populaci) evropských států za stejné období, které je pokryto v primární tabulce. Umožňuje rovněž srovnání situace v ČR s ostatními evropskými zeměmi.

Použité zdroje:

· countries – databáze základních údajů o státech, včetně zařazení do kontinentu.

· economies – makroekonomické ukazatele dle státu a roku.

Vytvoření tabulky:

· Výběr je omezen pouze na státy Evropy.

· Jsou vybírány státy obsahující stejná časová období jako u primární tabulky (shoda podle roku).

· Tabulka obsahuje sloupce: kód a název státu, rok, HDP, GINI koeficient a populaci.

### Odpovědi na výzkumné otázky

1. první otázka

Dle analýzy pomocí sql dotazu ve všech odvětvích mzdy v průběhu let nerostou, naopak v některých klesají či nemají meziroční nárůst, například administrativní a podpůrné činnosti, pohostinství, zemědělství, lesnictví. V některých případech nelze porovnat ( chybí například předchozí rok ).

2. druhá otázka

Odpověď na druhou otázku, kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd zní, že v roce 2006 při průměrné mzdě 20753,78 Kč a ceně mléka 14,44 Kč, by to činilo 1437 litrů a v roce 2008, při průměrné mzdě 32535,86 a ceně mléka 19,82 Kč, by to činilo 1982 litrů.
Co se týká chleba, tak při té samé průměrné mzdě v roce 2006 a ceně chleba 16,12 Kč, by to činilo 1287 kg. V roce 2018, při té samé průměrné mzdě a ceně chleba 24,24 Kč, by to činilo 1342 kg.

3. třetí otázka

Cílem této analýzy bylo identifikovat kategorii potravin s nejnižším průměrným meziročním procentuálním nárůstem cen. Dle výsledné tabulky, vykazuje nejnižší cenovou volatilitu cukr krystalový s průměrnou meziroční procentní změnou -1,92 %, zaokrouhleno nahoru.

4. čtvrtá otázka

Jelikož je výsledek v tabulce prázdný, nebyl nikdy meziroční růst cen potravin vyšší o 10% než růst mezd.

5. pátá otázka

Ano, data potvrzují, že výraznější HDP vede k růstu mezd ve stejném nebo následujícím roce. Vliv HDP na ceny potravin je také patrný, hlavně rostou výrazněji v období vyššího hospodářského růstu. Avšak cenové změny potravin jsou oproti mzdám volatilnější a ovlivněné i dalšími faktory.   
Takže závěr je, že mezi vývojem HDP a mzdami je zjevná přímá souvislost, růst HDP může přinést růst mezd. Vliv na ceny potravin existuje rovněž, ale je méně výrazný.
