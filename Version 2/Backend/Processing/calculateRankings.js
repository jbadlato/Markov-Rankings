const logger = require('heroku-logger');
const { Client } = require('pg');

const client = new Client({
	connectionString: process.env.DATABASE_URL,
	ssl: true
});

function newMatrix(m, n, val) {
	// Creates an mxn matrix, intialized with val as each element
	let matrix = [];
	for (let i = 0; i < m; i++) {
		matrix[i] = [];
		for (let j = 0; j < n; j++) {
			matrix[i][j] = val;
		}
	}
	return matrix;
}

function transpose(matrix) {
	// transposes input matrix
	let temp;
	for (let i = 0; i < matrix.length; i++) {
		for (let j = 0; j < i; j++) {
			temp = matrix[i][j];
			matrix[i][j] = matrix[j][i];
			matrix[j][i] = temp;
		}
	}
}

function matrixMultiply(A, B) {
	let C = newMatrix(A.length, B[0].length, 0);
	for (let i = 0; i < C.length; i++) {
		for (let j = 0; j < C[i].length; j++) {
			for (let k = 0; k < C.length; k++) {
				C[i][j] += A[i][k] * B[k][j];
			}
		}
	}
	return C;
}

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

class Season {
	constructor(id, teamCount, weekNumber) {
		this.id = id;
		this.teamCount = teamCount;
		this.weekNumber = weekNumber;
	}
}

class Rank {
	constructor(teamId, seasonId, weekNumber, rank, rating, rankingSourceId) {
		this.teamId = teamId;
		this.seasonId = seasonId;
		this.weekNumber = weekNumber;
		this.rank = rank;
		this.rating = rating;
		this.rankingSourceId = rankingSourceId;
	}

	persist() {
		let teamId = this.teamId;
		let seasonId = this.seasonId;
		let weekNumber = this.weekNumber;
		let rank = this.rank;
		let rating = this.rating;
		let rankingSourceId = this.rankingSourceId;
		logger.debug('Persisting Rank...', {teamId: teamId, seasonId: seasonId, weekNumber: weekNumber, rank: rank, rating: rating, rankingSourceId: rankingSourceId});
		let insertQuery = 'INSERT INTO rank (team_id, season_id, week_number, rank, rating, ranking_source_id) VALUES ($1, $2, $3, $4, $5, $6);';
		return new Promise((resolve, reject) => {
			client.query(insertQuery, [teamId, seasonId, weekNumber, rank, rating, rankingSourceId], async (err, res) => {
				if (err) {
					logger.error('Error occurred inserting rank.', {error: err, teamId: teamId, seasonId: seasonId, weekNumber: weekNumber, rank: rank, rating: rating, rankingSourceId: rankingSourceId});
					reject(err);
				} else {
					logger.debug('Inserted rank.', {teamId: teamId, seasonId: seasonId, weekNumber: weekNumber, rank: rank, rating: rating, rankingSourceId: rankingSourceId});
					await commit();
					resolve();
				}
			});
		})
	}
}

function main() {
	logger.info('BEGIN: calculateRankings.js');
	connectToDB()
		.then(getSeasons()
			.then((seasonArray) => loopSeasons(seasonArray))
			.then(disconnectFromDB)
			.then(() => logger.info('END: calculateRankings.js'))
			);
}

function getSeasons() {
	// Gets array of season IDs, as well as their associated team counts.
	return new Promise((resolve, reject) => {
		let seasonArray = new Array(0);
		let query = "SELECT season.id AS id, COUNT(team.id) AS team_count, CEIL((CURRENT_DATE::DATE - season_start::DATE)/7.0) AS week_number FROM season INNER JOIN team ON (team.season_id = season.id) WHERE season.week_start = EXTRACT(dow FROM '01-14-2019'::DATE) AND season.season_start <= CURRENT_DATE AND CURRENT_DATE <= season.season_end GROUP BY season.id;";
		try {
			client.query(query, (err, res) => {
				if (err) {
					logger.error('Error occurred during select query on season table.', err);
					throw err;
				} else {
					let seasonObj;
					let seasonId;
					let teamCount;
					let weekNumber;
					for (let i = 0; i < res.rows.length; i++) {
						seasonId = res.rows[i].id;
						teamCount = res.rows[i].team_count;
						weekNumber = res.rows[i].week_number;
						seasonObj = new Season(seasonId, teamCount, weekNumber);
						seasonArray.push(seasonObj);
					}
					logger.debug('Retrieved season data.', {seasonArray: JSON.stringify(seasonArray)});
					resolve(seasonArray);
				}
			})
		} catch (err) {
			reject(err);
		}
	});
}

