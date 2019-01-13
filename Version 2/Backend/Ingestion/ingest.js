const request = require('request');
const logger = require('heroku-logger');
const { Client } = require('pg');

const client = new Client({
	connectionString: process.env.DATABASE_URL,
	ssl: true
});

async function connectToDB() {
	return new Promise((resolve, reject) => {
		client.connect((err)=> {
			if (err) {
				logger.error('Error connecting to database.', {errorStack: err.stack});
				reject(err);
			} else {
				logger.info('Connected to database successfully.');
				resolve();
			}
		});
	});
}

async function disconnectFromDB() {
	return new Promise((resolve, reject) => {
		client.end((err) => {
			if (err) {
				logger.error('Error disconnecting from database.', JSON.stringify(err));
				reject(err);
			} else {
				logger.info('Disconnected from database successfully.');
				resolve();
			}
		});
	});
}

async function commit() {
	return new Promise((resolve, reject) => {
		client.query('COMMIT', (err, res) => {
			if (err) {
				logger.error('Error occurred during commit.', err);
				reject(err);
				return;
			} else {
				logger.debug('Committed.');
				resolve();
			}
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
		let existsQuery = 'SELECT * FROM team WHERE id = $1 AND season_id = $2;';
		return new Promise((resolve, reject) => {
			client.query(existsQuery, [teamId, seasonId], async (err, res) => {
				if (err) {
					logger.error('Error occurred during select query on team table.', {error: err, teamId: teamId, seasonId: seasonId});
					reject(err);
					return;
				} else if (res.rows.length === 0) {
					await this.insert();
				} else if (res.rows[0].name !== teamName) {	// team already exists, update it if necessary
					await this.update();
				}
				resolve();
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
				if (err) {
					logger.error('Error occurred inserting team.', {error: err, teamId: teamId, teamName: teamName, seasonId: seasonId});
					reject(err);
					return;
				} else {
					logger.debug('Inserted team.', {teamId: teamId, teamName: teamName, seasonId: seasonId});
					await commit();
				}
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
			client.query(updateQuery, [teamName, teamId, seasonId], async (err, res) => {
				if (err) {
					logger.error('Error occurred updating team.', {error: err, teamName: teamName, teamId: teamId, seasonId: seasonId});
					reject(err);
					return;
				} else {
					logger.debug('Updated team.', {teamId: teamId, teamName: teamName, seasonId: seasonId});
					await commit();
				}
				resolve();
			});
		});
	}
}

class Score {
	constructor(seasonId, gameDate, teamId, opponentId, score, homeInd) {
		this.seasonId = seasonId
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
		let seasonId = this.seasonId
		let gameDate = this.gameDate;
		let teamId = this.teamId;
		let opponentId = this.opponentId;
		let score = this.score;
		let homeInd = this.homeInd;
		let scheduledInd = this.scheduledInd;
		let existsQuery = 'SELECT * FROM score WHERE season_id = $1 AND game_date = $2 AND team_id = $3 AND opponent_id = $4;';
		return new Promise((resolve, reject) => {
			client.query(existsQuery, [seasonId, gameDate.toUTCString(), teamId, opponentId], async (err, res) => {
				if (err) {
					logger.error('Error occurred during select query on score table.', err);
					reject(err);
					return;
				} else if (res.rows.length === 0) {
					await this.insert();
				} else if (res.rows[0].score !== parseInt(score) || res.rows[0].scheduled_ind !== parseInt(scheduledInd) || res.rows[0].home_ind !== parseInt(homeInd)) { // score already exists, update if necessary
					await this.update();
				}
				resolve();
			});
		});
	}

	async insert() {
		let seasonId = this.seasonId
		let gameDate = this.gameDate;
		let teamId = this.teamId;
		let opponentId = this.opponentId;
		let score = this.score;
		let homeInd = this.homeInd;
		let scheduledInd = this.scheduledInd;
		let insertQuery = 'INSERT INTO score (season_id, game_date, team_id, opponent_id, score, home_ind, scheduled_ind) VALUES ($1, $2, $3, $4, $5, $6, $7);';
		return new Promise((resolve, reject) => {
			client.query(insertQuery, [seasonId, gameDate.toUTCString(), teamId, opponentId, score, homeInd, scheduledInd], async (err, res) => {
				if (err) {
					logger.error('Error occurred inserting score.', {error: err, seasonId: seasonId, gameDate: gameDate, teamId: teamId, opponentId: opponentId, score: score, homeInd: homeInd, scheduledInd: scheduledInd});
					reject(err);
					return;
				} else {
					logger.debug('Inserted score.', {seasonId: seasonId, gameDate: gameDate, teamId: teamId, opponentId: opponentId, score: score, homeInd: homeInd, scheduledInd: scheduledInd});
					await commit();
				}
				resolve();
			});		
		});
	}

	async update() {
		let seasonId = this.seasonId;
		let gameDate = this.gameDate;
		let teamId = this.teamId;
		let opponentId = this.opponentId;
		let score = this.score;
		let homeInd = this.homeInd;
		let scheduledInd = this.scheduledInd;
		let updateQuery = 'UPDATE score SET score = $1, scheduled_ind = $2, home_ind = $3 WHERE seasonId = $4 AND game_date = $5 AND team_id = $6 AND opponent_id = $7;';
		return new Promise((resolve, reject) => {
			client.query(updateQuery, [score, scheduledInd, homeInd, seasonId, gameDate.toUTCString(), teamId, opponentId], async (err, res) => {
				if (err) {
					logger.error('Error occurred updating score.', {error: err, score: score, scheduledInd: scheduledInd, homeInd: homeInd, seasonId: seasonId, gameDate: gameDate, teamId: teamId, opponentId: opponentId});
					reject();
					return;
				} else {
					logger.debug('Updated score.', {score: score, scheduledInd: scheduledInd, homeInd: homeInd, seasonId: seasonId, gameDate: gameDate, teamId: teamId, opponentId: opponentId});
					await commit();
				}
				resolve();
			});
		});
	}
}

class Season {
	constructor(id, teamsUrl, scoresUrl) {
		this.id = id;
		this.teamsUrl = teamsUrl;
		this.scoresUrl = scoresUrl;
	}
}

async function main() {
	logger.info('BEGIN: ingest.js');
	connectToDB()
		.then(getSeasons()
			.then((seasonArray) => loopSeasons(seasonArray))
			.then(disconnectFromDB)
			.then(logger.info('END: ingest.js'))
			);
}

async function loopSeasons(seasonArray) {
	return new Promise((resolve, reject) => {
		let requests = seasonArray.map((season) => {
			return new Promise((resolve, reject) => {
				ingestSeasonData(season, resolve);
			});
		});
		Promise.all(requests)
			.then(() => resolve());
	});
}

async function ingestSeasonData(season, callback) {
	await ingestTeams(season.teamsUrl, season.id);
	logger.info('Ingested Teams.', {seasonId: season.id, teamsUrl: season.teamsUrl});
	await ingestScores(season.scoresUrl, season.id);
	logger.info('Ingested Scores.', {seasonid: season.id, scoresUrl: season.scoresUrl});
	callback();
}

async function getSeasons() {
	return new Promise((resolve, reject) => {
		let seasonArray = new Array(0);
		try {
			client.query('SELECT id, teams_url, scores_url FROM season WHERE season_start <= CURRENT_DATE AND CURRENT_DATE <= season_end;', (err, res) => {
			if (err) {
				logger.error('Error occurred during select query on season table.', err);
				throw err;
			} else {
				let seasonObj;
				for (let i = 0; i < res.rows.length; i++) {
					let seasonId = res.rows[i].id;
					let teamsUrl = res.rows[i].teams_url;
					let scoresUrl = res.rows[i].scores_url;
					seasonObj = new Season(seasonId, teamsUrl, scoresUrl);
					seasonArray.push(seasonObj);
				}
				resolve(seasonArray);
			}
		});
	}
	catch (err) {
		reject(err)
	}
	});
}

async function ingestTeams(url, seasonId) {
	return new Promise((resolve, reject) => {
		request(url, async (error, request, body) => {
			if (error) {
				logger.error('Error occurred retrieving team data from URL.', {error: err, url: url});
				reject(error);
				return;
			} else {
				logger.info('Retrieved team data from URL successfully.');
				let data = body.split(/,[ ]*|[\n]/);
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
							// TODO optimize database queries to minimize connections/inserts/commits
							if (teamId.length > 0 && teamName.length > 0) {
								teamObj = new Team(teamId, teamName, seasonId);
								await teamObj.persist();
								logger.debug('Done persisting team.', teamObj);
							}
							break;
					}
				}
			}
			resolve();
		});
	});
}

async function ingestScores(url, seasonId) {
	return new Promise((resolve, reject) => {
		request(url, async (error, request, body) => {
			if (error) {
				logger.error('Error occurred retrieving team data from URL.', {error: err, url: url});
				reject(error);
				return;
			} else {
				logger.info('Retrieved scores data from URL successfully.');
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
							scoreObj = new Score(seasonId, gameDate, idTeam1, idTeam2, scoreTeam1, homeIndTeam1);
							await scoreObj.persist();
							logger.debug('Done persisting score.', scoreObj);
							scoreObj = new Score(seasonId, gameDate, idTeam2, idTeam1, scoreTeam2, homeIndTeam2);
							await scoreObj.persist();
							logger.debug('Done persisting score.', scoreObj);
							break;
					}
				}
			}
			resolve();
		});
	});
}

main();