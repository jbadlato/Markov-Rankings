--===================================================
-- Drop all tables
--===================================================
DO $$ DECLARE
    r RECORD;
BEGIN
    -- if the schema you operate on is not "current", you will want to
    -- replace current_schema() in query with 'schematodeletetablesfrom'
    -- *and* update the generate 'DROP...' accordingly.
    FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = current_schema()) LOOP
        EXECUTE 'DROP TABLE IF EXISTS ' || quote_ident(r.tablename) || ' CASCADE';
    END LOOP;
END $$;
--===================================================
-- DDL
--===================================================
CREATE TABLE league (
	id SERIAL,
	name VARCHAR(4),
	logo_file VARCHAR(255),
	PRIMARY KEY (id),
	UNIQUE (name)
);

CREATE TABLE season (
	id SERIAL,
	league_id INTEGER,
	season INTEGER,	-- Year
	teams_url VARCHAR(255),
	scores_url VARCHAR(255),
	week_start INTEGER,	-- 0-6, Sunday - Saturday
	season_start DATE,
	season_end DATE,
	PRIMARY KEY (id),
	FOREIGN KEY (league_id) REFERENCES league (id)
);

CREATE TABLE conference (
	id SERIAL,
	season_id INTEGER,
	name VARCHAR(255),
	logo_file VARCHAR(255),
	PRIMARY KEY (id),
	FOREIGN KEY (season_id) REFERENCES season (id)
);

CREATE TABLE team (
	id INTEGER,
	name VARCHAR(20),
	season_id INTEGER,
	conference_id INTEGER,
	twitter_handle VARCHAR(15),
	logo_file VARCHAR(255),
	win_count INTEGER,
	loss_count INTEGER,
	tie_count INTEGER,
	PRIMARY KEY (id, season_id),
	FOREIGN KEY (season_id) REFERENCES season (id),
	FOREIGN KEY (conference_id) REFERENCES conference (id)
);

CREATE TABLE score (
	id SERIAL,
	season_id INTEGER,
	game_date DATE,
	team_id INTEGER,
	score INTEGER,
	opponent_id INTEGER,
	scheduled_ind INTEGER,
	home_ind INTEGER,
	PRIMARY KEY (id),
	FOREIGN KEY (team_id, season_id) REFERENCES team (id, season_id),
	FOREIGN KEY (opponent_id, season_id) REFERENCES team (id, season_id)
);

CREATE TABLE ranking_source (
	id INTEGER,
	name VARCHAR(255),
	logo_file VARCHAR(255),
	PRIMARY KEY (id)
);

CREATE TABLE rank (
	id SERIAL,
	team_id INTEGER,
	season_id INTEGER,
	week_number INTEGER,
	rank INTEGER,
	rating DECIMAL,
	ranking_source_id INTEGER,
	calculated_date DATE,
	PRIMARY KEY (id),
	FOREIGN KEY (team_id, season_id) REFERENCES team (id, season_id),
	FOREIGN KEY (ranking_source_id) REFERENCES ranking_source (id)
);

CREATE TABLE prediction (
	id SERIAL,
	score_id INTEGER,
	week_number INTEGER,
	prediction INTEGER,
	PRIMARY KEY (id),
	FOREIGN KEY (score_id) REFERENCES score (id)
);
--===================================================
-- DML
--===================================================
-- Ranking Source DML:
INSERT INTO ranking_source (
		id,
		name
	) VALUES (
		1,
		'MARKOV'
	);
