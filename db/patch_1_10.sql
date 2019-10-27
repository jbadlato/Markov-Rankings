DO $$
BEGIN
	-- College Football
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
				9,
				2,
				2019,
				'https://www.masseyratings.com/scores.php?s=308075&sub=11604&all=1&mode=2&sch=on&format=2',
				'https://www.masseyratings.com/scores.php?s=308075&sub=11604&all=1&mode=2&sch=on&format=1',
				1,
				DATE '2019-08-24',
				DATE '2020-01-13'
			);
	--===================================================
	-- UPDATE VERSION
	--===================================================
	INSERT INTO db_version (version, date_applied, notes)
		VALUES ('1.10',NOW(),'Add new seasons.');
END $$;