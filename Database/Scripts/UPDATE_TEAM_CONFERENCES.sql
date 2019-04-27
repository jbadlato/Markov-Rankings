--===================================================
-- NCAA Basketball Conferences
--===================================================
-- Atlantic_Coast
UPDATE team
	SET conference_id = 35
	WHERE season_id IN (1,5) AND
		name IN ('Boston_College', 'Clemson', 'Florida_St', 'Louisville', 'North_Carolina', 'Notre_Dame', 'Syracuse', 'Wake_Forest', 'Duke', 'Georgia_Tech', 'Miami_FL', 'NC_State', 'Pittsburgh', 'Virginia', 'Virginia_Tech');
-- America_East
UPDATE team
	SET conference_id = 1
	WHERE season_id IN (1,5) AND
		name IN ('Vermont', 'UMBC', 'Stony_Brook', 'Hartford', 'MA_Lowell', 'Albany_NY', 'Maine', 'Binghamton', 'New_Hampshire');
-- American_Athletic
UPDATE team
	SET conference_id = 2
	WHERE season_id IN (1,5) AND
		name IN ('Houston', 'Cincinnati', 'UCF', 'Temple', 'Memphis', 'South_Florida', 'SMU', 'Connecticut', 'Wichita_St', 'Tulsa', 'East_Carolina', 'Tulane');
-- Atlantic_10
UPDATE team
	SET conference_id = 3
	WHERE season_id IN (1,5) AND
		name IN ('George_Mason', 'Davidson', 'Dayton', 'VA_Commonwealth', 'Duquesne', 'St_Louis', 'St_Bonaventure', 'Rhode_Island', 'La_Salle', 'G_Washington', 'Richmond', 'St_Joseph''s_PA', 'Massachusetts', 'Fordham');
-- Atlantic_Sun
UPDATE team
	SET conference_id = 4
	WHERE season_id IN (1,5) AND
		name IN ('Lipscomb', 'Liberty', 'NJIT', 'North_Alabama', 'Jacksonville', 'FL_Gulf_Coast', 'North_Florida', 'Kennesaw', 'Stetson');
-- Big_12
UPDATE team
	SET conference_id = 5
	WHERE season_id IN (1,5) AND
		name IN ('Baylor', 'Kansas_St', 'Iowa_St', 'Texas_Tech', 'Kansas', 'Texas', 'TCU', 'Oklahoma', 'Oklahoma_St', 'West_Virginia');
-- Big_East
UPDATE team
	SET conference_id = 6
	WHERE season_id IN (1,5) AND
		name IN ('Villanova', 'Marquette', 'Georgetown', 'St_John''s', 'Seton_Hall', 'Butler', 'Providence', 'Creighton', 'Xavier', 'DePaul');
-- Big_Sky
UPDATE team
	SET conference_id = 7
	WHERE season_id IN (1,5) AND
		name IN ('N_Colorado', 'Montana', 'Weber_St', 'Montana_St', 'E_Washington', 'Southern_Utah', 'Northern_Arizona', 'Portland_St', 'CS_Sacramento', 'Idaho_St', 'Idaho');
-- Big_South
UPDATE team
	SET conference_id = 8
	WHERE season_id IN (1,5) AND
		name IN ('Radford', 'Campbell', 'Hampton', 'Winthrop', 'High_Point', 'Presbyterian', 'Gardner_Webb', 'Charleston_So', 'Longwood', 'UNC_Asheville', 'SC_Upstate');
-- Big_Ten
UPDATE team
	SET conference_id = 9
	WHERE season_id IN (1,5) AND
		name IN ('Michigan_St', 'Michigan', 'Purdue', 'Wisconsin', 'Maryland', 'Minnesota', 'Iowa', 'Ohio_St', 'Rutgers', 'Indiana', 'Nebraska', 'Northwestern', 'Illinois', 'Penn_St');
