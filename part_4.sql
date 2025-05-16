WITH view_per_day AS 
(
    SELECT DATE(session_start_timestamp) AS date_of_view, COUNT(*) AS view_amount
    FROM Watch_History
    WHERE EXTRACT(YEAR FROM session_start_timestamp) = 2024
    GROUP BY date_of_view
)
SELECT date_of_view, view_amount
FROM view_per_day
WHERE view_amount = (SELECT MAX(view_amount) FROM view_per_day);
