-- NCAA Men's and Women's Basketball
UPDATE team
	SET logo_file = lower(replace(replace(name, '''', ''), '.', ''))||'.png'
	WHERE season_id = 1 OR season_id = 5;
UPDATE team
	SET logo_file = 'phoenix_suns.png'
	WHERE name = 'Phoenix'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'memphis_grizzlies.png'
	WHERE name = 'Memphis'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'minnesota_timberwolves.png'
	WHERE name = 'Minnesota'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'san_antonio_spurs.png'
	WHERE name = 'San_Antonio'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'denver_nuggets.png'
	WHERE name = 'Denver'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'houston_rockets.png'
	WHERE name = 'Houston'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'new_york_knicks.png'
	WHERE name = 'New_York'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'cleveland_cavaliers.png'
	WHERE name = 'Cleveland'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'chicago_bulls.png'
	WHERE name = 'Chicago'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'golden_state_warriors.png'
	WHERE name = 'Golden_State'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'new_orleans_pelicans.png'
	WHERE name = 'New_Orleans'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'atlanta_hawks.png'
	WHERE name = 'Atlanta'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'washington_wizards.png'
	WHERE name = 'Washington'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'utah_jazz.png'
	WHERE name = 'Utah'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'charlotte_hornets.png'
	WHERE name = 'Charlotte'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'orlando_magic.png'
	WHERE name = 'Orlando'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'miami_heat.png'
	WHERE name = 'Miami'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'sacramento_kings.png'
	WHERE name = 'Sacramento'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'brooklyn_nets.png'
	WHERE name = 'Brooklyn'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'los_angeles_lakers.png'
	WHERE name = 'LA_Lakers'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'portland_trail_blazers.png'
	WHERE name = 'Portland'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'detroit_pistons.png'
	WHERE name = 'Detroit'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'indiana_pacers.png'
	WHERE name = 'Indiana'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'boston_celtics.png'
	WHERE name = 'Boston'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'philadelphia_76ers.png'
	WHERE name = 'Philadelphia'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'dallas_mavericks.png'
	WHERE name = 'Dallas'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'oklahoma_city_thunder.png'
	WHERE name = 'Oklahoma_City'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'toronto_raptors.png'
	WHERE name = 'Toronto'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'los_angeles_clippers.png'
	WHERE name = 'LA_Clippers'
		AND season_id = 6;
UPDATE team
	SET logo_file = 'milwaukee_bucks.png'
	WHERE name = 'Milwaukee'
		AND season_id = 6;
		
		
		
		
		
