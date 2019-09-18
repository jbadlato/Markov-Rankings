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
				10,
				3,
				2019,
				'https://www.masseyratings.com/scores.php?s=308077&sub=308077&all=1&mode=1&sch=on&format=2',
				'https://www.masseyratings.com/scores.php?s=308077&sub=308077&all=1&mode=1&sch=on&format=1',
				1,
				DATE '2019-09-05',
				DATE '2020-02-02'
			);
	--===================================================
	-- UPDATE VERSION
	--===================================================
	INSERT INTO db_version (version, date_applied, notes)
		VALUES ('1.11',NOW(),'Add new season: NFL 2019-2020');
END $$;