-- Big_West
UPDATE team
	SET conference_id = 10
	WHERE season_id IN (1,5) AND
		name IN ('UC_Irvine', 'CS_Fullerton', 'UC_Santa_Barbara', 'Hawaii', 'CS_Northridge', 'Long_Beach_St', 'UC_Riverside', 'UC_Davis', 'Cal_Poly');
-- Colonial_Athletic
UPDATE team
	SET conference_id = 11
	WHERE season_id IN (1,5) AND
		name IN ('Hofstra', 'Northeastern', 'Col_Charleston', 'Delaware', 'UNC_Wilmington', 'William_&_Mary', 'Drexel', 'Elon', 'Towson', 'James_Madison');
-- Conference_USA
UPDATE team
	SET conference_id = 12
	WHERE season_id IN (1,5) AND
		name IN ('Old_Dominion', 'UT_San_Antonio', 'North_Texas', 'UAB', 'Marshall', 'WKU', 'Southern_Miss', 'Louisiana_Tech', 'FL_Atlantic', 'Rice', 'Florida_Intl', 'MTSU', 'UTEP', 'Charlotte');
--Horizon_League
UPDATE team
	SET conference_id = 14
	WHERE season_id IN (1,5) AND
		name IN ('N_Kentucky', 'Wright_St', 'Oakland', 'IUPUI', 'Detroit', 'IL_Chicago', 'WI_Green_Bay', 'WI_Milwaukee', 'Youngstown_St', 'Cleveland_St');
-- Ivy_League
UPDATE team
	SET conference_id = 16
	WHERE season_id IN (1,5) AND
		name IN ('Princeton', 'Harvard', 'Yale', 'Cornell', 'Columbia', 'Brown', 'Dartmouth', 'Penn');
-- Metro_Atlantic
UPDATE team
	SET conference_id = 17
	WHERE season_id IN (1,5) AND
		name IN ('Rider', 'Canisius', 'Monmouth_NJ', 'Quinnipiac', 'Siena', 'Iona', 'Niagara', 'St_Peter''s', 'Marist', 'Manhattan', 'Fairfield');
-- Mid_American
UPDATE team
	SET conference_id = 18
	WHERE season_id IN (1,5) AND
		name IN ('Bowling_Green', 'Buffalo', 'Kent', 'Akron', 'Miami_OH', 'Ohio', 'N_Illinois', 'Toledo', 'C_Michigan', 'E_Michigan', 'Ball_St', 'W_Michigan');
-- Mid_Eastern
UPDATE team
	SET conference_id = 19
	WHERE season_id IN (1,5) AND
		name IN ('NC_A&T', 'Norfolk_St', 'NC_Central', 'Florida_A&M', 'Howard', 'Coppin_St', 'Bethune-Cookman', 'Morgan_St', 'Savannah_St', 'S_Carolina_St', 'MD_E_Shore', 'Delaware_St');
-- Missouri_Valley
UPDATE team
	SET conference_id = 20
	WHERE season_id IN (1,5) AND
		name IN ('Loyola-Chicago', 'Illinois_St', 'Drake', 'Missouri_St', 'S_Illinois', 'Valparaiso', 'Northern_Iowa', 'Evansville', 'Bradley', 'Indiana_St');
-- Mountain_West
UPDATE team
	SET conference_id = 21
	WHERE season_id IN (1,5) AND
		name IN ('Nevada', 'Fresno_St', 'Utah_St', 'UNLV', 'Boise_St', 'San_Diego_St', 'Air_Force', 'New_Mexico', 'Colorado_St', 'Wyoming', 'San_Jose_St');
-- Northeast_Conference
UPDATE team
	SET conference_id = 22
	WHERE season_id IN (1,5) AND
		name IN ('Robert_Morris', 'St_Francis_PA', 'Sacred_Heart', 'St_Francis_NY', 'F_Dickinson', 'Bryant', 'Wagner', 'LIU_Brooklyn', 'Central_Conn', 'Mt_St_Mary''s');
