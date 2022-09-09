SELECT premiered, COUNT(*) AS title_count
From titles
--WHERE premiered != NULL --wrong <>
WHERE premiered >=0
GROUP BY premiered 
ORDER BY title_count DESC;

--SOL
SELECT 
  CAST(premiered/10*10 AS TEXT) || 's' AS decade, --concatenate
  COUNT(*) AS num_movies
  FROM titles
  WHERE premiered is not null
  GROUP BY decade
  ORDER BY num_movies DESC
  ;
