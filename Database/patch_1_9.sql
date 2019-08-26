DO $$
BEGIN 
	--===================================================
	-- Create new lookup tables
	--===================================================
	IF EXISTS (
		SELECT 1
		FROM pg_class c 
		JOIN pg_namespace n ON n.oid = c.relnamespace
		WHERE n.nspname = 'public'
			AND c.relname = 'lu_team_conference'
			AND c.relkind = 'r'
	) THEN 
		DROP TABLE LU_TEAM_CONFERENCE;
	END IF;
	CREATE TABLE LU_TEAM_CONFERENCE (
		lu_team_conference_id SERIAL PRIMARY KEY,
		team_name VARCHAR(20),
		league_id INTEGER,
		conference_id INTEGER,
		start_date DATE,
		end_date DATE,
		CHECK (start_date <= end_date),
		UNIQUE (team_name, league_id, conference_id, start_date, end_date),
		FOREIGN KEY (league_id) REFERENCES league (id),
		FOREIGN KEY (conference_id) REFERENCES conference (id)
	);
	CREATE UNIQUE INDEX idx_uni_conf_start_date ON lu_team_conference (team_name, league_id, conference_id, end_date) WHERE start_date IS NULL;
	CREATE UNIQUE INDEX idx_uni_conf_end_date ON lu_team_conference (team_name, league_id, conference_id, start_date) WHERE end_date IS NULL;
	CREATE UNIQUE INDEX idx_uni_conf_both_dates ON lu_team_conference (team_name, league_id, conference_id) WHERE start_date IS NULL AND end_date IS NULL;
	IF EXISTS (
		SELECT 1
		FROM pg_class c 
		JOIN pg_namespace n ON n.oid = c.relnamespace
		WHERE n.nspname = 'public'
			AND c.relname = 'lu_team_logo'
			AND c.relkind = 'r'
	) THEN 
		DROP TABLE LU_TEAM_LOGO;
	END IF;
	CREATE TABLE LU_TEAM_LOGO (
	lu_team_logo_id SERIAL PRIMARY KEY,
		team_name VARCHAR(20),
		league_id INTEGER,
		logo_file VARCHAR(255),
		start_date DATE,
		end_date DATE,
		CHECK (start_date <= end_date),
		UNIQUE (team_name, league_id, logo_file, start_date, end_date),
		FOREIGN KEY (league_id) REFERENCES league(id)
	);
	CREATE UNIQUE INDEX idx_uni_logo_start_date ON lu_team_logo (team_name, league_id, logo_file, end_date) WHERE start_date IS NULL;
	CREATE UNIQUE INDEX idx_uni_logo_end_date ON lu_team_logo (team_name, league_id, logo_file, start_date) WHERE end_date IS NULL;
	CREATE UNIQUE INDEX idx_uni_logo_both_dates ON lu_team_logo (team_name, league_id, logo_file) WHERE start_date IS NULL AND end_date IS NULL;
	--===================================================
	-- Fill lookup tables
	--===================================================
	-- Inserts into lu_team_conference
	-- NCAA BB
	-- ACC
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Boston_College',1,35,DATE '2005-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Clemson',1,35,DATE '1953-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Duke',1,35,DATE '1953-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Florida_St',1,35,DATE '1991-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Georgia_Tech',1,35,DATE '1978-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Louisville',1,35,DATE '2014-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Miami_FL',1,35,DATE '2004-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('North_Carolina',1,35,DATE '1953-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('NC_State',1,35,DATE '1953-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Notre_Dame',1,35,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Pittsburgh',1,35,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Syracuse',1,35,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Virginia',1,35,DATE '1953-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Virginia_Tech',1,35,DATE '2004-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Wake_Forest',1,35,DATE '1953-11-01',null);
	-- America East
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Albany_NY',1,1,DATE '2001-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Binghamton',1,1,DATE '2001-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Hartford',1,1,DATE '1985-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Maine',1,1,DATE '1979-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UMBC',1,1,DATE '2003-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('MA_Lowell',1,1,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('New_Hampshire',1,1,DATE '1979-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Stony_Brook',1,1,DATE '2001-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Vermont',1,1,DATE '1979-11-01',null);
	-- American Athletic
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UCF',1,2,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Cincinnati',1,2,DATE '2005-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Connecticut',1,2,DATE '1979-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('East_Carolina',1,2,DATE '2014-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Houston',1,2,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Memphis',1,2,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('South_Florida',1,2,DATE '2005-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('SMU',1,2,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Temple',1,2,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Tulane',1,2,DATE '2014-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Tulsa',1,2,DATE '2014-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Wichita_St',1,2,DATE '2017-11-01',null);
	-- Atlantic 10
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Davidson',1,3,DATE '2014-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Dayton',1,3,DATE '1995-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Duquesne',1,3,DATE '1993-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Fordham',1,3,DATE '1995-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('George_Mason',1,3,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('G_Washington',1,3,DATE '1976-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('La_Salle',1,3,DATE '1995-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Massachusetts',1,3,DATE '1976-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Rhode_Island',1,3,DATE '1980-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Richmond',1,3,DATE '2001-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('St_Bonaventure',1,3,DATE '1979-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('St_Joseph''s_PA',1,3,DATE '1982-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('St_Louis',1,3,DATE '2005-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('VA_Commonwealth',1,3,DATE '2012-11-01',null);
	-- Atlantic Sun
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('FL_Gulf_Coast',1,4,DATE '2007-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Jacksonville',1,4,DATE '1998-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Kennesaw',1,4,DATE '2005-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Liberty',1,4,DATE '2018-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Lipscomb',1,4,DATE '2003-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('NJIT',1,4,DATE '2015-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('North_Alabama',1,4,DATE '2018-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('North_Florida',1,4,DATE '2005-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Stetson',1,4,DATE '1985-11-01',null);
	-- Big 12
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Baylor',1,5,DATE '1996-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Iowa_St',1,5,DATE '1996-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Kansas',1,5,DATE '1996-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Kansas_St',1,5,DATE '1996-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Oklahoma',1,5,DATE '1996-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Oklahoma_St',1,5,DATE '1996-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('TCU',1,5,DATE '2012-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Texas',1,5,DATE '1996-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Texas_Tech',1,5,DATE '1996-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('West_Virginia',1,5,DATE '2012-11-01',null);
	-- Big East
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Butler',1,6,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Creighton',1,6,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('DePaul',1,6,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Georgetown',1,6,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Marquette',1,6,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Providence',1,6,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('St_John''s',1,6,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Seton_Hall',1,6,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Villanova',1,6,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Xavier',1,6,DATE '2013-11-01',null);
	-- Big Sky
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('E_Washington',1,7,DATE '1987-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Idaho',1,7,DATE '2014-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Idaho_St',1,7,DATE '1963-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Montana',1,7,DATE '1963-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Montana_St',1,7,DATE '1963-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Northern_Arizona',1,7,DATE '1970-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('N_Colorado',1,7,DATE '2006-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Portland_St',1,7,DATE '1996-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('CS_Sacramento',1,7,DATE '1996-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Southern_Utah',1,7,DATE '2012-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Weber_St',1,7,DATE '1963-11-01',null);
	-- Big South
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Campbell',1,8,DATE '2011-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Charleston_So',1,8,DATE '1983-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Gardner_Webb',1,8,DATE '2008-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Hampton',1,8,DATE '2018-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('High_Point',1,8,DATE '1999-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Longwood',1,8,DATE '2012-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Presbyterian',1,8,DATE '2007-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Radford',1,8,DATE '1983-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UNC_Asheville',1,8,DATE '1984-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('SC_Upstate',1,8,DATE '2018-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Winthrop',1,8,DATE '1983-11-01',null);
	-- Big Ten
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Indiana',1,9,DATE '1899-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Michigan_St',1,9,DATE '1950-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Northwestern',1,9,DATE '1896-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Ohio_St',1,9,DATE '1912-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Penn_St',1,9,DATE '1990-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Purdue',1,9,DATE '1896-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Rutgers',1,9,DATE '2014-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Illinois',1,9,DATE '1896-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Iowa',1,9,DATE '1899-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Maryland',1,9,DATE '2014-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Michigan',1,9,DATE '1896-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Minnesota',1,9,DATE '1896-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Nebraska',1,9,DATE '2011-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Wisconsin',1,9,DATE '1896-11-01',null);
	-- Big West
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Cal_Poly',1,10,DATE '1996-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('CS_Fullerton',1,10,DATE '1974-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('CS_Northridge',1,10,DATE '2001-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Hawaii',1,10,DATE '2012-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Long_Beach_St',1,10,DATE '1969-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UC_Davis',1,10,DATE '2007-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UC_Irvine',1,10,DATE '1977-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UC_Riverside',1,10,DATE '2001-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UC_Santa_Barbara',1,10,DATE '1976-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('CS_Bakersfield',1,10,DATE '2020-11-01',null);
	-- Colonial Athletic
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Col_Charleston',1,11,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Delaware',1,11,DATE '2001-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Drexel',1,11,DATE '2001-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Elon',1,11,DATE '2014-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Hofstra',1,11,DATE '2001-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('James_Madison',1,11,DATE '1979-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Northeastern',1,11,DATE '2005-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Towson',1,11,DATE '2001-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UNC_Wilmington',1,11,DATE '1984-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('William_&_Mary',1,11,DATE '1979-11-01',null);
	-- Conference USA
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UAB',1,12,DATE '1995-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('FL_Atlantic',1,12,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Florida_Intl',1,12,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Louisiana_Tech',1,12,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Marshall',1,12,DATE '2005-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('MTSU',1,12,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Charlotte',1,12,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('North_Texas',1,12,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Old_Dominion',1,12,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Rice',1,12,DATE '2005-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Southern_Miss',1,12,DATE '1995-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UTEP',1,12,DATE '2005-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UT_San_Antonio',1,12,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('WKU',1,12,DATE '2014-11-01',null);
	-- Horizon League
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Cleveland_St',1,14,DATE '1994-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Detroit',1,14,DATE '1980-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('WI_Green_Bay',1,14,DATE '1994-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('IUPUI',1,14,DATE '2017-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('WI_Milwaukee',1,14,DATE '1994-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('N_Kentucky',1,14,DATE '2015-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Oakland',1,14,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('IL_Chicago',1,14,DATE '1994-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Wright_St',1,14,DATE '1994-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Youngstown_St',1,14,DATE '2001-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('PFW',1,14,DATE '2020-11-01',null);
	-- Ivy League
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Brown',1,16,DATE '1954-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Columbia',1,16,DATE '1954-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Cornell',1,16,DATE '1954-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Dartmouth',1,16,DATE '1954-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Harvard',1,16,DATE '1954-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Penn',1,16,DATE '1954-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Princeton',1,16,DATE '1954-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Yale',1,16,DATE '1954-11-01',null);
	-- Metro Atlantic 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Canisius',1,17,DATE '1989-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Fairfield',1,17,DATE '1981-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Iona',1,17,DATE '1981-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Manhattan',1,17,DATE '1981-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Marist',1,17,DATE '1997-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Monmouth_NJ',1,17,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Niagara',1,17,DATE '1989-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Quinnipiac',1,17,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Rider',1,17,DATE '1997-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('St_Peter''s',1,17,DATE '1981-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Siena',1,17,DATE '1989-11-01',null);
	-- Mid American
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Akron',1,18,DATE '1992-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Bowling_Green',1,18,DATE '1952-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Buffalo',1,18,DATE '1998-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Kent',1,18,DATE '1951-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Miami_OH',1,18,DATE '1947-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Ohio',1,18,DATE '1946-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Ball_St',1,18,DATE '1973-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('C_Michigan',1,18,DATE '1971-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('E_Michigan',1,18,DATE '1971-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('N_Illinois',1,18,DATE '1997-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Toledo',1,18,DATE '1950-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('W_Michigan',1,18,DATE '1947-11-01',null);
	-- Mid Eastern
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Coppin_St',1,19,DATE '1985-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Delaware_St',1,19,DATE '1970-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Howard',1,19,DATE '1970-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('MD_E_Shore',1,19,DATE '1981-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Morgan_St',1,19,DATE '1984-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Norfolk_St',1,19,DATE '1997-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Bethune-Cookman',1,19,DATE '1979-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Florida_A&M',1,19,DATE '1986-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('NC_A&T',1,19,DATE '1970-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('NC_Central',1,19,DATE '1970-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Savannah_St',1,19,DATE '2010-11-01',DATE '2019-11-01');
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('S_Carolina_St',1,19,DATE '1970-11-01',null);
	-- Missouri Valley
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Bradley',1,20,DATE '1955-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Drake',1,20,DATE '1956-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Evansville',1,20,DATE '1994-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Illinois_St',1,20,DATE '1981-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Indiana_St',1,20,DATE '1977-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Loyola-Chicago',1,20,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Missouri_St',1,20,DATE '1990-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Northern_Iowa',1,20,DATE '1991-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('S_Illinois',1,20,DATE '1975-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Valparaiso',1,20,DATE '2017-11-01',null);
	-- Mountain West
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Air_Force',1,21,DATE '1999-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Boise_St',1,21,DATE '2011-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Fresno_St',1,21,DATE '2012-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Colorado_St',1,21,DATE '1999-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Nevada',1,21,DATE '2012-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UNLV',1,21,DATE '1999-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('New_Mexico',1,21,DATE '1999-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('San_Diego_St',1,21,DATE '1999-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('San_Jose_St',1,21,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Utah_St',1,21,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Wyoming',1,21,DATE '1999-11-01',null);
	-- Northeast
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Bryant',1,22,DATE '2008-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Central_Conn',1,22,DATE '1997-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('F_Dickinson',1,22,DATE '1981-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('LIU_Brooklyn',1,22,DATE '1981-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Merrimack',1,22,DATE '2019-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Mt_St_Mary''s',1,22,DATE '1989-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Robert_Morris',1,22,DATE '1981-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Sacred_Heart',1,22,DATE '1999-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('St_Francis_NY',1,22,DATE '1981-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('St_Francis_PA',1,22,DATE '1981-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Wagner',1,22,DATE '1981-11-01',null);
	-- Ohio Valley
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Austin_Peay',1,23,DATE '1962-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Belmont',1,23,DATE '2012-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('E_Illinois',1,23,DATE '1996-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('E_Kentucky',1,23,DATE '1948-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Jacksonville_St',1,23,DATE '2003-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Morehead_St',1,23,DATE '1948-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Murray_St',1,23,DATE '1948-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('SE_Missouri_St',1,23,DATE '1991-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('SIUE',1,23,DATE '2008-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Tennessee_St',1,23,DATE '1986-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Tennessee_Tech',1,23,DATE '1949-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('TN_Martin',1,23,DATE '1992-11-01',null);
	-- Pac 12
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Arizona',1,24,DATE '1978-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Arizona_St',1,24,DATE '1978-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('California',1,24,DATE '1915-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UCLA',1,24,DATE '1928-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Colorado',1,24,DATE '2011-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Oregon',1,24,DATE '1915-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Oregon_St',1,24,DATE '1915-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('USC',1,24,DATE '1922-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Stanford',1,24,DATE '1918-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Utah',1,24,DATE '2011-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Washington',1,24,DATE '1915-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Washington_St',1,24,DATE '1917-11-01',null);
	-- Patriot League
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('American_Univ',1,25,DATE '2001-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Army',1,25,DATE '1990-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Boston_Univ',1,25,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Bucknell',1,25,DATE '1986-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Colgate',1,25,DATE '1986-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Holy_Cross',1,25,DATE '1986-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Lafayette',1,25,DATE '1986-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Lehigh',1,25,DATE '1986-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Loyola_MD',1,25,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Navy',1,25,DATE '1991-11-01',null);
	-- Southeastern
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Florida',1,27,DATE '1932-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Georgia',1,27,DATE '1932-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Kentucky',1,27,DATE '1932-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Missouri',1,27,DATE '2012-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('South_Carolina',1,27,DATE '1991-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Tennessee',1,27,DATE '1932-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Vanderbilt',1,27,DATE '1932-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Alabama',1,27,DATE '1932-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Arkansas',1,27,DATE '1991-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Auburn',1,27,DATE '1932-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('LSU',1,27,DATE '1932-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Mississippi',1,27,DATE '1932-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Mississippi_St',1,27,DATE '1932-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Texas_A&M',1,27,DATE '2012-11-01',null);
	-- Southern
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Chattanooga',1,28,DATE '1976-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Citadel',1,28,DATE '1936-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('ETSU',1,28,DATE '2014-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Furman',1,28,DATE '1936-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Mercer',1,28,DATE '2014-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Samford',1,28,DATE '2008-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UNC_Greensboro',1,28,DATE '1997-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('VMI',1,28,DATE '2014-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('W_Carolina',1,28,DATE '1976-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Wofford',1,28,DATE '1997-11-01',null);
	-- Southland
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Abilene_Chr',1,29,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Cent_Arkansas',1,29,DATE '2006-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Houston_Bap',1,29,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Incarnate_Word',1,29,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Lamar',1,29,DATE '1999-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('McNeese_St',1,29,DATE '1972-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('New_Orleans',1,29,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Nicholls_St',1,29,DATE '1991-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Northwestern_LA',1,29,DATE '1987-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Sam_Houston_St',1,29,DATE '1987-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('SE_Louisiana',1,29,DATE '1987-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('SF_Austin',1,29,DATE '1987-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('TAM_C._Christi',1,29,DATE '2006-11-01',null);
	-- Southwestern Athletic
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Alabama_A&M',1,30,DATE '1999-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Alabama_St',1,30,DATE '1982-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Alcorn_St',1,30,DATE '1962-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Jackson_St',1,30,DATE '1958-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('MS_Valley_St',1,30,DATE '1968-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Ark_Pine_Bluff',1,30,DATE '1997-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Grambling',1,30,DATE '1958-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Prairie_View',1,30,DATE '1920-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Southern_Univ',1,30,DATE '1935-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('TX_Southern',1,30,DATE '1954-11-01',null);
	-- Summit League 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Denver',1,31,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('NE_Omaha',1,31,DATE '2012-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('North_Dakota',1,31,DATE '2018-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('N_Dakota_St',1,31,DATE '2007-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Oral_Roberts',1,31,DATE '2014-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('PFW',1,31,DATE '2007-11-01',DATE '2020-10-31');
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('South_Dakota',1,31,DATE '2011-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('S_Dakota_St',1,31,DATE '2007-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('W_Illinois',1,31,DATE '1982-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Missouri_KC',1,31,DATE '2020-07-01',null);
	-- Sun Belt
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Appalachian_St',1,32,DATE '2014-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Arkansas_St',1,32,DATE '1991-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Coastal_Car',1,32,DATE '2016-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Ga_Southern',1,32,DATE '2014-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Georgia_St',1,32,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Ark_Little_Rock',1,32,DATE '1991-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Louisiana',1,32,DATE '1991-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('ULM',1,32,DATE '2006-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('South_Alabama',1,32,DATE '1976-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Texas_St',1,32,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UT_Arlington',1,32,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Troy',1,32,DATE '2005-11-01',null);
	-- West Coast
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('BYU',1,33,DATE '2011-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Gonzaga',1,33,DATE '1979-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Loy_Marymount',1,33,DATE '1955-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Pacific',1,33,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Pepperdine',1,33,DATE '1955-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Portland',1,33,DATE '1976-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('St_Mary''s_CA',1,33,DATE '1952-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('San_Diego',1,33,DATE '1979-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('San_Francisco',1,33,DATE '1952-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Santa_Clara',1,33,DATE '1952-11-01',null);
	-- Western Athletic
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Cal_Baptist',1,34,DATE '2018-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('CS_Bakersfield',1,34,DATE '2013-11-01',DATE '2020-10-31');
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Chicago_St',1,34,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Grand_Canyon',1,34,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Missouri_KC',1,34,DATE '2013-11-01',DATE '2020-11-01');
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('New_Mexico_St',1,34,DATE '2005-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Seattle',1,34,DATE '2012-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UTRGV',1,34,DATE '2013-11-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Utah_Valley',1,34,DATE '2013-11-01',null);
	-- NCAA Women's Basketball
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) 
		SELECT team_name, 5, conference_id, start_date, end_date 
		FROM lu_team_conference 
		WHERE league_id = 1;
	-- NFL
	-- National 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Dallas',3,36,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('NY_Giants',3,36,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Philadelphia',3,36,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Washington',3,36,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Chicago',3,36,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Detroit',3,36,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Green_Bay',3,36,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Minnesota',3,36,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Atlanta',3,36,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Carolina',3,36,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('New_Orleans',3,36,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Tampa_Bay',3,36,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Arizona',3,36,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('LA_Rams',3,36,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('San_Francisco',3,36,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Seattle',3,36,DATE '2002-07-01',null);
	-- American 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Buffalo',3,37,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Miami',3,37,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('New_England',3,37,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('NY_Jets',3,37,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Baltimore',3,37,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Cincinnati',3,37,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Cleveland',3,37,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Pittsburgh',3,37,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Houston',3,37,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Indianapolis',3,37,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Jacksonville',3,37,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Tennessee',3,37,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Denver',3,37,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Kansas_City',3,37,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('LA_Chargers',3,37,DATE '2002-07-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Oakland',3,37,DATE '2002-07-01',null);
	-- NHL 
	-- Eastern 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Boston',4,38,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Buffalo',4,38,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Carolina',4,38,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Columbus',4,38,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Detroit',4,38,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('New_Jersey',4,38,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('NY_Islanders',4,38,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('NY_Rangers',4,38,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Florida',4,38,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Montreal',4,38,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Ottawa',4,38,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Tampa_Bay',4,38,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Toronto',4,38,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Philadelphia',4,38,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Pittsburgh',4,38,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Washington',4,38,DATE '2013-09-01',null);
	-- Western 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Anaheim',4,39,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Arizona',4,39,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Calgary',4,39,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Edmonton',4,39,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Los_Angeles',4,39,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('San_Jose',4,39,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Vancouver',4,39,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Vegas',4,39,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Chicago',4,39,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Colorado',4,39,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Dallas',4,39,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Minnesota',4,39,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Nashville',4,39,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('St_Louis',4,39,DATE '2013-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Winnipeg',4,39,DATE '2013-09-01',null);
	-- NBA 
	-- Eastern 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Atlanta',6,40,DATE '1968-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Boston',6,40,DATE '1946-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Brooklyn',6,40,DATE '1976-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Charlotte',6,40,DATE '2004-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Chicago',6,40,DATE '1980-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Cleveland',6,40,DATE '1970-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Detroit',6,40,DATE '1978-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Indiana',6,40,DATE '1978-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Miami',6,40,DATE '1989-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Milwaukee',6,40,DATE '1980-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('New_York',6,40,DATE '1946-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Orlando',6,40,DATE '1991-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Philadelphia',6,40,DATE '1949-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Toronto',6,40,DATE '1995-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Washington',6,40,DATE '1961-09-01',null);
	-- Western 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Dallas',6,41,DATE '1980-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Denver',6,41,DATE '1976-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Golden_State',6,41,DATE '1962-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Houston',6,41,DATE '1967-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('LA_Clippers',6,41,DATE '1978-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('LA_Lakers',6,41,DATE '1948-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Memphis',6,41,DATE '1995-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Minnesota',6,41,DATE '1989-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('New_Orleans',6,41,DATE '2004-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Oklahoma_City',6,41,DATE '1967-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Phoenix',6,41,DATE '1968-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Portland',6,41,DATE '1970-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Sacramento',6,41,DATE '1948-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('San_Antonio',6,41,DATE '1980-09-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Utah',6,41,DATE '1979-09-01',null);
	-- College Football
	-- ACC 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Boston_College',2,35,DATE '2005-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Clemson',2,35,DATE '1953-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Duke',2,35,DATE '1953-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Florida_St',2,35,DATE '1992-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Georgia_Tech',2,35,DATE '1983-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Louisville',2,35,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Miami_FL',2,35,DATE '2004-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('North_Carolina',2,35,DATE '1953-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('NC_State',2,35,DATE '1953-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Pittsburgh',2,35,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Syracuse',2,35,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Virginia',2,35,DATE '1953-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Virginia_Tech',2,35,DATE '2004-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Wake_Forest',2,35,DATE '1953-08-01',null);
	-- Independents
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Notre_Dame',2,43,DATE '1887-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Army',2,43,DATE '1890-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('BYU',2,43,DATE '2011-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Liberty',2,43,DATE '2018-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Massachusetts',2,43,DATE '2016-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('New_Mexico_St',2,43,DATE '2018-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Connecticut',2,43,DATE '2020-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Idaho',2,43,DATE '2013-08-01',DATE '2014-08-01');
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('New_Mexico_St',2,43,DATE '2013-08-01',DATE '2014-08-01');
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Navy',2,43,DATE '1979-08-01',DATE '2014-08-01');
	-- Mid-American 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Akron',2,18,DATE '1992-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Bowling_Green',2,18,DATE '1952-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Buffalo',2,18,DATE '1998-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Kent',2,18,DATE '1951-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Miami_OH',2,18,DATE '1947-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Ohio',2,18,DATE '1946-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Ball_St',2,18,DATE '1973-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('C_Michigan',2,18,DATE '1971-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('E_Michigan',2,18,DATE '1971-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('N_Illinois',2,18,DATE '1997-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Toledo',2,18,DATE '1950-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('W_Michigan',2,18,DATE '1947-08-01',null);
	-- Mountain West
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Air_Force',2,21,DATE '1999-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Boise_St',2,21,DATE '2011-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Fresno_St',2,21,DATE '2012-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Colorado_St',2,21,DATE '1999-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Nevada',2,21,DATE '2012-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UNLV',2,21,DATE '1999-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('New_Mexico',2,21,DATE '1999-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('San_Diego_St',2,21,DATE '1999-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('San_Jose_St',2,21,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Utah_St',2,21,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Wyoming',2,21,DATE '1999-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Hawaii',2,21,DATE '2012-08-01',null);
	-- Pac 12
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Arizona',2,24,DATE '1978-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Arizona_St',2,24,DATE '1978-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('California',2,24,DATE '1915-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UCLA',2,24,DATE '1928-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Colorado',2,24,DATE '2011-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Oregon',2,24,DATE '1915-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Oregon_St',2,24,DATE '1915-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('USC',2,24,DATE '1922-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Stanford',2,24,DATE '1918-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Utah',2,24,DATE '2011-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Washington',2,24,DATE '1915-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Washington_St',2,24,DATE '1917-08-01',null);
	-- Southeastern
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Florida',2,27,DATE '1932-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Georgia',2,27,DATE '1932-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Kentucky',2,27,DATE '1932-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Missouri',2,27,DATE '2012-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('South_Carolina',2,27,DATE '1991-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Tennessee',2,27,DATE '1932-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Vanderbilt',2,27,DATE '1932-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Alabama',2,27,DATE '1932-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Arkansas',2,27,DATE '1991-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Auburn',2,27,DATE '1932-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('LSU',2,27,DATE '1932-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Mississippi',2,27,DATE '1932-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Mississippi_St',2,27,DATE '1932-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Texas_A&M',2,27,DATE '2012-08-01',null);
	-- Sun Belt 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Appalachian_St',2,32,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Arkansas_St',2,32,DATE '1991-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Coastal_Car',2,32,DATE '2016-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Ga_Southern',2,32,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Georgia_St',2,32,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Louisiana',2,32,DATE '1991-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('ULM',2,32,DATE '2006-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('South_Alabama',2,32,DATE '1976-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Texas_St',2,32,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Troy',2,32,DATE '2005-08-01',null);
	-- American Athletic 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UCF',2,2,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Cincinnati',2,2,DATE '2005-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Connecticut',2,2,DATE '2004-08-01',DATE '2020-07-31');
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('East_Carolina',2,2,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Houston',2,2,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Memphis',2,2,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('South_Florida',2,2,DATE '2005-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('SMU',2,2,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Temple',2,2,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Tulane',2,2,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Tulsa',2,2,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Navy',2,2,DATE '2015-08-01',null);
	-- Big 12 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Baylor',2,5,DATE '1996-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Iowa_St',2,5,DATE '1996-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Kansas',2,5,DATE '1996-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Kansas_St',2,5,DATE '1996-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Oklahoma',2,5,DATE '1996-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Oklahoma_St',2,5,DATE '1996-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('TCU',2,5,DATE '2012-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Texas',2,5,DATE '1996-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Texas_Tech',2,5,DATE '1996-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('West_Virginia',2,5,DATE '2012-08-01',null);
	-- Big Ten 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Indiana',2,9,DATE '1900-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Michigan_St',2,9,DATE '1953-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Northwestern',2,9,DATE '1896-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Ohio_St',2,9,DATE '1912-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Penn_St',2,9,DATE '1991-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Purdue',2,9,DATE '1896-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Rutgers',2,9,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Illinois',2,9,DATE '1896-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Iowa',2,9,DATE '1900-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Maryland',2,9,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Michigan',2,9,DATE '1896-08-01',DATE '1907-08-01');
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Michigan',2,9,DATE '1917-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Minnesota',2,9,DATE '1896-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Nebraska',2,9,DATE '2011-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Wisconsin',2,9,DATE '1896-08-01',null);
	-- Conference USA 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UAB',2,12,DATE '1999-08-01',DATE '2015-08-01');
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UAB',2,12,DATE '2017-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('FL_Atlantic',2,12,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Florida_Intl',2,12,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Louisiana_Tech',2,12,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Marshall',2,12,DATE '2005-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('MTSU',2,12,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Charlotte',2,12,DATE '1946-08-01',DATE '1995-08-01');
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Charlotte',2,12,DATE '2005-08-01',DATE '2013-08-01');
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Charlotte',2,12,DATE '2015-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('North_Texas',2,12,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Old_Dominion',2,12,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Rice',2,12,DATE '2005-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Southern_Miss',2,12,DATE '1995-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UTEP',2,12,DATE '2005-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UT_San_Antonio',2,12,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('WKU',2,12,DATE '2014-08-01',null);
	-- NCAA Men's Lacrosse 
	-- ACC 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Duke',7,35,DATE '1953-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('North_Carolina',7,35,DATE '1953-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Notre_Dame',7,35,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Syracuse',7,35,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Virginia',7,35,DATE '1953-08-01',null);
	-- America East 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Albany_NY',7,1,DATE '2001-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Binghamton',7,1,DATE '2002-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Hartford',7,1,DATE '1985-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UMBC',7,1,DATE '2003-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('MA_Lowell',7,1,DATE '2015-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Stony_Brook',7,1,DATE '2001-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Vermont',7,1,DATE '1979-08-01',null);
	-- Big East 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Denver',7,6,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Georgetown',7,6,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Marquette',7,6,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Providence',7,6,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('St_John''s',7,6,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Villanova',7,6,DATE '2013-08-01',null);
	-- Big Ten 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Ohio_St',7,9,DATE '1953-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Penn_St',7,9,DATE '1990-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Rutgers',7,9,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Maryland',7,9,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Michigan',7,9,DATE '2012-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Johns_Hopkins',7,9,DATE '2014-08-01',null);
	-- Colonial Athletic 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Delaware',7,11,DATE '2001-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Drexel',7,11,DATE '2001-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Fairfield',7,11,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Hofstra',7,11,DATE '2001-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Massachusetts',7,11,DATE '2009-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Towson',7,11,DATE '2001-08-01',null);
	-- Independents 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Cleveland_St',7,43,DATE '2016-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Hampton',7,43,DATE '2015-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Utah',7,43,DATE '2018-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('NJIT',7,43,DATE '2016-08-01',DATE '2019-08-01');
	-- Ivy League 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Brown',7,16,DATE '1954-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Columbia',7,16,DATE '1954-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Cornell',7,16,DATE '1954-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Dartmouth',7,16,DATE '1954-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Harvard',7,16,DATE '1954-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Penn',7,16,DATE '1954-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Princeton',7,16,DATE '1954-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Yale',7,16,DATE '1954-08-01',null);
	-- Metro Atlantic
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Canisius',7,17,DATE '1989-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Detroit',7,17,DATE '2009-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Manhattan',7,17,DATE '1995-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Marist',7,17,DATE '1997-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Monmouth_NJ',7,17,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Quinnipiac',7,17,DATE '1991-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('St_Bonaventure',7,17,DATE '2018-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Siena',7,17,DATE '1989-08-01',null); 
	-- Northeast Conference 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Bryant',7,22,DATE '2008-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Hobart_&_Smith',7,22,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('LIU_Brooklyn',7,22,DATE '2019-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Merrimack',7,22,DATE '2019-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Mt_St_Mary''s',7,22,DATE '1989-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Robert_Morris',7,22,DATE '2004-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Sacred_Heart',7,22,DATE '1999-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('NJIT',7,22,DATE '2019-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('St_Joseph''s_PA',7,22,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Wagner',7,22,DATE '1998-08-01',null);
	-- Patriot League 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Army',7,25,DATE '1990-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Boston_Univ',7,25,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Bucknell',7,25,DATE '1986-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Colgate',7,25,DATE '1986-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Holy_Cross',7,25,DATE '1986-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Lafayette',7,25,DATE '1986-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Lehigh',7,25,DATE '1986-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Loyola_MD',7,25,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Navy',7,25,DATE '1991-08-01',null);
	-- Southern 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Air_Force',7,28,DATE '2015-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Bellarmine',7,28,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Furman',7,28,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('High_Point',7,28,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Jacksonville',7,28,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Mercer',7,28,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Richmond',7,28,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('VMI',7,28,DATE '2014-08-01',null);
	
	-- NCAA Women's Lacrosse 
	-- ACC 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Boston_College',8,35,DATE '2005-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Duke',8,35,DATE '1995-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Louisville',8,35,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('North_Carolina',8,35,DATE '1995-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Notre_Dame',8,35,DATE '1996-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Pittsburgh',8,35,DATE '2021-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Syracuse',8,35,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Virginia',8,35,DATE '1975-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Virginia_Tech',8,35,DATE '2004-08-01',null);
	-- America East 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Albany_NY',8,1,DATE '2001-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Binghamton',8,1,DATE '2001-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Hartford',8,1,DATE '2017-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UMBC',8,1,DATE '2003-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('MA_Lowell',8,1,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('New_Hampshire',8,1,DATE '1979-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Stony_Brook',8,1,DATE '2002-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Vermont',8,1,DATE '1981-08-01',null);
	-- American Athletic 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Cincinnati',8,2,DATE '2007-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Connecticut',8,2,DATE '1996-08-01',DATE '2019-07-31');
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('East_Carolina',8,2,DATE '2017-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Temple',8,2,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Florida',8,2,DATE '2018-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Vanderbilt',8,2,DATE '2018-08-01',null);
	-- Atlantic Sun 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Akron',8,4,DATE '2019-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Jacksonville',8,4,DATE '2009-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Kennesaw',8,4,DATE '2012-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Liberty',8,4,DATE '2018-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Stetson',8,4,DATE '2012-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Coastal_Car',8,4,DATE '2016-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Howard',8,4,DATE '2012-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Kent',8,4,DATE '2018-08-01',null);
	-- Atlantic 10 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Davidson',8,3,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Duquesne',8,3,DATE '1996-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('George_Mason',8,3,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('G_Washington',8,3,DATE '2001-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('La_Salle',8,3,DATE '1997-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Massachusetts',8,3,DATE '1976-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Richmond',8,3,DATE '2001-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('St_Bonaventure',8,3,DATE '1999-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('St_Joseph''s_PA',8,3,DATE '1992-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('VA_Commonwealth',8,3,DATE '2015-08-01',null);
	-- Big East 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Butler',8,6,DATE '2016-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Georgetown',8,6,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Marquette',8,6,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Villanova',8,6,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Denver',8,6,DATE '2016-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Old_Dominion',8,6,DATE '2018-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Connecticut',8,6,DATE '2020-08-01',null);
	-- Big South 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Campbell',8,8,DATE '2012-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Gardner_Webb',8,8,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('High_Point',8,8,DATE '2010-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Longwood',8,8,DATE '2012-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Presbyterian',8,8,DATE '2007-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Radford',8,8,DATE '2015-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Winthrop',8,8,DATE '2012-08-01',null);
	-- Big Ten 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Northwestern',8,9,DATE '1981-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Ohio_St',8,9,DATE '1995-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Penn_St',8,9,DATE '1991-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Rutgers',8,9,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Maryland',8,9,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Michigan',8,9,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Johns_Hopkins',8,9,DATE '2016-07-01',null);
	-- Colonial Athletic 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Delaware',8,11,DATE '2001-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Drexel',8,11,DATE '2001-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Elon',8,11,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Hofstra',8,11,DATE '2001-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('James_Madison',8,11,DATE '1979-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Towson',8,11,DATE '2001-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('William_&_Mary',8,11,DATE '1979-08-01',null);
	-- Ivy League 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Brown',8,16,DATE '1974-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Columbia',8,16,DATE '1996-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Cornell',8,16,DATE '1971-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Dartmouth',8,16,DATE '1972-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Harvard',8,16,DATE '1974-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Penn',8,16,DATE '1973-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Princeton',8,16,DATE '1972-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Yale',8,16,DATE '1975-08-01',null);
	-- Metro Atlantic 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Canisius',8,17,DATE '1997-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Fairfield',8,17,DATE '1996-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Iona',8,17,DATE '2004-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Manhattan',8,17,DATE '1996-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Marist',8,17,DATE '1997-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Monmouth_NJ',8,17,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Niagara',8,17,DATE '1995-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Quinnipiac',8,17,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Siena',8,17,DATE '1996-08-01',null);
	-- Mountain Pacific 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('UC_Davis',8,75,DATE '1996-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Fresno_St',8,75,DATE '2008-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('San_Diego_St',8,75,DATE '2011-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('St_Mary''s_CA',8,75,DATE '1999-08-01',null);
	-- Northeast Conference 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Bryant',8,22,DATE '2008-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Central_Conn',8,22,DATE '1999-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('LIU_Brooklyn',8,22,DATE '2002-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Merrimack',8,22,DATE '2019-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Mt_St_Mary''s',8,22,DATE '1995-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Robert_Morris',8,22,DATE '2004-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Sacred_Heart',8,22,DATE '1999-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('St_Francis_PA',8,22,DATE '2001-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Wagner',8,22,DATE '1996-08-01',null);
	-- Pac 12 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Arizona_St',8,24,DATE '2017-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('California',8,24,DATE '1998-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Colorado',8,24,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Oregon',8,24,DATE '2004-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('USC',8,24,DATE '2012-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Stanford',8,24,DATE '1994-08-01',null);
	-- Patriot League 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('American_Univ',8,25,DATE '2001-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Army',8,25,DATE '2015-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Boston_Univ',8,25,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Bucknell',8,25,DATE '1986-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Colgate',8,25,DATE '1986-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Holy_Cross',8,25,DATE '1986-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Lafayette',8,25,DATE '1986-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Lehigh',8,25,DATE '1986-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Loyola_MD',8,25,DATE '2013-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Navy',8,25,DATE '2007-08-01',null);
	-- Southern 
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Furman',8,28,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Mercer',8,28,DATE '2014-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Wofford',8,28,DATE '2017-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Detroit',8,28,DATE '2017-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('C_Michigan',8,28,DATE '2017-08-01',null);
	INSERT INTO lu_team_conference (team_name, league_id, conference_id, start_date, end_date) VALUES ('Delaware_St',8,28,DATE '2017-08-01',null);
	
	-- Inserts into lu_team_logo
	-- NCAA sports:
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) 
		SELECT DISTINCT 
			name, 
			season_id, 
			lower(replace(replace(name, '''', ''), '.', ''))||'.png', 
			DATE '2018-08-01',
			null::date
			FROM team 
			WHERE season_id IN (1,2,5,7,8);
	-- NBA 
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Phoenix',6,'phoenix_suns.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Memphis',6,'memphis_grizzlies.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Minnesota',6,'minnesota_timberwolves.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('San_Antonio',6,'san_antonio_spurs.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Denver',6,'denver_nuggets.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Houston',6,'houston_rockets.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('New_York',6,'new_york_knicks.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Cleveland',6,'cleveland_cavaliers.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Chicago',6,'chicago_bulls.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Golden_State',6,'golden_state_warriors.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('New_Orleans',6,'new_orleans_pelicans.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Atlanta',6,'atlanta_hawks.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Washington',6,'washington_wizards.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Utah',6,'utah_jazz.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Orlando',6,'orlando_magic.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Miami',6,'miami_heat.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Sacramento',6,'sacramento_kings.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Brooklyn',6,'brooklyn_nets.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('LA_Lakers',6,'los_angeles_lakers.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Portland',6,'portland_trail_blazers.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Detroit',6,'detroit_pistons.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Indiana',6,'indiana_pacers.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Boston',6,'boston_celtics.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Philadelphia',6,'philadelphia_76ers.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Dallas',6,'dallas_mavericks.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Oklahoma_City',6,'oklahoma_city_thunder.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Toronto',6,'toronto_raptors.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('LA_Clippers',6,'los_angeles_clippers.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Milwaukee',6,'milwaukee_bucks.png',DATE '2018-09-01', null);
	-- NHL 
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Calgary',4,'calgary_flames.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Anaheim',4,'anaheim_ducks.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Los_Angeles',4,'los_angeles_kings.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Chicago',4,'chicago_blackhawks.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Minnesota',4,'minnesota_wild.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Nashville',4,'nashville_predators.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Colorado',4,'colorado_avalanche.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('New_Jersey',4,'new_jersey_devils.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Vancouver',4,'vancouver_canucks.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Columbus',4,'columbus_blue_jackets.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Dallas',4,'dallas_stars.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Pittsburgh',4,'pittsburgh_penguins.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Philadelphia',4,'philadelphia_flyers.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Winnipeg',4,'winnipeg_jets.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('NY_Islanders',4,'new_york_islanders.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Arizona',4,'arizona_coyotes.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Edmonton',4,'edmonton_oilers.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Ottawa',4,'ottawa_senators.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Vegas',4,'vegas_golden_knights.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Detroit',4,'detroit_red_wings.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Carolina',4,'carolina_hurricanes.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Montreal',4,'montreal_canadiens.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Buffalo',4,'buffalo_sabres.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Toronto',4,'toronto_maple_leafs.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('NY_Rangers',4,'new_york_rangers.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Florida',4,'florida_panthers.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Boston',4,'boston_bruins.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Washington',4,'washington_capitals.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Tampa_Bay',4,'tampa_bay_lightning.png',DATE '2018-09-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('St_Louis',4,'st_louis_blues.png',DATE '2018-09-01', null);
	-- NFL 
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Carolina',3,'carolina_panthers.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Green_Bay',3,'green_bay_packers.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Atlanta',3,'atlanta_falcons.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Seattle',3,'seattle_seahawks.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Minnesota',3,'minnesota_vikings.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Chicago',3,'chicago_bears.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('LA_Rams',3,'los_angeles_rams.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Dallas',3,'dallas_cowboys.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Tampa_Bay',3,'tampa_bay_buccaneers.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('NY_Giants',3,'new_york_giants.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Washington',3,'washington_redskins.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Houston',3,'houston_texans.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Cincinnati',3,'cincinnati_bengals.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('New_Orleans',3,'new_orleans_saints.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Jacksonville',3,'jacksonville_jaguars.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Pittsburgh',3,'pittsburgh_steelers.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Baltimore',3,'baltimore_ravens.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Oakland',3,'oakland_raiders.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('San_Francisco',3,'san_francisco_49ers.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Denver',3,'denver_broncos.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('LA_Chargers',3,'los_angeles_chargers.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Arizona',3,'arizona_cardinals.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Cleveland',3,'cleveland_browns.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Kansas_City',3,'kansas_city_chiefs.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Tennessee',3,'tennessee_titans.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('NY_Jets',3,'new_york_jets.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Indianapolis',3,'indianapolis_colts.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Buffalo',3,'buffalo_bills.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Miami',3,'miami_dolphins.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Detroit',3,'detroit_lions.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('New_England',3,'new_england.png',DATE '2018-07-01', null);
	INSERT INTO lu_team_logo (team_name, league_id, logo_file, start_date, end_date) VALUES ('Philadelphia',3,'philadelphia_eagles.png',DATE '2018-07-01', null);
	
	--===================================================
	-- Reset conferences and logos in team table
	--===================================================
	UPDATE team SET conference_id = null;
	UPDATE team SET logo_file = null;
	--===================================================
	-- Delete duplicate conferences
	--===================================================
	-- NCAA football conferences merged with basketball conferences
	DELETE FROM conference WHERE id IN (42,44,45,46,47,48,49,50,51,52);
	-- NCAA lacrosse conferences merged with basketball conferences
	-- (independents merged with football
	DELETE FROM conference WHERE id IN (53,54,55,56,57,58,59,60,61,62,63);
	-- NCAA Women's Lacrosse merged with basketball conferences
	DELETE FROM conference WHERE id IN (64,65,66,67,68,69,70,71,72,73,74,76,77,78,79);
	--===================================================
	-- Create new functions
	--===================================================
	-- Create function to update conferences
	CREATE OR REPLACE FUNCTION update_team_conferences()
	RETURNS void
	LANGUAGE plpgsql
	AS $body$
	BEGIN 
		UPDATE team AS trg
		SET conference_id = (
			SELECT conference_id
			FROM lu_team_conference
			WHERE league_id = (SELECT league_id FROM season WHERE season.id = trg.season_id)
				AND team_name = trg.name
				AND (start_date IS NULL OR start_date <= (SELECT season_start FROM season WHERE id = trg.season_id))
				AND (end_date IS NULL OR end_date >= (SELECT season_start FROM season WHERE id = trg.season_id))
		)
		WHERE conference_id IS NULL OR conference_id <> (
				SELECT conference_id
				FROM lu_team_conference
				WHERE league_id = (SELECT league_id FROM season WHERE season.id = trg.season_id)
					AND team_name = trg.name
					AND (start_date IS NULL OR start_date <= (SELECT season_start FROM season WHERE id = trg.season_id))
					AND (end_date IS NULL OR end_date >= (SELECT season_start FROM season WHERE id = trg.season_id))
			);
	END;
	$body$ SECURITY DEFINER;
	-- Create function for updating team logos 
	CREATE OR REPLACE FUNCTION update_team_logos()
	RETURNS void 
	LANGUAGE plpgsql 
	AS $body$
	BEGIN 
		UPDATE team AS trg
		SET logo_file = (
			SELECT logo_file
			FROM lu_team_logo
			WHERE league_id = (SELECT league_id FROM season WHERE season.id = trg.season_id)
				AND team_name = trg.name
				AND (start_date IS NULL OR start_date <= (SELECT season_start FROM season WHERE id = trg.season_id))
				AND (end_date IS NULL OR end_date >= (SELECT season_start FROM season WHERE id = trg.season_id))
		)
		WHERE logo_file IS NULL OR logo_file <> (
				SELECT logo_file
				FROM lu_team_logo
				WHERE league_id = (SELECT league_id FROM season WHERE season.id = trg.season_id)
					AND team_name = trg.name
					AND (start_date IS NULL OR start_date <= (SELECT season_start FROM season WHERE id = trg.season_id))
					AND (end_date IS NULL OR end_date >= (SELECT season_start FROM season WHERE id = trg.season_id))
			);
	END;
	$body$ SECURITY DEFINER;
	--===================================================
	-- Regenerate conferences and logos with new implementation
	--===================================================
	PERFORM update_team_conferences();
	PERFORM update_team_logos();
	--===================================================
	-- UPDATE VERSION
	--===================================================
	INSERT INTO db_version (version, date_applied, notes)
		VALUES ('1.9',NOW(),'Create lookup tables for conferences and logos.');
END $$;