CREATE OR REPLACE FUNCTION delete_cancelled_games()
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM score
	WHERE id IN (
		SELECT team1.id 
		FROM score team1
		INNER JOIN score team2 
			ON team1.season_id = team2.season_id 
			AND team1.team_id = team2.opponent_id 
			AND team1.opponent_id = team2.team_id 
			AND team1.game_date = team2.game_date
		WHERE team1.score = 0
			AND team2.score = 0
			AND team1.scheduled_ind = 0
	);
END;
$$;

--===================================================
-- UPDATE VERSION
--===================================================
INSERT INTO db_version (version, date_applied, notes)
	VALUES ('1.6',NOW(),'Created stored procedure for deleting cancelled games');