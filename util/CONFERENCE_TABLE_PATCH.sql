DROP TABLE conference CASCADE;


CREATE TABLE conference (
	id SERIAL,
	season_id INTEGER,
	name VARCHAR(255),
	logo_file VARCHAR(255),
	PRIMARY KEY (id),
	FOREIGN KEY (season_id) REFERENCES season (id)
);