-- Ohio_Valley
UPDATE team
	SET conference_id = 23
	WHERE season_id IN (1,5) AND
		name IN ('Jacksonville_St', 'Austin_Peay', 'Murray_St', 'Belmont', 'E_Illinois', 'Morehead_St', 'SIUE', 'Tennessee_Tech', 'Tennessee_St', 'E_Kentucky', 'SE_Missouri_St', 'TN_Martin');
-- Pac_12
UPDATE team
	SET conference_id = 24
	WHERE season_id IN (1,5) AND
		name IN ('Washington', 'Arizona_St', 'USC', 'UCLA', 'Utah', 'Oregon_St', 'Arizona', 'Oregon', 'Stanford', 'Colorado', 'Washington_St', 'California');
-- Patriot_League
UPDATE team
	SET conference_id = 25
	WHERE season_id IN (1,5) AND
		name IN ('Lehigh', 'Bucknell', 'American_Univ', 'Army', 'Colgate', 'Boston_Univ', 'Navy', 'Loyola_MD', 'Holy_Cross', 'Lafayette');
-- Southeastern
UPDATE team
	SET conference_id = 27
	WHERE season_id IN (1,5) AND
		name IN ('LSU', 'Tennessee', 'Kentucky', 'South_Carolina', 'Alabama', 'Florida', 'Mississippi', 'Arkansas', 'Mississippi_St', 'Auburn', 'Texas_A&M', 'Missouri', 'Georgia', 'Vanderbilt');
-- Southern
UPDATE team
	SET conference_id = 28
	WHERE season_id IN (1,5) AND
		name IN ('Wofford', 'UNC_Greensboro', 'ETSU', 'Furman', 'Chattanooga', 'Mercer', 'Samford', 'W_Carolina', 'Citadel', 'VMI');
-- Southland
UPDATE team
	SET conference_id = 29
	WHERE season_id IN (1,5) AND
		name IN ('Sam_Houston_St', 'Abilene_Chr', 'New_Orleans', 'TAM_C._Christi', 'SF_Austin', 'Cent_Arkansas', 'SE_Louisiana', 'McNeese_St', 'Nicholls_St', 'Lamar', 'Northwestern_LA', 'Houston_Bap', 'Incarnate_Word');
-- Southwestern_Athletic
UPDATE team
	SET conference_id = 30
	WHERE season_id IN (1,5) AND
		name IN ('Prairie_View', 'Alabama_St', 'Jackson_St', 'TX_Southern', 'Ark_Pine_Bluff', 'Grambling', 'Alabama_A&M', 'Alcorn_St', 'Southern_Univ', 'MS_Valley_St');
-- Summit_League
UPDATE team
	SET conference_id = 31
	WHERE season_id IN (1,5) AND
		name IN ('S_Dakota_St', 'NE_Omaha', 'PFW', 'N_Dakota_St', 'Oral_Roberts', 'South_Dakota', 'W_Illinois', 'North_Dakota', 'Denver');
-- Sun_Belt
UPDATE team
	SET conference_id = 32
	WHERE season_id IN (1,5) AND
		name IN ('Georgia_St', 'Texas_St', 'Coastal_Car', 'UT_Arlington', 'Ga_Southern', 'ULM', 'Louisiana', 'Troy', 'South_Alabama', 'Arkansas_St', 'Appalachian_St', 'Ark_Little_Rock');
-- West_Coast
UPDATE team
	SET conference_id = 33
	WHERE season_id IN (1,5) AND
		name IN ('Gonzaga', 'San_Francisco', 'BYU', 'San_Diego', 'St_Mary''s_CA', 'Loy_Marymount', 'Pepperdine', 'Santa_Clara', 'Pacific', 'Portland');
-- Western_Athletic
UPDATE team
	SET conference_id = 34
	WHERE season_id IN (1,5) AND
		name IN ('CS_Bakersfield', 'New_Mexico_St', 'Grand_Canyon', 'Utah_Valley', 'Missouri_KC', 'UTRGV', 'Cal_Baptist', 'Seattle', 'Chicago_St');
