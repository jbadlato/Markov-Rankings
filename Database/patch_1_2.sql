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
	SELECT COUNT(*) INTO cnt FROM season WHERE id = 42;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (42, 7, 'Atlantic_Coast', 'atlantic-coast.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM season WHERE id = 43;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (43, 7, 'America_East', 'america-east.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM season WHERE id = 44;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (44, 7, 'Big_East', 'big-east.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM season WHERE id = 45;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (45, 7, 'Big_Ten', 'big-ten.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM season WHERE id = 46;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (46, 7, 'Colonial_Athletic', 'colonial-athletic.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM season WHERE id = 47;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (47, 7, 'Independents', 'independents.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM season WHERE id = 48;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (48, 7, 'Ivy_League', 'ivy-league.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM season WHERE id = 49;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (49, 7, 'Metro_Atlantic', 'metro-atlantic.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM season WHERE id = 50;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (50, 7, 'Northeast_Conference', 'northeast-conference.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM season WHERE id = 51;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (51, 7, 'Patriot_League', 'patriot-league.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM season WHERE id = 52;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (52, 7, 'Southern', 'southern.png');
	END IF;
END $$;

--===================================================
-- UPDATE VERSION
--===================================================
INSERT INTO db_version (version, date_applied, notes)
	VALUES ('1.2',NOW(),'Adding college lacrosse');