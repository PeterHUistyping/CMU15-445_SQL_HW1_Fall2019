WITH Mark(person_id) AS (
SELECT person_id
FROM people
WHERE name=="Mark Hamill" AND born==1951
), 
George(person_id) AS (
SELECT person_id
FROM people
WHERE name=="George Lucas" AND born==1944
)

SELECT titles.primary_title
From titles
WHERE type=="movie" AND title_id in(
SELECT title_id FROM crew,Mark
WHERE crew.person_id==Mark.person_id 
INTERSECT
SELECT title_id
FROM crew,George
WHERE crew.person_id==George.person_id
)
ORDER BY primary_title asc;

--
WITH Mark(title_id) AS (
SELECT crew.title_id
FROM crew  
WHERE crew.person_id in (
    SELECT person_id
    FROM people
    WHERE name=="Mark Hamill" AND born==1951
    )
), 
George(title_id) AS (
SELECT crew.title_id
FROM crew
WHERE crew.person_id in (
    SELECT person_id
    FROM people
   WHERE name=="George Lucas" AND born=1944
    )
)
 

SELECT titles.primary_title
From titles
WHERE type=="movie" AND title_id in(
SELECT title_id FROM Mark 
INTERSECT
SELECT title_id FROM George
)
ORDER BY primary_title asc;


---SOL
WITH hamill_movies(title_id) AS (
  SELECT crew.title_id
    FROM crew
    JOIN people
    ON crew.person_id == people.person_id AND people.name == "Mark Hamill" AND people.born == 1951
)
SELECT titles.primary_title
  FROM crew
  JOIN people
  ON crew.person_id == people.person_id AND people.name == "George Lucas" AND people.born == 1944 AND crew.title_id IN hamill_movies
  JOIN titles
  ON crew.title_id == titles.title_id AND titles.type == "movie"
  ORDER BY titles.primary_title
;


