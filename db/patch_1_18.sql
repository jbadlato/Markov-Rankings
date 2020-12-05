DO $$
BEGIN
	-- NCAA Men's Basketball 
	INSERT INTO season (
			id,
			league_id,
			season,
			teams_url,
			scores_url,
			week_start,
			season_start,
			season_end
		)
		VALUES (
				15,
				1,
				2020,
				'https://www.masseyratings.com/scores.php?s=320158&sub=11590&all=1&mode=2&sch=on&format=2',
				'https://www.masseyratings.com/scores.php?s=320158&sub=11590&all=1&mode=2&sch=on&format=1',
				1,
				DATE '2020-11-25',
				DATE '2021-04-06'
			);
	-- NFL
	INSERT INTO season (
			id,
			league_id,
			season,
			teams_url,
			scores_url,
			week_start,
			season_start,
			season_end
		)
		VALUES (
				16,
				3,
				2020,
				'https://www.masseyratings.com/scores.php?s=318886&sub=318886&all=1&mode=2&sch=on&format=2',
				'https://www.masseyratings.com/scores.php?s=318886&sub=318886&all=1&mode=2&sch=on&format=1',
				1,
				DATE '2020-09-10',
				DATE '2021-02-08'
			);
	-- CFB
	INSERT INTO season (
			id,
			league_id,
			season,
			teams_url,
			scores_url,
			week_start,
			season_start,
			season_end
		)
		VALUES (
				17,
				2,
				2020,
				'https://www.masseyratings.com/scores.php?s=318889&sub=11604&all=1&mode=2&sch=on&format=2',
				'https://www.masseyratings.com/scores.php?s=318889&sub=11604&all=1&mode=2&sch=on&format=1',
				1,
				DATE '2020-09-03',
				DATE '2021-01-12'
			);
	-- WCBB
	INSERT INTO season (
			id,
			league_id,
			season,
			teams_url,
			scores_url,
			week_start,
			season_start,
			season_end
		)
		VALUES (
				18,
				5,
				2020,
				'https://www.masseyratings.com/scores.php?s=320159&sub=11590&all=1&mode=2&sch=on&format=2',
				'https://www.masseyratings.com/scores.php?s=320159&sub=11590&all=1&mode=2&sch=on&format=1',
				1,
				DATE '2020-11-25',
				DATE '2021-04-05'
			);
	
	-- Conferences
	-- vegas raiders
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Las_Vegas',3,37,DATE '1970-01-01',null);
	--tarleton
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Tarleton_St',1,34,DATE '2020-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Tarleton_St',5,34,DATE '2020-11-01',null);
	--bellarmine
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Bellarmine',1,4,DATE '2020-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Bellarmine',5,4,DATE '2020-11-01',null);
	--uc san diego
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UC_San_Diego',1,10,DATE '2020-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UC_San_Diego',5,10,DATE '2020-11-01',null);
	--dixie state
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Dixie_St',1,34,DATE '2020-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Dixie_St',5,34,DATE '2020-11-01',null);

	--===================================================
	-- UPDATE VERSION
	--===================================================
	INSERT INTO db_version (version, date_applied, notes)
		VALUES ('1.18',NOW(),'Add new seasons for 2020');
END $$;