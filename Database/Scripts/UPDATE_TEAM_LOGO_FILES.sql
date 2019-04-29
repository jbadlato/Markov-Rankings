-- NCAA Sports
UPDATE team
	SET logo_file = lower(replace(replace(name, '''', ''), '.', ''))||'.png'
	WHERE season_id IN (1,2,5,7,8);
-- NBA
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
-- NHL
UPDATE team
	SET logo_file = 'calgary_flames.png'
	WHERE name = 'Calgary'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'anaheim_ducks.png'
	WHERE name = 'Anaheim'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'los_angeles_kings.png'
	WHERE name = 'Los_Angeles'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'chicago_blackhawks.png'
	WHERE name = 'Chicago'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'minnesota_wild.png'
	WHERE name = 'Minnesota'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'san_jose_sharks.png'
	WHERE name = 'San_Jose'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'nashville_predators.png'
	WHERE name = 'Nashville'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'colorado_avalanche.png'
	WHERE name = 'Colorado'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'new_jersey_devils.png'
	WHERE name = 'New_Jersey'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'vancouver_canucks.png'
	WHERE name = 'Vancouver'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'columbus_blue_jackets.png'
	WHERE name = 'Columbus'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'dallas_stars.png'
	WHERE name = 'Dallas'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'pittsburgh_penguins.png'
	WHERE name = 'Pittsburgh'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'philadelphia_flyers.png'
	WHERE name = 'Philadelphia'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'winnipeg_jets.png'
	WHERE name = 'Winnipeg'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'new_york_islanders.png'
	WHERE name = 'NY_Islanders'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'arizona_coyotes.png'
	WHERE name = 'Arizona'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'edmonton_oilers.png'
	WHERE name = 'Edmonton'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'ottawa_senators.png'
	WHERE name = 'Ottawa'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'vegas_golden_knights.png'
	WHERE name = 'Vegas'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'detroit_red_wings.png'
	WHERE name = 'Detroit'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'carolina_hurricanes.png'
	WHERE name = 'Carolina'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'montreal_canadiens.png'
	WHERE name = 'Montreal'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'buffalo_sabres.png'
	WHERE name = 'Buffalo'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'toronto_maple_leafs.png'
	WHERE name = 'Toronto'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'new_york_rangers.png'
	WHERE name = 'NY_Rangers'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'florida_panthers.png'
	WHERE name = 'Florida'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'boston_bruins.png'
	WHERE name = 'Boston'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'washington_capitals.png'
	WHERE name = 'Washington'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'tampa_bay_lightning.png'
	WHERE name = 'Tampa_Bay'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'st_louis_blues.png'
	WHERE name = 'St_Louis'
		AND season_id = 4;
UPDATE team
	SET logo_file = 'carolina_panthers.png'
	WHERE name = 'Carolina'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'green_bay_packers.png'
	WHERE name = 'Green_Bay'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'atlanta_falcons.png'
	WHERE name = 'Atlanta'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'seattle_seahawks.png'
	WHERE name = 'Seattle'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'minnesota_vikings.png'
	WHERE name = 'Minnesota'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'chicago_bears.png'
	WHERE name = 'Chicago'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'los_angeles_rams.png'
	WHERE name = 'LA_Rams'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'dallas_cowboys.png'
	WHERE name = 'Dallas'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'tampa_bay_buccaneers.png'
	WHERE name = 'Tampa_Bay'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'new_york_giants.png'
	WHERE name = 'NY_Giants'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'washington_redskins.png'
	WHERE name = 'Washington'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'houston_texans.png'
	WHERE name = 'Houston'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'cincinnati_bengals.png'
	WHERE name = 'Cincinnati'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'new_orleans_saints.png'
	WHERE name = 'New_Orleans'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'jacksonville_jaguars.png'
	WHERE name = 'Jacksonville'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'pittsburgh_steelers.png'
	WHERE name = 'Pittsburgh'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'baltimore_ravens.png'
	WHERE name = 'Baltimore'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'oakland_raiders.png'
	WHERE name = 'Oakland'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'san_francisco_49ers.png'
	WHERE name = 'San_Francisco'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'denver_broncos.png'
	WHERE name = 'Denver'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'los_angeles_chargers.png'
	WHERE name = 'LA_Chargers'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'arizona_cardinals.png'
	WHERE name = 'Arizona'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'cleveland_browns.png'
	WHERE name = 'Cleveland'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'kansas_city_chiefs.png'
	WHERE name = 'Kansas_City'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'tennessee_titans.png'
	WHERE name = 'Tennessee'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'new_york_jets.png'
	WHERE name = 'NY_Jets'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'indianapolis_colts.png'
	WHERE name = 'Indianapolis'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'buffalo_bills.png'
	WHERE name = 'Buffalo'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'miami_dolphins.png'
	WHERE name = 'Miami'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'detroit_lions.png'
	WHERE name = 'Detroit'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'new_england.png'
	WHERE name = 'New_England'
		AND season_id = 3;
UPDATE team
	SET logo_file = 'philadelphia_eagles.png'
	WHERE name = 'Philadelphia'
		AND season_id = 3;