-- League DML:
INSERT INTO league (id, name, logo_file) VALUES (1,'CBB', 'ncaa_basketball.png');
INSERT INTO league (id, name, logo_file) VALUES (2,'CFB', 'ncaa_football.png');
INSERT INTO league (id, name, logo_file) VALUES (3,'NFL', 'nfl.png');
INSERT INTO league (id, name, logo_file) VALUES (4,'NHL', 'nhl.png');
INSERT INTO league (id, name, logo_file) VALUES (5,'WCBB', 'ncaa_basketball.png');
INSERT INTO league (id, name, logo_file) VALUES (6,'NBA', 'nba.png');
-- Season DML:
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
			1,
			1,
			2018,
			'https://www.masseyratings.com/scores.php?s=305972&sub=11590&all=1&mode=2&sch=on&format=2',
			'https://www.masseyratings.com/scores.php?s=305972&sub=11590&all=1&mode=2&sch=on&format=1',
			1,
			DATE '2018-11-06',
			DATE '2019-04-08'
		);
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
		2,
		2,
		2018,
		'https://www.masseyratings.com/scores.php?s=300937&sub=11604&all=1&mode=2&sch=on&format=2',
		'https://www.masseyratings.com/scores.php?s=300937&sub=11604&all=1&mode=2&sch=on&format=1',
		1,
		DATE '2018-08-25',
		DATE '2019-01-07'	
		);
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
		3,
		3,
		2018,
		'https://www.masseyratings.com/scores.php?s=300936&sub=300936&all=1&mode=2&sch=on&format=2',
		'https://www.masseyratings.com/scores.php?s=300936&sub=300936&all=1&mode=2&sch=on&format=1',
		1,
		DATE '2018-09-06',
		DATE '2019-02-03'	
		);
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
		4,
		4,
		2018,
		'https://www.masseyratings.com/scores.php?s=298136&sub=298136&all=1&mode=2&sch=on&format=2',
		'https://www.masseyratings.com/scores.php?s=298136&sub=298136&all=1&mode=2&sch=on&format=1',
		1,
		DATE '2018-10-03',
		DATE '2019-06-20'	
		);
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
		5,
		5,
		2018,
		'https://www.masseyratings.com/scores.php?s=298893&sub=11590&all=1&mode=2&sch=on&format=2',
		'https://www.masseyratings.com/scores.php?s=298893&sub=11590&all=1&mode=2&sch=on&format=1',
		1,
		DATE '2018-11-06',
		DATE '2019-04-07'	
		);
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
		6,
		6,
		2018,
		'https://www.masseyratings.com/scores.php?s=305191&sub=305191&all=1&mode=2&sch=on&format=2',
		'https://www.masseyratings.com/scores.php?s=305191&sub=305191&all=1&mode=2&sch=on&format=1',
		1,
		DATE '2018-10-16',
		DATE '2019-06-16'	
		);
-- Conference DML:
TRUNCATE TABLE conference CASCADE;
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (1, 1, 'America_East', 'america-east.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (2, 1, 'American_Athletic', 'american-athletic.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (3, 1, 'Atlantic_10', 'atlantic-10.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (4, 1, 'Atlantic_Sun', 'atlantic-sun.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (5, 1, 'Big_12', 'big-12.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (6, 1, 'Big_East', 'big-east.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (7, 1, 'Big_Sky', 'big-sky.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (8, 1, 'Big_South', 'big-south.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (9, 1, 'Big_Ten', 'big-ten.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (10, 1, 'Big_West', 'big-west.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (11, 1, 'Colonial_Athletic', 'colonial-athletic.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (12, 1, 'Conference_USA', 'conference-usa.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (13, 1, 'Great_West', 'great-west.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (14, 1, 'Horizon_League', 'horizon-league.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (15, 1, 'Independents', 'independents.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (16, 1, 'Ivy_League', 'ivy-league.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (17, 1, 'Metro_Atlantic', 'metro-atlantic.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (18, 1, 'Mid_American', 'mid-american.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (19, 1, 'Mid_Eastern', 'mid-eastern.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (20, 1, 'Missouri_Valley', 'missouri-valley.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (21, 1, 'Mountain_West', 'mountain-west.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (22, 1, 'Northeast_Conference', 'northeast-conference.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (23, 1, 'Ohio_Valley', 'ohio-valley.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (24, 1, 'Pac_12', 'pac-12.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (25, 1, 'Patriot_League', 'patriot-league.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (26, 1, 'Pioneer_Football_League', 'pioneer-football-league.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (27, 1, 'Southeastern', 'southeastern.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (28, 1, 'Southern', 'southern.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (29, 1, 'Southland', 'southland.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (30, 1, 'Southwestern_Athletic', 'southwestern-athletic.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (31, 1, 'Summit_League', 'summit-league.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (32, 1, 'Sun_Belt', 'sun-belt.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (33, 1, 'West_Coast', 'west-coast.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (34, 1, 'Western_Athletic', 'western-athletic.png');
INSERT INTO conference (ID, SEASON_ID, NAME, LOGO_FILE)
	VALUES (35, 1, 'Atlantic_Coast', 'atlantic-coast.png');
--===================================================
-- GRANTS
--===================================================
GRANT SELECT ON ALL TABLES IN SCHEMA public TO markov;
GRANT INSERT ON ALL TABLES IN SCHEMA public TO markov;
GRANT UPDATE ON ALL TABLES IN SCHEMA public TO markov;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO markov;