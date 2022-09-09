--extra one column
SELECT type ,primary_title,MAX(length(primary_title)),runtime_minutes
From titles  
GROUP BY type;

-- single 1
SELECT type,primary_title,runtime_minutes
From titles 
--WHERE primary_title=MAX(length(primary_title))
WHERE primary_title IN (
        SELECT  primary_title  
        FROM titles 
        order by length(primary_title) desc --all group
        limit 1)
GROUP BY type;

-- ->mult
SELECT type,primary_title,runtime_minutes
From titles 
--WHERE primary_title=MAX(length(primary_title))
WHERE primary_title IN (
        SELECT  primary_title  
        FROM titles 
        GROUP BY type  --each group
        order by length(primary_title) desc 
        )
GROUP BY type;

--single 2
SELECT type,primary_title,runtime_minutes
From titles 
--WHERE primary_title=MAX(length(primary_title))
WHERE length(primary_title) IN ( SELECT  MAX(length(primary_title))  FROM titles)
GROUP BY type;

--  single 3
SELECT type,primary_title,runtime_minutes
From titles  
WHERE length(primary_title) >= (SELECT  max(length(primary_title))  From titles)
GROUP BY type;

--multiple  
SELECT type,primary_title,runtime_minutes
From titles 
--WHERE primary_title=MAX(length(primary_title))
GROUP BY type
HAVING length(primary_title)=MAX(length(primary_title));


--failed
SELECT type,primary_title,runtime_minutes
From titles  
WHERE length(primary_title) >= ALL (SELECT  length(primary_title)  From titles)
GROUP BY type;


/*
SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY
*/
