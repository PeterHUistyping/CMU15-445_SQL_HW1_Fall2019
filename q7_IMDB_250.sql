WITH average_rating(C) AS(
SELECT SUM(rating*votes)/SUM(votes) 
FROM ratings,titles
WHERE ratings.title_id==titles.title_id AND titles.type=="movie" --make sure
--GROUP BY title_id
)

SELECT titles.primary_title,(ratings.votes/(ratings.votes+25000.0))*ratings.rating+(25000.0/(ratings.votes+25000.0))*average_rating.C AS Weighted_rating
FROM titles,average_rating,ratings
WHERE titles.type=="movie" and titles.title_id=ratings.title_id --
ORDER BY Weighted_rating  DESC
limit 250;

--SOL

WITH
  av(average_rating) AS (
    SELECT SUM(rating * votes) / SUM(votes)
      FROM ratings
      JOIN titles
      ON titles.title_id == ratings.title_id AND titles.type == "movie" 
  ),
  mn(min_rating) AS (SELECT 25000.0)
SELECT
  primary_title,
  (votes / (votes + min_rating)) * rating + (min_rating / (votes + min_rating)) * average_rating as weighed_rating
  FROM ratings, av, mn
  JOIN titles
  ON titles.title_id == ratings.title_id and titles.type == "movie"
  ORDER BY weighed_rating DESC
  LIMIT 250
  ;