
DO $$
DECLARE
	cnt INTEGER;
BEGIN
	SELECT COUNT(*) INTO cnt FROM league WHERE name = 'WLAX';
	IF cnt = 0 THEN
		INSERT INTO league (id, name, logo_file) VALUES (8,'WLAX','ncaa_lacrosse.png');
	END IF;
	
	SELECT COUNT(*) INTO cnt FROM season WHERE league_id = 8;
	IF cnt = 0 THEN
		INSERT INTO season (id, league_id, season, teams_url, scores_url, week_start, season_start, season_end) VALUES (8,8,2019,'https://www.masseyratings.com/scores.php?s=307655&sub=11590&all=1&mode=2&sch=on&format=2','https://www.masseyratings.com/scores.php?s=307655&sub=11590&all=1&mode=2&sch=on&format=1',1,DATE '2019-02-01',DATE '2019-05-26');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 64;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (64, 8, 'Atlantic_Coast', 'atlantic-coast.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 65;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (65, 8, 'America_East', 'america-east.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 66;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (66, 8, 'American_Athletic', 'american-athletic.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 67;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (67, 8, 'Atlantic_Sun', 'atlantic-sun.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 68;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (68, 8, 'Atlantic_10', 'atlantic-10.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 69;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (69, 8, 'Big_East', 'big-east.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 70;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (70, 8, 'Big_South', 'big-south.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 71;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (71, 8, 'Big_Ten', 'big-ten.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 72;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (72, 8, 'Colonial_Athletic', 'colonial-athletic.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 73;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (73, 8, 'Ivy_League', 'ivy-league.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 74;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (74, 8, 'Metro_Atlantic', 'metro-atlantic.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 75;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (75, 8, 'Mountain_Pacific', 'mountain-pacific.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 76;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (76, 8, 'Northeast_Conference', 'northeast-conference.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 77;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (77, 8, 'Pac_12', 'pac-12.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 78;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (78, 8, 'Patriot_League', 'patriot-league.png');
	END IF;
	SELECT COUNT(*) INTO cnt FROM conference WHERE id = 79;
	IF cnt = 0 THEN
		INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
			VALUES (79, 8, 'Southern', 'southern.png');
	END IF;
END $$;


--===================================================
-- UPDATE VERSION
--===================================================
INSERT INTO db_version (version, date_applied, notes)
	VALUES ('1.4',NOW(),'Adding Women''s College Lacrosse');