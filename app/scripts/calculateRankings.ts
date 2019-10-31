const logger = require('heroku-logger');
import { Matrix } from '../src/Matrix';
import { DatabaseManager } from '../src/DatabaseManager';

let dbManager: DatabaseManager = new DatabaseManager(process.env.BACKEND_DATABASE_URL);

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
		let insertQuery = 'INSERT INTO rank (team_id, season_id, week_number, rank, rating, ranking_source_id, calculated_date) VALUES ($1, $2, $3, $4, $5, $6, $7);';
		return new Promise(async (resolve, reject) => {
			await dbManager.query(insertQuery, [teamId, seasonId, weekNumber, rank, rating, rankingSourceId, CALCULATED_DATE.toUTCString()]);
			resolve();
		})
	}
}

var CALCULATED_DATE;
async function main() {
	CALCULATED_DATE = new Date();
	logger.info('BEGIN: calculateRankings.js');
	await dbManager.connect();
	let seasonArray = await getSeasons()
	await loopSeasons(seasonArray);
	console.log('*************************************************************await over');
	dbManager.disconnect()
		.then(() => logger.info('END: calculateRankings.js'));
}

function getSeasons() {
	// Gets array of season IDs, as well as their associated team counts.
	return new Promise((resolve, reject) => {
		let seasonArray = new Array(0);
		let query = "SELECT season.id AS id, COUNT(team.id) AS team_count, CEIL((CURRENT_DATE::DATE - season_start::DATE)/7.0) AS week_number FROM season INNER JOIN team ON (team.season_id = season.id) WHERE season.week_start = EXTRACT(dow FROM '01-14-2019'::DATE) AND season.season_start <= CURRENT_DATE AND CURRENT_DATE <= season.season_end OR (season.season_start <= CURRENT_DATE AND (SELECT COUNT(*) FROM rank WHERE rank.season_id = season.id) = 0) GROUP BY season.id;";
		dbManager.query(query).then((res) => {
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
		});
	});
}

async function loopSeasons(seasonArray) {
	return new Promise((resolve, reject) => {
		logger.debug('Looping through seasons...');
		let requests = seasonArray.map((season) => {
			return new Promise(async (resolve, reject) => {
				await runRankings(season);
				resolve();
			});
		});
		Promise.all(requests)
			.then(() => {
				console.log('about to resolve loopSeasons');
				resolve();
			});
	});
}

async function runRankings(season) {
	logger.debug('runRankings: ', JSON.stringify(season));
	return new Promise(async (resolve, reject) => {
		let scoresMatrix = await getScoresMatrix(season);
		let ranksMap = await calculateRankings(scoresMatrix, season);
		await updateRankTable(ranksMap, season);
		resolve();
	});
}

// Retrieve scores data from database & translate into a scores matrix
function getScoresMatrix(season) {
	return new Promise((resolve, reject) => {
		logger.debug('getScoresMatrix', {seasonId: season.id, teamCount: season.teamCount, weekNumber: season.weekNumber});
		let query = 'SELECT team_id, score, opponent_id FROM score WHERE season_id = $1 AND scheduled_ind = 0;';
		let scoresMatrix: Matrix = new Matrix(season.teamCount, season.teamCount, 0);
		dbManager.query(query, [season.id]).then((res) => {
			logger.debug('getScoresMatrix: retrieved scores.');
			if (res.rows.length === 0) {
				logger.error('Retrieved zero scores from scores table.');
				return;
			}
			let teamId;
			let opponentId;
			let score;
			for (let row of res.rows) {
				teamId = row.team_id;
				opponentId = row.opponent_id;
				score = row.score;
				scoresMatrix.set(teamId-1, opponentId-1, scoresMatrix.get(teamId-1, opponentId-1) + score);
			}
			logger.debug('Created scores matrix', JSON.stringify(scoresMatrix));
			resolve(scoresMatrix);
		});
	});
}

// Run algorithm on scores matrix to generate "ratings" values
function calculateRankings(scoresMatrix: Matrix, season) {
	return new Promise((resolve, reject) => {
		logger.debug('calculateRankings');
		// TODO: toggle this transpose
		scoresMatrix = scoresMatrix.transpose();

		// calculate sum of all scores
		let sumOfScores = 0;
		for (let i = 0; i < scoresMatrix.getHeight(); i++) {
			for (let j = 0; j < scoresMatrix.getWidth(); j++) {
				sumOfScores += scoresMatrix.get(i,j);
			}
		}

		// divide all elements by sumOfScores
		for (let i = 0; i < scoresMatrix.getHeight(); i++) {
			for (let j = 0; j < scoresMatrix.getWidth(); j++) {
				scoresMatrix.set(i,j, scoresMatrix.get(i,j)/sumOfScores);
			}
		}

		// make sure each row adds up to 1
		let rowSum;
		for (let i = 0; i < scoresMatrix.getHeight(); i++) {
			rowSum = 0;
			for (let j = 0; j < scoresMatrix.getWidth(); j++) {
				rowSum += scoresMatrix.get(i,j);
			}
			scoresMatrix.set(i,i, 1 - rowSum);
		}

		// Square matrix until each row is the same
		// TODO: come up with more robust end condition
		let tol = 0.0000000001;
		while (Math.abs(scoresMatrix.get(0,0) - scoresMatrix.get(1,0)) > tol) {
			scoresMatrix = scoresMatrix.multiply(scoresMatrix);
		}

		// Take the ratings and sort them into a map of rankings
		let ratings: Array<number> = scoresMatrix.getRow(0);
		logger.debug('calculateRankings', JSON.stringify(ratings));
		let ranksMap = new Map();	// map to contain key:value::teamId:rank
		if (!validate(ratings)) {
			resolve(ranksMap);
			return;
		}
		let nextTopRating;
		let teamId;
		for (let i = 0; i < ratings.length; i++) {
			nextTopRating = Math.max.apply(Math, ratings);
			teamId = ratings.indexOf(nextTopRating)+1;
			ranksMap.set(teamId-1, {rank: i+1, rating: nextTopRating});
			ratings[teamId-1] = -1;
		}

		resolve(ranksMap);
	});
}

// validate that ranking calculation didn't fail
function validate(ratings) {
	for (let i = 0; i < ratings.length; i++) {
		if (Number.isNaN(ratings[i])) {
			return false;
		}
	}
	return true;
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
	await rankObj.persist();
	callback();
}

main();
