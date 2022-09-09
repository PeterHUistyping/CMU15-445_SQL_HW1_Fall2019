WITH Mark(person_id) AS (
SELECT person_id
FROM people
WHERE name=="Mark Hamill" AND born==1951
)

SELECT COUNT( DISTINCT(person_id)) AS num
FROM crew
WHERE title_id in (  
SELECT crew.title_id 
FROM crew
JOIN Mark
ON crew.person_id==Mark.person_id --crew.title_id==titles.title_id :no need
)  

AND  (crew.category == "actor" OR crew.category == "actress")--add
;

--SOL
WITH hamill_titles AS (
  SELECT DISTINCT(crew.title_id)
    FROM people
    JOIN crew
    ON crew.person_id == people.person_id AND people.name == "Mark Hamill" AND people.born == 1951
)
SELECT COUNT(DISTINCT(crew.person_id))
  FROM crew
  WHERE (crew.category == "actor" OR crew.category == "actress") AND crew.title_id in hamill_titles
;


 