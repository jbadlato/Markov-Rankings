DO $$
BEGIN
	-- NBA
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
				12,
				6,
				2019,
				'https://www.masseyratings.com/scores.php?s=309742&sub=309742&all=1&mode=2&sch=on&format=2',
				'https://www.masseyratings.com/scores.php?s=309742&sub=309742&all=1&mode=2&sch=on&format=1',
				1,
				DATE '2019-10-22',
				DATE '2020-06-30'
			);
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
				13,
				1,
				2019,
				'https://www.masseyratings.com/scores.php?s=309912&sub=11590&all=1&mode=2&sch=on&format=2',
				'https://www.masseyratings.com/scores.php?s=309912&sub=11590&all=1&mode=2&sch=on&format=1',
				1,
				DATE '2019-11-05',
				DATE '2020-04-06'
			);
	--===================================================
	-- UPDATE VERSION
	--===================================================
	INSERT INTO db_version (version, date_applied, notes)
		VALUES ('1.13',NOW(),'Add new seasons: Basketball 2019-2020');
END $$;