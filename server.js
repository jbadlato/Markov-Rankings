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

app.use(express.static(path.join(__dirname,'client/build')));

app.listen(app.get('port'), function () {
	console.log('Node app is running on port', app.get('port'));
});

app.get('/api/:league_name/:season/ranks/:date', async function(request, response) {
	let inLeagueName = request.params.league_name;
	let inSeason = request.params.season;
	let inDate = request.params.date;
	// build query to database
	let SQL = 
		`SELECT 
			rank.id AS rank_id,  
			rank.team_id AS team_id,  
			team.name AS team_name, 
			team.logo_file AS team_logo_file, 
			team.win_count AS win_count, 
			team.loss_count AS loss_count, 
			team.tie_count AS tie_count, 
			conference.id AS conference_id, 
			conference.logo_file AS conference_logo_file, 
			conference.name AS conference_name,  
			rank.rank AS rank,  
			rank.rating AS rating 
		FROM league 
		LEFT OUTER JOIN season ON season.league_id = league.id AND season.season = $2
		LEFT OUTER JOIN rank ON rank.season_id = season.id AND rank.calculated_date = (SELECT MAX(calculated_date) FROM rank WHERE rank.season_id = season.id AND rank.calculated_date::date = to_date($3,'YYYYMMDD'))
		LEFT OUTER JOIN team ON team.id = rank.team_id AND team.season_id = rank.season_id 
		LEFT OUTER JOIN conference ON team.conference_id = conference.id 
		WHERE league.name = $1
			AND rank.ranking_source_id = 1 
		ORDER BY rank ASC;`;
	let PARAMS = [inLeagueName, inSeason, inDate];
	await selectQuery(SQL, PARAMS)
		.then((res) => {
			response.send(res);
		})
});

app.get('/api/leagues', async function(request, response) {
	// build query to database
	let SQL = 
		`SELECT league.id AS id, name AS name, logo_file, season.season AS latest_season
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

app.get('/*', function(request, response) {
	response.sendFile(path.join(__dirname,'/client/build/index.html'));
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
