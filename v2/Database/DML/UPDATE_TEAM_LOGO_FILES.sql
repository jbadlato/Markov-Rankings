/* UPDATE team
	SET logo_file = 'abilene_chr.png'
	WHERE name = 'Abilene_Chr';
UPDATE team
	SET logo_file = 'air_force.png'
	WHERE name = 'Air_Force';
UPDATE team
	SET logo_file = 'akron.png'
	WHERE name = 'Akron';
UPDATE team
	SET logo_file = 'alabama.png'
	WHERE name = 'Alabama';
UPDATE team
	SET logo_file = 'alabama_a&m.png'
	WHERE name = 'Alabama_A&M';
UPDATE team
	SET logo_file = 'alabama_st.png'
	WHERE name = 'Alabama_St';
UPDATE team
	SET logo_file = 'albany_ny.png'
	WHERE name = 'Albany_NY';
UPDATE team
	SET logo_file = 'alcorn_st.png'
	WHERE name = 'Alcorn_St';
UPDATE team
	SET logo_file = 'american_univ.png'
	WHERE name = 'American_Univ';
UPDATE team
	SET logo_file = 'appalachian_st.png'
	WHERE name = 'Appalachian_St'; */
UPDATE team
	SET logo_file = lower(replace(replace(name, '''', ''), '.', ''))||'.png';