DO $$
BEGIN
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) 
		SELECT 'SUNY_Albany', league_id, conference_id, start_date, end_date FROM lu_team_conference WHERE team_name = 'Albany_NY';
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) 
		SELECT 'VCU', league_id, conference_id, start_date, end_date FROM lu_team_conference WHERE team_name = 'VA_Commonwealth';
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date)
		SELECT 'SUNY_Albany', league_id, logo_file, start_date, end_date FROM lu_team_logo WHERE team_name = 'Albany_NY';
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date)
		SELECT 'VCU', league_id, logo_file, start_date, end_date FROM lu_team_logo WHERE team_name = 'VA_Commonwealth';
	PERFORM update_team_conferences();
	PERFORM update_team_logos();
	--===================================================
	-- UPDATE VERSION
	--===================================================
	INSERT INTO db_version (version, date_applied, notes)
		VALUES ('1.16',NOW(),'Fix NCAA Men''s Basketball Conferences');
END $$;