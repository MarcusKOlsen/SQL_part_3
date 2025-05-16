WITH show_info AS
(
SELECT tv_show.title, content_id
FROM tv_show
INNER JOIN Episode ON tv_show.show_id = episode.show_id
), movie_info AS 
(
SELECT title, content_id 
FROM movie
), show_movie_join AS 
(
SELECT * FROM show_info
UNION
SELECT * FROM movie_info
), show_movie_content_join AS
(
SELECT title, platform_id, type
FROM contents
INNER JOIN show_movie_join ON contents.content_id = show_movie_join.content_id
)

SELECT title, name, type
FROM show_movie_content_join
INNER JOIN Streaming_Platform ON show_movie_content_join.platform_id = Streaming_Platform.platform_id