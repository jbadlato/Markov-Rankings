DO $$
BEGIN
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('San_Jose',4,'san_jose_sharks.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Charlotte',6,'charlotte_hornets.png',DATE '2018-09-01', null);
	--===================================================
	-- UPDATE VERSION
	--===================================================
	INSERT INTO db_version (version, date_applied, notes)
		VALUES ('1.14',NOW(),'Add missing team logo lookups');
END $$;