--===================================================
-- NFL Conferences
--===================================================
UPDATE team
	SET conference_id = 36
	WHERE season_id = 3 AND
		name IN ('Dallas','NY_Giants','Philadelphia','Washington','Chicago','Detroit','Green_Bay','Minnesota','Atlanta','Carolina','New_Orleans','Tampa_Bay','Arizona','LA_Rams','San_Francisco','Seattle');
UPDATE team
	SET conference_id = 37
	WHERE season_id = 3 AND
		name IN ('Buffalo','Miami','New_England','NY_Jets','Baltimore','Cincinnati','Cleveland','Pittsburgh','Houston','Indianapolis','Jacksonville','Tennessee','Denver','Kansas_City','LA_Chargers','Oakland');
--===================================================
-- NHL Conferences
--===================================================
UPDATE team
	SET conference_id = 38
	WHERE season_id = 4 AND
		name IN ('Boston','Buffalo','Carolina','Columbus','Detroit','New_Jersey','NY_Islanders','NY_Rangers','Florida','Montreal','Ottawa','Tampa_Bay','Toronto','Philadelphia','Pittsburgh','Washington');
UPDATE team
	SET conference_id = 39
	WHERE season_id = 4 AND
		name IN ('Anaheim','Arizona','Calgary','Edmonton','Los_Angeles','San_Jose','Vancouver','Vegas','Chicago','Colorado','Dallas','Minnesota','Nashville','St_Louis','Winnipeg');
--===================================================
-- NBA Conferences
--===================================================
UPDATE team
	SET conference_id = 40
	WHERE season_id = 6 AND
		name IN ('Atlanta','Boston','Brooklyn','Charlotte','Chicago','Cleveland','Detroit','Indiana','Miami','Milwaukee','New_York','Orlando','Philadelphia','Toronto','Washington');
UPDATE team
	SET conference_id = 41
	WHERE season_id = 6 AND
		name IN ('Dallas','Denver','Golden_State','Houston','LA_Clippers','LA_Lakers','Memphis','Minnesota','New_Orleans','Oklahoma_City','Phoenix','Portland','Sacramento','San_Antonio','Utah');
--===================================================
-- College Football Conferences
--===================================================
UPDATE team
	SET conference_id = 42	-- ACC
	WHERE season_id = 2 AND
		name IN ('Clemson','Syracuse','NC_State','Boston_College','Wake_Forest','Florida_St','Louisville','Pittsburgh','Georgia_Tech','Virginia','Miami_FL','Virginia_Tech','Duke','North_Carolina');
UPDATE team 
	SET conference_id = 43	-- Independents
	WHERE season_id = 2 AND
		name IN ('Notre_Dame','Army','BYU','Liberty','Massachusetts','New_Mexico_St');
UPDATE team 
	SET conference_id = 44	-- Mid-American
	WHERE season_id = 2 AND
		name IN ('Buffalo','Ohio','Miami_OH','Akron','Bowling_Green','Kent','N_Illinois','E_Michigan','Toledo','W_Michigan','Ball_St','C_Michigan');
UPDATE team
	SET conference_id = 45	-- Mountain West
	WHERE season_id = 2 AND
		name IN ('Fresno_St','Nevada','Hawaii','San_Diego_St','UNLV','San_Jose_St','Utah_St','Boise_St','Wyoming','Air_Force','Colorado_St','New_Mexico');
UPDATE team
	SET conference_id = 46	-- Pac-12
	WHERE season_id = 2 AND
		name IN ('Washington_St','Washington','Stanford','Oregon','California','Oregon_St','Utah','Arizona_St','Arizona','USC','UCLA','Colorado');
UPDATE team
	SET conference_id = 47 -- Southeastern 
	WHERE season_id = 2 AND
		name IN ('Alabama','LSU','Texas_A&M','Mississippi_St','Auburn','Mississippi','Arkansas','Georgia','Florida','Kentucky','Missouri','South_Carolina','Vanderbilt','Tennessee');
UPDATE team
	SET conference_id = 48	--Sun Belt 
	WHERE season_id = 2 AND
		name IN ('Appalachian_St','Troy','Ga_Southern','Coastal_Car','Georgia_St','Arkansas_St','Louisiana','ULM','South_Alabama','Texas_St');
