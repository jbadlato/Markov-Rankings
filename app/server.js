const express = require('express');
const path = require('path');
const app = express();
const port = 8080;
let { Client } = require('pg');

const client = new Client({
	connectionString: process.env.CLIENT_DATABASE_URL
//	ssl: true
});

client.connect((err)=> {
	if (err) {
		console.log('Error connecting to database.', {errorStack: err.stack});
	} else {
		console.log('Connected to database successfully.');
	}
});

app.set('port', (process.env.PORT || 8080));

app.use(express.static(path.join(__dirname,'client')));

app.listen(app.get('port'), function () {
	console.log('Node app is running on port', app.get('port'));
});

app.get('/api/:league_name/display_name', async function(request, response) {
	let inLeagueName = request.params.league_name;
	let SQL = 'SELECT display_name FROM league WHERE name = $1';
	let PARAMS = [inLeagueName];
	await selectQuery(SQL, PARAMS)
		.then((res) => {
			response.send(res);
		});
});

app.get('/api/:league_name/:season/ranks/:date', async function(request, response) {
	let inLeagueName = request.params.league_name;
	let inSeason = request.params.season;
	let inDate = request.params.date;
	// build query to database
	let SQL = 
		`SELECT 
			rank_curr.id AS rank_id,  
			league.name AS league,
			league.display_name AS league_display_name,
			season.season AS season,
			rank_curr.team_id AS team_id,  
			team.name AS team_name, 
			team.logo_file AS team_logo_file, 
			team.win_count AS win_count, 
			team.loss_count AS loss_count, 
			team.tie_count AS tie_count, 
			conference.id AS conference_id, 
			conference.logo_file AS conference_logo_file, 
			conference.name AS conference_name,  
			rank_curr.rank AS rank,  
			rank_curr.rating AS rating,
			rank_curr.rank - rank_prev.rank AS rank_change
		FROM league 
		LEFT OUTER JOIN season ON season.league_id = league.id AND season.season = $2
		LEFT OUTER JOIN rank rank_curr ON rank_curr.season_id = season.id AND rank_curr.calculated_date = (SELECT MAX(calculated_date) FROM rank WHERE rank.season_id = season.id AND rank.calculated_date::date = to_date($3,'YYYYMMDD'))
		LEFT OUTER JOIN team ON team.id = rank_curr.team_id AND team.season_id = rank_curr.season_id 
		LEFT OUTER JOIN conference ON team.conference_id = conference.id 
		LEFT OUTER JOIN rank rank_prev ON rank_prev.season_id = season.id AND rank_prev.team_id = team.id AND rank_prev.ranking_source_id = rank_curr.ranking_source_id AND rank_prev.calculated_date = (SELECT MAX(calculated_date) FROM rank WHERE rank.season_id = season.id AND rank.calculated_date::date = (rank_curr.calculated_date::date - INTERVAL '1 DAY'))
		WHERE league.name = $1
			AND rank_curr.ranking_source_id = 1 
		ORDER BY rank_curr.rank ASC;`;
	let PARAMS = [inLeagueName, inSeason, inDate];
	await selectQuery(SQL, PARAMS)
		.then((res) => {
			response.send(res);
		});
});

app.get('/api/leagues', async function(request, response) {
	// build query to database
	let SQL = 
		`SELECT league.id AS id, league.name AS name, league.logo_file AS logo_file, league.display_name AS display_name, season.season AS latest_season
			FROM league
			LEFT OUTER JOIN season ON season.league_id = league.id AND season_start = (SELECT MAX(season_start) FROM season WHERE league_id = league.id)
		;`;
	await selectQuery(SQL)
		.then((res) => {
	// send list of leagues to client
			response.send(res);
		});
});

