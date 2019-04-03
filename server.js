const express = require('express');
const path = require('path');
const app = express();
const port = 8080;
let { Client } = require('pg');

const client = new Client({
	connectionString: process.env.DATABASE_URL,
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

app.get('/api/league/:id/ranks', async function(request, response) {
	let leagueId = request.params.id;
	// build query to database
	// TODO: pass leagueId as parameter to client.query to prevent SQL injection
	let SQL = "SELECT   rank.id AS rank_id,  rank.team_id AS team_id,  team.name AS team_name, team.logo_file AS team_logo_file, team.win_count AS win_count, team.loss_count AS loss_count, team.tie_count AS tie_count, conference.id AS conference_id, conference.logo_file AS conference_logo_file, conference.name AS conference_name,  rank.rank AS rank,  rank.rating AS rating FROM league LEFT OUTER JOIN season ON season.league_id = league.id LEFT OUTER JOIN rank ON rank.season_id = season.id LEFT OUTER JOIN team ON team.id = rank.team_id AND team.season_id = rank.season_id LEFT OUTER JOIN conference ON team.conference_id = conference.id WHERE league.id = " + leagueId + "  AND season.season_start = (SELECT MAX(season_start) FROM season WHERE season.league_id = " + leagueId + ")  AND rank.calculated_date = (SELECT MAX(calculated_date) FROM rank WHERE season.season_start = (SELECT MAX(season_start) FROM season WHERE season.league_id = " + leagueId + "))  AND rank.ranking_source_id = 1 ORDER BY rank ASC;";

	await selectQuery(SQL)
		.then((res) => {
			response.send(res);
		})
});

app.get('/api/leagues', async function(request, response) {
	// build query to database
	let SQL = "SELECT id, name, logo_file FROM league;";
	await selectQuery(SQL)
		.then((res) => {
	// send list of leagues to client
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
