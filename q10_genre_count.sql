SELECT primary_title,genres
FROM titles
GROUP BY genres
--debug
WITH RECURSIVE single (genre,rest)AS
(
 SELECT 
  iif(instr(genres, ',')==0,substr(genres, 0),substr(genres, 0, instr(genres, ',') )  )
  ,iif(instr(genres, ',')==0,'',substr(genres, instr(genres, ',')+1)  )
   FROM titles WHERE genres != "\N"
)    
 SELECT
    iif(instr(rest, ',')==0,substr(rest,0),substr(rest, 0, instr(rest, ',') )   )
  ,iif(instr(rest, ',')==0,'',substr(rest, instr(rest, ',')+1)   )
    FROM single
    WHERE rest != '' AND rest!=','
--
WITH RECURSIVE single (genre,rest)AS
(
 SELECT 
  iif(instr(genres, ',')==0,substr(genres, 0),substr(genres, 0, instr(genres, ',') )  )
  ,iif(instr(genres, ',')==0,'',substr(genres, instr(genres, ',')+1)  )
   FROM titles WHERE genres != "\N"
    UNION ALL 
 SELECT
    iif(instr(rest, ',')==0,substr(rest,0),substr(rest, 0, instr(rest, ',') )   )
  ,iif(instr(rest, ',')==0,'',substr(rest, instr(rest, ',')+1)   )
    FROM single 
    WHERE rest != ''
)

SELECT genre, count(*) as genre_count
  FROM single
 GROUP BY genre
 ORDER BY genre_count DESC;
 

--SOL
--two columns
WITH RECURSIVE split(genre, rest) AS 
(  
  SELECT '', genres || ',' FROM titles WHERE genres != "\N"
   UNION ALL
  SELECT substr(rest, 0, instr(rest, ',')), --returns the byte position
         substr(rest, instr(rest, ',')+1)
    FROM split
   WHERE rest != ''
)


SELECT genre, count(*) as genre_count
  FROM split 
 WHERE genre != ''
 GROUP BY genre
 ORDER BY genre_count DESC;

-- test for IFF / CASE From online Document

WITH RECURSIVE split(genre, rest) AS --two columns
(  
  SELECT '', genres || ',' FROM titles WHERE genres != "\N"
   UNION ALL
  SELECT 
  --iif(instr(rest, ',')==0,substr(rest, 0, instr(rest, '\N')),substr(rest, 0, instr(rest, ',')))
    CASE WHEN instr(rest, ',')==0 THEN substr(rest, 0, instr(rest, '\N')) ELSE substr(rest, 0, instr(rest, ','))END
,substr(rest, instr(rest, ',')+1)
    FROM split
   WHERE rest != ''
)


SELECT genre, count(*) as genre_count
  FROM split 
 WHERE genre != ''
 GROUP BY genre
 ORDER BY genre_count DESC;

