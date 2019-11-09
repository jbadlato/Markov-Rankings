DO $$
BEGIN
	-- NHL
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
				11,
				4,
				2019,
				'https://www.masseyratings.com/scores.php?s=309744&sub=309744&all=1&mode=2&sch=on&format=2',
				'https://www.masseyratings.com/scores.php?s=309744&sub=309744&all=1&mode=2&sch=on&format=1',
				1,
				DATE '2019-10-02',
				DATE '2020-06-30'
			);
	--===================================================
	-- UPDATE VERSION
	--===================================================
	INSERT INTO db_version (version, date_applied, notes)
		VALUES ('1.12',NOW(),'Add new season: NHL 2019-2020');
END $$;