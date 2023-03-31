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