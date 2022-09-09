SELECT type, COUNT(PRIMARY_title) AS title_count
From titles
GROUP BY type
ORDER BY COUNT(PRIMARY_title);


-- SOL
SELECT type, count(*) AS title_count
 FROM titles 
 GROUP BY type 
 ORDER BY title_count ASC;
