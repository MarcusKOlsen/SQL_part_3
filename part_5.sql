CREATE VIEW UserRecord AS
WITH user_info AS 
(
	SELECT user_id, first_name, last_name
	FROM users
), content_info AS
(
	SELECT episode.content_id, episode.title, show_id, season_number, episode_number, uploadedBy
	FROM episode
	INNER JOIN contents ON episode.content_id = contents.content_id
), user_content_info AS
(
	SELECT 
		user_id, first_name, last_name, 
		content_id, title, show_id, season_number, episode_number,
		(content_info.uploadedBy = user_info.user_id) AS isUploaded
	FROM user_info
	CROSS JOIN content_info
)
SELECT 
user_content_info.user_id, first_name, last_name,
user_content_info.content_id, title, show_id, season_number, episode_number, isUploaded,
COUNT(Watch_History.*) FILTER (WHERE Watch_History.IsCompleted = TRUE) AS number_of_views
FROM user_content_info
LEFT JOIN 
	Watch_History 
ON 
	Watch_History.user_id = user_content_info.user_id 
	AND 
	Watch_History.content_id = user_content_info.content_id
GROUP BY
user_content_info.user_id, user_content_info.first_name, user_content_info.last_name,
user_content_info.content_id, user_content_info.title, user_content_info.show_id, user_content_info.season_number,
user_content_info.episode_number, user_content_info.isUploaded