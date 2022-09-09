With ak(title_id,title) AS(
SELECT title_id, COUNT(title)  --AS
FROM akas
GROUP BY title_id
)
SELECT primary_title,title
FROM titles,ak
WHERE ak.title_id==titles.title_id
ORDER BY title DESC
LIMIT 10
;

--SOL
WITH translations AS (
  SELECT title_id, count(*) as num_translations 
    FROM akas 
    GROUP BY title_id 
    ORDER BY num_translations DESC, title_id 
    LIMIT 10
)
SELECT titles.primary_title, translations.num_translations
  FROM translations
  JOIN titles
  ON titles.title_id == translations.title_id
  ORDER BY translations.num_translations DESC
  ;
