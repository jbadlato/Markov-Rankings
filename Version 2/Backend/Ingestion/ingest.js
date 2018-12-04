var request = require('request');
const { Client } = require('pg');

const client = new Client({
	connectionString: process.env.DATABASE_URL,
	ssl: true
});

main();

async function main() {
	await client.connect(()=> console.log("connected to client"));
	await client.query('SELECT id, teams_url, scores_url FROM season WHERE season_start <= CURRENT_DATE AND CURRENT_DATE <= season_end;', async (err, res) => {
		if (err) throw err;	// TODO: output to log file
		console.log("Select query executed for season info.");
		for (let i = 0; i < res.rows.length; i++) {
			let seasonId = res.rows[i].id;
			let teamsUrl = res.rows[i].teams_url;
			let scoresUrl = res.rows[i].scores_url;
			await ingestTeams(teamsUrl, seasonId)
			await ingestScores(scoresUrl, seasonId)
		}

		await client.end(() => console.log("Ended client"));
	});
}

async function ingestTeams(url, seasonId) {
	console.log("Start: ingestTeams(" + url + ", " + seasonId + ")");
	return new Promise(resolve => {
		request(url, async (error, request, body) => {
			console.log(body);
			if (error) {
				// TODO: output to log file
				console.log(error);
			} else {
				let data = body.split(/,[ ]*|[\n]/);
				console.log(JSON.stringify(data));
				let teamId;
				let teamName;
				for (let i = 0; i < data.length; i++) {
					switch (i % 2) {
						case 0: // team id
							teamId = data[i];
							break;
						case 1: // team name
							teamName = data[i];
							// TODO optimize database queries to minimize connections/insert statements
							//console.log("Team ID: " + teamId);
							//console.log("Team Name: " + teamName);
							//console.log("Season ID: " + seasonId);
							if (teamId.length > 0 && teamName.length > 0) {
								console.log("Calling persistNewTeam");
								await persistNewTeam(teamId, teamName, seasonId);
								console.log("Done calling persistNewTeam");
							}
							break;
					}
				}
			}
			resolve();
			console.log("End ingestTeams");
		});
	});
}

async function ingestScores(url, seasonId) {
	console.log("Start: ingestScores(" + url + ", " + seasonId + ")");
	return new Promise(resolve => {
		request(url, async (error, request, body) => {
			if (error) {
				// TODO: output to log file
				console.log(error);
			} else {
				let data = body.split(/,[ ]*|[\n]/);
				let gameDate;
				let idTeam1;
				let idTeam2;
				let homeIndTeam1;
				let homeIndTeam2;
				let scoreTeam1;
				let scoreTeam2;
				for (let i = 0; i < data.length; i++) {
					switch (i % 8) {
						case 0: // days since 1-1-0000
							break;
						case 1: // YYYYMMDD
							gameDate = new Date(data[i].slice(0,4) + '-' + data[i].slice(4,6) + '-' + data[i].slice(6));
							break;
						case 2: // team1 index
							idTeam1 = data[i];
							break;
						case 3: // homefield1 (1=home, -1=away, 0=neutral)
							homeIndTeam1 = data[i];
							break;
						case 4: // score1
							scoreTeam1 = data[i];
							break;
						case 5: // team2 index
							idTeam2 = data[i];
							break;
						case 6: // homefield2 (1=home, -1=away, 0=neutral)
							homeIndTeam2 = data[i];
							break;
						case 7: // score2
							scoreTeam2 = data[i];
							await persistNewScore(gameDate, idTeam1, idTeam2, scoreTeam1, homeIndTeam1);
							await persistNewScore(gameDate, idTeam2, idTeam1, scoreTeam2, homeIndTeam2);
							break;
					}
				}
			}
			resolve();
			console.log("End ingestScores");
		});
	});
}

async function persistNewTeam(teamId, teamName, seasonId) {
	console.log("Persisting team: " + teamId + ", " + teamName + ", " + seasonId);
	let existsQuery = 'SELECT * FROM team WHERE id = $1 AND season_id = $2;';
	return new Promise(resolve => {
		client.query(existsQuery, [teamId, seasonId], async (err, res) => {
			console.log("Exists query run on team: " + teamId + "-" + teamName + "\n\t\t" + JSON.stringify(res));
			if (err) {
				console.log("Error persisting team: " + teamId + " | " + teamName + " | " + seasonId);
				console.log("Query: " + existsQuery);
				throw err; // TODO: output to log file
			}
			if (res.rows.length === 0) {
				let insertQuery = 'INSERT INTO team (id, name, season_id) VALUES ($1, $2, $3);';
				await client.query(insertQuery, [teamId, teamName, seasonId], async (err, res) => {
					if (err) throw err; // TODO: output to log file
					console.log("Inserted team: " + teamId + "-" + teamName);
					await client.query('COMMIT', () => {console.log("committed")});
				});
			} else if (res.rows[0].name !== teamName) {	// team already exists, update it if necessary
				let updateQuery = 'UPDATE team SET name = $1 WHERE team_id = $2 AND season_id = $3;';
				await client.query(updateQuery, [teamname, teamId, seasonId], async (err, res) => {
					if (err) throw err; // TODO: output to log file
					console.log("Updated team: " + teamId + "-" + teamName);
					await client.query('COMMIT', () => {console.log("committed")});
				});
			} else {
				console.log("team already exists");
			}
			resolve();	// TODO: doesn't quite wait for last insert/update to finish
			console.log("Finished persisting team: " + teamId + ", " + teamName);
		});
	});
}

async function persistNewScore(gameDate, teamId, opponentId, score, homeInd) {
	console.log("Persisting score: " + gameDate + ", " + teamId + ", " + opponentId + ", " + score + ", " + homeInd);
	let scheduledInd;
	if (gameDate > new Date()) {
		scheduledInd = '1';
	} else {
		scheduledInd = '0';
	}
	// TODO: see if these queries work with DATE type instead of TIMESTAMPZ type
	let existsQuery = 'SELECT TRUE FROM score WHERE game_date = $1 AND team_id = $2 AND opponent_id = $3;';
	return new Promise(resolve => {
		client.query(existsQuery, [gameDate, teamId, opponentId], async (err, res) => {
			console.log("Exists Query run on score: " + gameDate);
			if (err) throw err; 	// TODO: output to log file
			if (res.rows.length === 0) {
				let insertQuery = 'INSERT INTO score (game_date, team_id, opponent_id, score, home_ind, scheduled_ind) VALUES ($1, $2, $3, $4, $5, $6);';
				await client.query(insertQuery, [gameDate.toUTCString(), teamId, opponentId, score, homeInd, scheduledInd], async (err, res) => {
					if (err) throw err; // TODO: output to log file
					await client.query('COMMIT', () => {console.log("committed")});
				});
			} else if (res.rows[0].score !== score && res.rows[0].scheduled_ind !== scheduledInd) { // score already exists, update if necessary
				let updateQuery = 'UPDATE score SET score = $1, scheduled_ind = $2 WHERE game_date = $3 AND team_id = $4 AND opponent_id = $5;';
				await client.query(updateQuery, [score, scheduledInd, gameDate.toUTCString(), teamId, opponentId], async (err, res) => {
					if (err) throw err;	// TODO: output to log file
					await client.query('COMMIT', () => {console.log("committed")});
				});
			} else {
				console.log("team already exists");
			}
			resolve();
			console.log("Finished persisting score: " + gameDate + ", " + teamId + ", " + opponentId + ", " + score + ", " + homeInd);
		});
	});
}