SELECT
CAST(premiered/10*10 AS TEXT) || 's' AS Decade,
COUNT(*) AS title_count
From titles
WHERE premiered>=0
GROUP BY Decade
ORDER BY title_count DESC;

WITH total_titles(type) AS (
SELECT COUNT(*) AS type 
From titles
)

SELECT
CAST(premiered/10*10 AS TEXT) || 's' AS Decade,
ROUND(CAST(COUNT(*)AS REAL)/total_titles.type*100, 4) AS percentage
From titles,total_titles
WHERE premiered>=0
GROUP BY Decade
ORDER BY percentage DESC;


SELECT
CAST(premiered/10*10 AS TEXT) || 's' AS Decade,
ROUND(CAST(COUNT(*)AS REAL)/(SELECT COUNT(*)  From titles) *100, 4) AS percentage   --REAL/ INT
From titles
WHERE premiered>=0
GROUP BY Decade
ORDER BY Decade DESC;
