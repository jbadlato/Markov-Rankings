DO $$
BEGIN
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Merrimack', 1, 'merrimack.png', DATE '2019-01-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Merrimack', 5, 'merrimack.png', DATE '2019-01-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Merrimack', 7, 'merrimack.png', DATE '2019-01-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Merrimack', 8, 'merrimack.png', DATE '2019-01-01', null);
	PERFORM update_team_logos();
	--===================================================
	-- UPDATE VERSION
	--===================================================
	INSERT INTO db_version (version, date_applied, notes)
		VALUES ('1.17',NOW(),'Add Merrimack logo lookup');
END $$;