app.get('/api/:league_name/:season/latest_rank_date', async function(request, response) {
	let inLeagueName = request.params.league_name;
	let inSeason = request.params.season;
	let SQL = `
			SELECT TO_CHAR(MAX(rank.calculated_date)::date,'YYYYMMDD') AS latest_rank_date
			FROM league
			LEFT OUTER JOIN season ON season.league_id = league.id AND season.season = $2
			LEFT OUTER JOIN rank ON season.id = rank.season_id
			WHERE league.name = $1
		;`;
	let PARAMS = [inLeagueName, inSeason];
	await selectQuery(SQL, PARAMS)
		.then((res) => {
			response.send(res);
		});
});

app.get('/api/:league_name/:season/all_rank_dates', async function(request, response) {
	let inLeagueName = request.params.league_name;
	let inSeason = request.params.season;
	let SQL = `
		SELECT DISTINCT(TO_CHAR(rank.calculated_date::date,'YYYYMMDD')) AS date
		FROM league
		LEFT OUTER JOIN season ON season.league_id = league.id AND season = $2
		LEFT OUTER JOIN rank ON rank.season_id = season.id
		WHERE league.name = $1
		ORDER BY date DESC
	;`;
	let PARAMS = [inLeagueName, inSeason];
	await selectQuery(SQL, PARAMS)
		.then((res) => {
			response.send(res);
		});
});

app.get('/api/:league_name/:season/:team_name/schedule', async function(request, response) {
	let inLeagueName = request.params.league_name;
	let inSeason = request.params.season;
	let inTeamName = request.params.team_name;
	let SQL = `
		SELECT 
			TO_CHAR(team_score.game_date,'MM/DD/YYYY') AS game_date,
			team.name AS team_name,
			team.logo_file AS team_logo_file,
			team_conference.name AS team_conference_name,
			team_conference.logo_file AS team_conference_logo_file,
			team.win_count AS team_win_count,
			team.loss_count AS team_loss_count,
			team.tie_count AS team_tie_count,
			team_score.score AS team_score,
			opponent_team.name AS opponent_name,
			opponent_team.logo_file AS opponent_logo_file,
			opponent_conference.name AS opponent_conference_name,
			opponent_conference.logo_file AS opponent_conference_logo_file,
			opponent_team.win_count AS opponent_win_count,
			opponent_team.loss_count AS opponent_loss_count,
			opponent_team.tie_count AS opponent_tie_count,
			opponent_score.score AS opponent_score,
			team_score.scheduled_ind AS scheduled_ind,
			team_score.home_ind AS home_ind
		FROM league
		LEFT OUTER JOIN season ON season.league_id = league.id AND season.season = $2
		LEFT OUTER JOIN team ON team.season_id = season.id AND team.name = $3
		LEFT OUTER JOIN score team_score ON team_score.team_id = team.id AND team_score.season_id = season.id
		LEFT OUTER JOIN score opponent_score ON opponent_score.team_id = team_score.opponent_id AND opponent_score.game_date = team_score.game_date AND opponent_score.season_id = season.id
		LEFT OUTER JOIN team opponent_team ON opponent_team.id = team_score.opponent_id AND opponent_team.season_id = season.id
		LEFT OUTER JOIN conference team_conference ON team_conference.id = team.conference_id
		LEFT OUTER JOIN conference opponent_conference ON opponent_conference.id = opponent_team.conference_id
		WHERE league.name = $1
		ORDER BY team_score.game_date;
	;`;
	let PARAMS = [inLeagueName, inSeason, inTeamName];
	await selectQuery(SQL, PARAMS)
		.then((res) => {
			response.send(res);
		});
});

app.get('/*', function(request, response) {
	response.sendFile(path.join(__dirname,'/client/index.html'));
});

function selectQuery(QUERY) {
	return new Promise((resolve, reject) => {
		try{
			client.query(QUERY, (err, res) => {
				if (err) throw err;
				resolve(res);
			});
		} catch (err) {
			reject(err);
		}
	});
}

function selectQuery(QUERY, PARAMS) {
	return new Promise((resolve, reject) => {
		try {
			client.query(QUERY, PARAMS, (err, res) => {
				if (err) throw err;
				resolve(res);
			});
		} catch (err) {
			reject(err);
		}
	});
}