async function loopSeasons(seasonArray) {
	return new Promise((resolve, reject) => {
		logger.debug('Looping through seasons...');
		let requests = seasonArray.map((season) => {
			return new Promise((resolve, reject) => {
				runRankings(season, resolve);
			});
		});
		Promise.all(requests)
			.then(() => resolve());
	});
}

async function runRankings(season, callback) {
	logger.debug('runRankings: ', JSON.stringify(season));
	getScoresMatrix(season)
		.then((scoresMatrix) => calculateRankings(scoresMatrix, season))
		.then((ranksMap) => updateRankTable(ranksMap, season))
		.then(callback);
}

// Retrieve scores data from database & translate into a scores matrix
function getScoresMatrix(season) {
	return new Promise((resolve, reject) => {
		logger.debug('getScoresMatrix', {seasonId: season.id, teamCount: season.teamCount, weekNumber: season.weekNumber});
		let query = 'SELECT team_id, score, opponent_id FROM score WHERE season_id = $1 AND scheduled_ind = 0;';
		let scoresMatrix = newMatrix(season.teamCount, season.teamCount, 0);
		try {
			client.query(query, [season.id], (err, res) => {
				if (err) {
					logger.error('Error occurred during select query on score table.', {error: err.stack});
					throw err;
				} else {
					logger.debug('getScoresMatrix: retrieved scores.', {rows: JSON.stringify(res)});
					let teamId;
					let opponentId;
					let score;
					for (let row of res.rows) {
						logger.debug('getScoresMatrix: working on row: ', {row: JSON.stringify(row)});
						teamId = row.team_id;
						opponentId = row.opponent_id;
						score = row.score;
						scoresMatrix[teamId-1][opponentId-1] += score;
					}
					logger.debug('Created scores matrix', JSON.stringify(scoresMatrix));
					resolve(scoresMatrix);
				}
			});
		} catch (err) {
			reject(err);
		}
	});
}

// Run algorithm on scores matrix to generate "ratings" values
function calculateRankings(scoresMatrix, season) {
	return new Promise((resolve, reject) => {
		logger.debug('calculateRankings');
		// TODO: toggle this transpose
		transpose(scoresMatrix);

		// calculate sum of all scores
		let sumOfScores = 0;
		for (let i = 0; i < scoresMatrix.length; i++) {
			for (let j = 0; j < scoresMatrix[i].length; j++) {
				sumOfScores += scoresMatrix[i][j];
			}
		}

		// divide all elements by sumOfScores
		for (let i = 0; i < scoresMatrix.length; i++) {
			for (let j = 0; j < scoresMatrix[i].length; j++) {
				scoresMatrix[i][j] /= sumOfScores;
			}
		}

		// make sure each row adds up to 1
		let rowSum;
		for (let i = 0; i < scoresMatrix.length; i++) {
			rowSum = 0;
			for (let j = 0; j < scoresMatrix[i].length; j++) {
				rowSum += scoresMatrix[i][j];
			}
			scoresMatrix[i][i] = 1 - rowSum;
		}

		// Square matrix until each row is the same
		// TODO: come up with more robust end condition
		let tol = 0.0000000001;
		while (Math.abs(scoresMatrix[0][0] - scoresMatrix[1][0]) > tol) {
			scoresMatrix = matrixMultiply(scoresMatrix, scoresMatrix);
		}

		// Take the ratings and sort them into a map of rankings
		let ratings = scoresMatrix[0];
		let ranksMap = new Map();	// map to contain key:value::teamId:rank
		let nextTopRating;
		let teamId;
		for (let i = 0; i < ratings.length; i++) {
			nextTopRating = Math.max.apply(Math, ratings);
			teamId = ratings.indexOf(nextTopRating)+1;
			ranksMap.set(teamId-1, {rank: i, rating: nextTopRating});
			ratings[teamId-1] = -1;
		}

		resolve(ranksMap);
	});
}

// Update rankings in rank table
function updateRankTable(ranksMap, season) {
	return new Promise((resolve, reject) => {
		logger.debug('updateRankTable', JSON.stringify(ranksMap));
		let requests = Array.from(ranksMap.keys()).map((key) => {
			let teamId = key+1;
			let seasonId = season.id;
			let weekNumber = season.weekNumber;
			let rank = ranksMap.get(key).rank;
			let rating = ranksMap.get(key).rating;
			let rankingSourceId = 1;	// to correspond to 'MARKOV' in ranking_source table
			let rankObj = new Rank(teamId, seasonId, weekNumber, rank, rating, rankingSourceId);
			return new Promise((resolve, reject) => {
				insertRank(rankObj, resolve);
			});
		});
		Promise.all(requests)
			.then(() => resolve());
	});
}

async function insertRank(rankObj, callback) {
	logger.debug('insertRank', JSON.stringify(rankObj));
	await rankObj.persist();
	callback();
}

main();