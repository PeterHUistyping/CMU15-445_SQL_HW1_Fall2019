WITH types(type, runtime_minutes) AS ( 
  SELECT type, MAX(runtime_minutes)
    FROM titles
    GROUP BY type
)
SELECT titles.type, titles.primary_title, titles.runtime_minutes
  FROM titles
  JOIN types  --titles ⋈ types
  ON titles.runtime_minutes == types.runtime_minutes AND titles.type == types.type
  ORDER BY titles.type, titles.primary_title
  ;
