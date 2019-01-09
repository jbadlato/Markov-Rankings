CREATE TABLE league (
	id SERIAL,
	name VARCHAR(4),
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
	name VARCHAR(20),
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

CREATE TABLE rank (
	id SERIAL,
	team_id INTEGER,
	season_id INTEGER,
	week_number INTEGER,
	rank INTEGER,
	rating DECIMAL,
	source VARCHAR(255),
	PRIMARY KEY (id),
	FOREIGN KEY (team_id, season_id) REFERENCES team (id, season_id)
);

CREATE TABLE prediction (
	id SERIAL,
	score_id INTEGER,
	week_number INTEGER,
	prediction INTEGER,
	PRIMARY KEY (id),
	FOREIGN KEY (score_id) REFERENCES score (id)
);