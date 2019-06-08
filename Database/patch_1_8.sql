DO $$
DECLARE
	cnt INTEGER;
BEGIN
	IF NOT EXISTS (
		SELECT *
		FROM pg_class c 
		JOIN pg_namespace n ON n.oid = c.relnamespace 
		WHERE c.relname = 'idx_conference_season_id'
			AND n.nspname = 'public'
	) THEN 
		CREATE INDEX idx_conference_season_id ON CONFERENCE (SEASON_ID, NAME);
	END IF;
	IF NOT EXISTS (
		SELECT *
		FROM pg_class c 
		JOIN pg_namespace n ON n.oid = c.relnamespace 
		WHERE c.relname = 'idx_league_name'
			AND n.nspname = 'public'
	) THEN 
		CREATE INDEX idx_league_name ON LEAGUE (NAME);
	END IF;
	IF NOT EXISTS (
		SELECT *
		FROM pg_class c 
		JOIN pg_namespace n ON n.oid = c.relnamespace 
		WHERE c.relname = 'idx_prediction_score_id'
			AND n.nspname = 'public'
	) THEN 
		CREATE INDEX idx_prediction_score_id ON PREDICTION (SCORE_ID, WEEK_NUMBER);
	END IF;
	IF NOT EXISTS (
		SELECT *
		FROM pg_class c 
		JOIN pg_namespace n ON n.oid = c.relnamespace 
		WHERE c.relname = 'idx_rank_team'
			AND n.nspname = 'public'
	) THEN 
		CREATE INDEX idx_rank_team ON RANK (RANKING_SOURCE_ID, SEASON_ID, TEAM_ID, CALCULATED_DATE);
	END IF;
	IF NOT EXISTS (
		SELECT *
		FROM pg_class c 
		JOIN pg_namespace n ON n.oid = c.relnamespace 
		WHERE c.relname = 'idx_rank_rank'
			AND n.nspname = 'public'
	) THEN 
		CREATE INDEX idx_rank_rank ON RANK (RANKING_SOURCE_ID, SEASON_ID, RANK);
	END IF;
	IF NOT EXISTS (
		SELECT *
		FROM pg_class c 
		JOIN pg_namespace n ON n.oid = c.relnamespace 
		WHERE c.relname = 'idx_score_team'
			AND n.nspname = 'public'
	) THEN 
		CREATE INDEX idx_score_team ON SCORE (SEASON_ID, TEAM_ID, GAME_DATE);
	END IF;
	IF NOT EXISTS (
		SELECT *
		FROM pg_class c 
		JOIN pg_namespace n ON n.oid = c.relnamespace 
		WHERE c.relname = 'idx_score_opponent'
			AND n.nspname = 'public'
	) THEN 
		CREATE INDEX idx_score_opponent ON SCORE (SEASON_ID, OPPONENT_ID, GAME_DATE);
	END IF;
	IF NOT EXISTS (
		SELECT *
		FROM pg_class c 
		JOIN pg_namespace n ON n.oid = c.relnamespace 
		WHERE c.relname = 'idx_season_league_id'
			AND n.nspname = 'public'
	) THEN 
		CREATE INDEX idx_season_league_id ON SEASON (LEAGUE_ID, SEASON);
	END IF;
	IF NOT EXISTS (
		SELECT *
		FROM pg_class c 
		JOIN pg_namespace n ON n.oid = c.relnamespace 
		WHERE c.relname = 'idx_team_season_id'
			AND n.nspname = 'public'
	) THEN 
		CREATE INDEX idx_team_season_id ON TEAM (SEASON_ID);
	END IF;
	IF NOT EXISTS (
		SELECT *
		FROM pg_class c 
		JOIN pg_namespace n ON n.oid = c.relnamespace 
		WHERE c.relname = 'idx_team_conference_id'
			AND n.nspname = 'public'
	) THEN 
		CREATE INDEX idx_team_conference_id ON TEAM (CONFERENCE_ID);
	END IF;
END $$;
--===================================================
-- UPDATE VERSION
--===================================================
INSERT INTO db_version (version, date_applied, notes)
	VALUES ('1.8',NOW(),'Adding indexes to speed up API responses');