UPDATE team
	SET conference_id = 49	-- American Athletic 
	WHERE season_id = 2 AND
		name IN ('UCF','Temple','Cincinnati','South_Florida','East_Carolina','Connecticut','Houston','Memphis','Tulane','SMU','Tulsa','Navy');
UPDATE team
	SET conference_id = 50	-- Big 12 
	WHERE season_id = 2 AND
		name IN ('Oklahoma','Texas','West_Virginia','Iowa_St','Baylor','TCU','Oklahoma_St','Kansas_St','Texas_Tech','Kansas');
UPDATE team
	SET conference_id = 51	-- Big Ten
	WHERE season_id = 2 AND
		name IN ('Ohio_St','Michigan','Penn_St','Michigan_St','Maryland','Indiana','Rutgers','Northwestern','Iowa','Wisconsin','Purdue','Minnesota','Nebraska','Illinois');
UPDATE team
	SET conference_id = 52	-- Conference USA 
	WHERE season_id = 2 AND
		name IN ('UAB','North_Texas','Louisiana_Tech','Southern_Miss','UT_San_Antonio','Rice','UTEP','MTSU','Florida_Intl','Marshall','Charlotte','FL_Atlantic','Old_Dominion','WKU');
--===================================================
-- NCAA Men's Lacrosse Conferences
--===================================================
--Atlantic_Coast
UPDATE team
	SET conference_id = 42
	WHERE season_id = 7 AND
		name IN ('North_Carolina', 'Notre_Dame', 'Syracuse','Duke','Virginia');
--America_East
UPDATE team
	SET conference_id = 43
	WHERE season_id = 7 AND
		name IN ('Albany_NY', 'Binghamton', 'Hartford','UMBC','MA_Lowell','Stony_Brook','Vermont');
--Big_East
UPDATE team
	SET conference_id = 44
	WHERE season_id = 7 AND
		name IN ('Denver', 'Georgetown', 'Marquette','Providence','St_John''s','Villanova');
--Big_Ten
UPDATE team
	SET conference_id = 45
	WHERE season_id = 7 AND
		name IN ('Johns_Hopkins', 'Maryland', 'Michigan','Ohio_St','Penn_St','Rutgers');
--Colonial_Athletic
UPDATE team
	SET conference_id = 46
	WHERE season_id = 7 AND
		name IN ('Delaware', 'Drexel', 'Fairfield','Hofstra','Massachusetts','Towson'); 
--Independents
UPDATE team
	SET conference_id = 47
	WHERE season_id = 7 AND
		name IN ('Cleveland_St', 'Hampton', 'Utah','NJIT'); 
--Ivy_League
UPDATE team
	SET conference_id = 48
	WHERE season_id = 7 AND
		name IN ('Brown', 'Cornell', 'Dartmouth','Harvard','Penn','Princeton','Yale'); 
--Metro_Atlantic
UPDATE team
	SET conference_id = 49
	WHERE season_id = 7 AND
		name IN ('Canisius', 'Detroit', 'Manhattan', 'Marist','Monmouth_NJ','Quinnipiac','St_Bonaventure','Siena');
--Northeast_Conference
UPDATE team
	SET conference_id = 50
	WHERE season_id = 7 AND
		name IN ('Bryant', 'Hobart_&_Smith', 'Mt_St_Mary''s', 'Marist','Robert_Morris','Sacred_Heart','St_Joseph''s','Wagner');
--Patriot_League
UPDATE team
	SET conference_id = 51
	WHERE season_id = 7 AND
		name IN ('Army', 'Boston', 'Bucknell', 'Colgate','Holy_Cross','Lafayette','Lehigh','Loyola_MD', 'Navy');
--Southern
UPDATE team
	SET conference_id = 51
	WHERE season_id = 7 AND
		name IN ('Air_Force', 'Bellarmine', 'Furman', 'High_Point','Jacksonville','Mercer','Richmond','VMI');
		
		