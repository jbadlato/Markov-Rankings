DO $$
BEGIN
	-- NCAA Women's Basketball 
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
				14,
				5,
				2019,
				'https://www.masseyratings.com/scores.php?s=309913&sub=11590&all=1&mode=2&sch=on&format=2',
				'https://www.masseyratings.com/scores.php?s=309913&sub=11590&all=1&mode=2&sch=on&format=1',
				1,
				DATE '2019-11-05',
				DATE '2020-04-06'
			);
	--===================================================
	-- UPDATE VERSION
	--===================================================
	INSERT INTO db_version (version, date_applied, notes)
		VALUES ('1.15',NOW(),'Add new season for Women''s NCAA Basketball');
END $$;