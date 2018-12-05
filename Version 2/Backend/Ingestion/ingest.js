var request = require('request');
const { Client } = require('pg');

const client = new Client({
	//connectionString: process.env.DATABASE_URL,
	connectionString: "postgres://rlbzfzginmesau:61003f3db851e7aa8c9a55441f1341ab0c34b5026f9b672e890da6296dae1241@ec2-23-21-101-249.compute-1.amazonaws.com:5432/d4n31bj8obkqc5",
	ssl: true
});

async function commit() {
	return new Promise((resolve, reject) => {
		client.query('COMMIT', (err, res) => {
			if (err) reject(err);
			console.log("committed");
			resolve();
		});
	});
}

class Team {
	constructor(teamId, teamName, seasonId) {
		this.teamId = teamId;
		this.teamName = teamName;
		this.seasonId = seasonId;
	}

	async persist() {
		let teamId = this.teamId;
		let teamName = this.teamName;
		let seasonId = this.seasonId;
		console.log("Persisting team: " + teamId + ", " + teamName + ", " + seasonId);
		let existsQuery = 'SELECT * FROM team WHERE id = $1 AND season_id = $2;';
		return new Promise((resolve, reject) => {
			client.query(existsQuery, [teamId, seasonId], async (err, res) => {
				console.log("Exists query run on team: " + teamId + "-" + teamName + "\n\t\t" + JSON.stringify(res));
				if (err) {
					console.log("Error persisting team: " + teamId + " | " + teamName + " | " + seasonId);
					console.log("Query: " + existsQuery);
					reject(err); // TODO: output to log file
				}
				if (res.rows.length === 0) {
					await this.insert();
				} else if (res.rows[0].name !== teamName) {	// team already exists, update it if necessary
					await this.update();
				} else {
					console.log("team already exists");
				}
				console.log("Finished persisting team: " + teamId + ", " + teamName);
				resolve();	// TODO: doesn't quite wait for last insert/update to finish
			});
		});
	}

	async insert() {
		let teamId = this.teamId;
		let teamName = this.teamName;
		let seasonId = this.seasonId;
		let insertQuery = 'INSERT INTO team (id, name, season_id) VALUES ($1, $2, $3);';
		return new Promise((resolve, reject) => {
			client.query(insertQuery, [teamId, teamName, seasonId], async (err, res) => {
				if (err) reject(err); // TODO: output to log file
				console.log("Inserted team: " + teamId + "-" + teamName);
				await commit();
				resolve();
			});
		});
	}

	async update() {
		let teamId = this.teamId;
		let teamName = this.teamName;
		let seasonId = this.seasonId;
		let updateQuery = 'UPDATE team SET name = $1 WHERE team_id = $2 AND season_id = $3;';
		return new Promise((resolve, reject) => {
			client.query(updateQuery, [teamname, teamId, seasonId], async (err, res) => {
				if (err) reject(err); // TODO: output to log file
				console.log("Updated team: " + teamId + "-" + teamName);
				await commit();
				resolve();
			});
		});
	}
}

class Score {
	constructor(gameDate, teamId, opponentId, score, homeInd) {
		this.gameDate = gameDate;
		this.teamId = teamId;
		this.opponentId = opponentId;
		this.score = score;
		this.homeInd = homeInd;
		if (gameDate > new Date()) {
			this.scheduledInd = '1';
		} else {
			this.scheduledInd = '0';
		}
	}

	async persist() {
		let gameDate = this.gameDate;
		let teamId = this.teamId;
		let opponentId = this.opponentId;
		let score = this.score;
		let homeInd = this.homeInd;
		let scheduledInd = this.scheduledInd;
		console.log("Persisting score: " + gameDate + ", " + teamId + ", " + opponentId + ", " + score + ", " + homeInd);
		// TODO: see if these queries work with DATE type instead of TIMESTAMPZ type
		let existsQuery = 'SELECT * FROM score WHERE game_date = $1 AND team_id = $2 AND opponent_id = $3;';
		return new Promise(resolve => {
			client.query(existsQuery, [gameDate.toUTCString(), teamId, opponentId], async (err, res) => {
				console.log("Exists Query run on score: " + gameDate);
				if (err) reject(err); 	// TODO: output to log file
				if (res.rows.length === 0) {
					await this.insert();
				} else if (res.rows[0].score !== score || res.rows[0].scheduled_ind !== scheduledInd) { // score already exists, update if necessary
					await this.update();
				} else {
					console.log("score already exists");
				}
				console.log("Finished persisting score: " + gameDate + ", " + teamId + ", " + opponentId + ", " + score + ", " + homeInd);
				resolve();
			});
		});
	}

	async insert() {
		let gameDate = this.gameDate;
		let teamId = this.teamId;
		let opponentId = this.opponentId;
		let score = this.score;
		let homeInd = this.homeInd;
		let scheduledInd = this.scheduledInd;
		let insertQuery = 'INSERT INTO score (game_date, team_id, opponent_id, score, home_ind, scheduled_ind) VALUES ($1, $2, $3, $4, $5, $6);';
		return new Promise((resolve, reject) => {
			client.query(insertQuery, [gameDate.toUTCString(), teamId, opponentId, score, homeInd, scheduledInd], async (err, res) => {
				if (err) reject(err); // TODO: output to log file
				console.log("Inserted score: " + gameDate + ", " + teamId + ", " + opponentId);
				await commit();
				resolve();
			});		
		});
	}

	async update() {
		let gameDate = this.gameDate;
		let teamId = this.teamId;
		let opponentId = this.opponentId;
		let score = this.score;
		let homeInd = this.homeInd;
		let scheduledInd = this.scheduledInd;
		let updateQuery = 'UPDATE score SET score = $1, scheduled_ind = $2, home_ind = $3 WHERE game_date = $4 AND team_id = $5 AND opponent_id = $6;';
		return new Promise((resolve, reject) => {
			client.query(updateQuery, [score, scheduledInd, homeInd, gameDate.toUTCString(), teamId, opponentId], async (err, res) => {
				if (err) reject(err);	// TODO: output to log file
				console.log("Updated score: " + gameDate + ", " + teamId + ", " + opponentId);
				await commit();
				resolve();
			});
		});
	}
}

main();

async function main() {
	await client.connect(()=> console.log("connected to client"));
	client.query('SELECT id, teams_url, scores_url FROM season WHERE season_start <= CURRENT_DATE AND CURRENT_DATE <= season_end;', async (err, res) => {
		if (err) throw err;	// TODO: output to log file
		console.log("Select query executed for season info.");
		for (let i = 0; i < res.rows.length; i++) {
			let seasonId = res.rows[i].id;
			let teamsUrl = res.rows[i].teams_url;
			let scoresUrl = res.rows[i].scores_url;
			await ingestTeams(teamsUrl, seasonId);
			await ingestScores(scoresUrl, seasonId);
		}
		client.end(() => console.log("Ended client"));
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
				let teamObj;
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
								teamObj = new Team(teamId, teamName, seasonId);
								console.log("Calling persistNewTeam");
								await teamObj.persist();
								console.log("Done calling persistNewTeam");
							}
							break;
					}
				}
			}
			console.log("End ingestTeams");
			resolve();
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
				let scoreObj;
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
							scoreObj = new Score(gameDate, idTeam1, idTeam2, scoreTeam1, homeIndTeam1);
							await scoreObj.persist();
							scoreObj = new Score(gameDate, idTeam2, idTeam1, scoreTeam2, homeIndTeam2);
							await scoreObj.persist();
							break;
					}
				}
			}
			console.log("End ingestScores");
			resolve();
		});
	});
}