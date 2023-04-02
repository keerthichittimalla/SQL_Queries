SELECT * from movies WHERE imdb_rating > 6;

SELECT F.budget, M.*
FROM financials F, movies M
WHERE 1=1 
AND M.movie_id = F.movie_id
AND F.budget > 120;

SELECT * from movies WHERE title like "%THOR%";

SELECT *
FROM movies WHERE industry="Bollywood"
ORDER BY imdb_rating ASC LIMIT 5;

SELECT AVG(imdb_rating) FROM movies WHERE industry="Bollywood";

SELECT ROUND(AVG(imdb_rating),2) FROM movies WHERE studio="Marvel Studios";

SELECT MIN(imdb_rating) as min_rating,
	MAX(imdb_rating) as max_rating,
    ROUND (AVG(imdb_rating),2) as avg_rating
FROM movies WHERE studio="Marvel Studios";

SELECT studio, COUNT(*) as cnt
FROM movies
GROUP BY studio
ORDER BY cnt DESC;

SELECT release_year, COUNT(*) as movies_count
FROM movies
GROUP BY release_year
having movies_count>2
ORDER BY movies_count desc;

SELECT *, (revenue-budget) as profit FROM movies.financials;

SELECT movies.movie_id, title, budget, revenue, currency, unit
FROM movies
JOIN financials
ON movies.movie_id=financials.movie_id;

SELECT m.movie_id, title, budget, revenue, currency, unit
FROM movies m
LEFT JOIN financials f
ON m.movie_id=f.movie_id;

WITH t AS
(
SELECT DISTINCT title
FROM movies
WHERE industry = 'Hollywood'
AND imdb_rating > 6
),
s AS
(
SELECT DISTINCT studio
FROM movies
WHERE release_year = '2022'
AND imdb_rating > 6
)
SELECT title, studio, imdb_rating
FROM movies
WHERE studio IN (SELECT studio FROM s)
AND title IN (SELECT title FROM t)
ORDER BY imdb_rating DESC;


WITH t AS
(
SELECT DISTINCT title
FROM movies
WHERE industry = 'Hollywood'
AND imdb_rating > 6
),
ry AS
(
SELECT DISTINCT release_year
FROM movies
WHERE release_year = '2022'
AND imdb_rating > 6
)
SELECT title, release_year, imdb_rating
FROM movies
WHERE release_year IN (SELECT release_year FROM ry)
AND title IN (SELECT title FROM t)
ORDER BY imdb_rating DESC;

SELECT movie_id,
       title,
       industry,
       imdb_rating,
       CASE WHEN imdb_rating > 7 THEN 'Good'
            WHEN imdb_rating < 7 THEN 'Bad'
            ELSE 'Average' 
       END AS Performance
FROM movies;

SELECT product_code,
	COUNT(CASE WHEN product_code = 'prod279' THEN product_code END) AS PRD1,
    COUNT(CASE WHEN product_code = 'prod278' THEN product_code END) AS PRD2,
    COUNT(CASE WHEN product_code = 'prod281' THEN product_code END) AS PRD3
    FROM transactions
    WHERE product_code IN ('prod279', 'prod278', 'prod281')
    GROUP BY product_code;
    
SELECT product_code,
  sales_amount,
  ROW_NUMBER() OVER
              (PARTITION BY product_code
               ORDER BY sales_amount DESC) as RowNumber,
  RANK() OVER 
        (PARTITION BY product_code
         ORDER BY sales_amount DESC) as RankValues,
  DENSE_RANK() OVER 
              (PARTITION BY product_code
               ORDER BY sales_amount DESC) as DenseRankValues
FROM transactions
WHERE product_code IS NOT NULL 
AND product_code IN ('Prod003','Prod003','Prod049', 'Prod279')
AND sales_amount IN ('250', '833', '204');