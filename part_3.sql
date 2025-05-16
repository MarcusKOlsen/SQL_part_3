WITH finished_contents AS
(
SELECT Watch_History.content_id
FROM Watch_History
INNER JOIN Contents ON Watch_History.content_id = Contents.content_id
WHERE isCompleted = true
)

SELECT content_id, COUNT(content_id)
FROM finished_contents
GROUP BY content_id
HAVING COUNT(content_id) < 2;