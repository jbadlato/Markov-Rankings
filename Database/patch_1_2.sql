-- Adding College Lacrosse

--===================================================
-- Men's NCAA D1 Lacrosse
--===================================================
DO $$
DECLARE
	cnt INTEGER;
BEGIN
	SELECT COUNT(*) INTO cnt FROM league WHERE name = 'MLAX';
	IF cnt = 0 THEN
		INSERT INTO league (id, name, logo_file) VALUES (7,'MLAX','mens_college_lacrosse.png');
	END IF;
	
	SELECT COUNT(*) INTO cnt FROM season WHERE league_id = 7;
	IF cnt = 0 THEN
		INSERT INTO season (id, league_id, season, teams_url, scores_url, week_start, season_start, season_end) VALUES (7,7,2019,'https://www.masseyratings.com/scores.php?s=307658&sub=11590&all=1&mode=2&sch=on&format=2','https://www.masseyratings.com/scores.php?s=307658&sub=11590&all=1&mode=2&sch=on&format=1',1,DATE '2019-02-01',DATE '2019-05-27');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 53;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (53, 7, 'Atlantic_Coast', 'atlantic-coast.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 54;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (54, 7, 'America_East', 'america-east.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 55;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (55, 7, 'Big_East', 'big-east.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 56;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (56, 7, 'Big_Ten', 'big-ten.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 57;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (57, 7, 'Colonial_Athletic', 'colonial-athletic.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 58;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (58, 7, 'Independents', 'independents.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 59;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (59, 7, 'Ivy_League', 'ivy-league.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 60;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (60, 7, 'Metro_Atlantic', 'metro-atlantic.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 61;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (61, 7, 'Northeast_Conference', 'northeast-conference.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 62;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (62, 7, 'Patriot_League', 'patriot-league.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 63;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (63, 7, 'Southern', 'southern.png');
	END IF;
END $$;

--===================================================
-- UPDATE VERSION
--===================================================
INSERT INTO db_version (version, date_applied, notes)
	VALUES ('1.2',NOW(),'Adding college lacrosse');