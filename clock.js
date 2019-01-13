var request = require('request');	
const { Client } = require('pg');
//var CronJob = require('cron').CronJob;
var twit = require('twit');
var config = require('./config.js');
var Twitter = new twit(config);

var FBS_TWITTER_LU_TBL = 'lu_twitter_fbs';
var NFL_TWITTER_LU_TBL = 'lu_twitter_nfl';

scrape();
// cronJob = new CronJob({
// 	cronTime: "00 00 00 * * *", // runs everyday at midnight.
// 	onTick: scrape(), // scrape newest data, calculate rankings
// 	start: true,
// 	timeZone: 'America/Los_Angeles',
// 	runOnInit: true
// });
//cronJob.start();

function scrape() {
	const client = new Client({
		connectionString: process.env.DATABASE_URL,
		ssl: true,
	});
	
	// scrape data and calculate rankings:

	// NCAA FBS Football:
	var ncaaFBS = function () {
		var promise = new Promise(function(resolve, reject) {
			var gamesURL = 'https://www.masseyratings.com/scores.php?s=300937&sub=11604&all=1&mode=2&format=1';
			var teamsURL = 'https://www.masseyratings.com/scores.php?s=300937&sub=11604&all=1&mode=2&format=2';
			try {
				fetchData(teamsURL, gamesURL, 'ncaa_fbs_rankings');
			}
			catch(err) {
				console.log(err + ": " + err.message);
			}
			finally {
				resolve();
			}
		});
		return promise;
	}

	// NCAA Basketball:
	var ncaaMBB = function () {
		var promise = new Promise(function(resolve, reject) {
			var gamesURL = 'https://www.masseyratings.com/scores.php?s=305972&sub=11590&all=1&mode=2&format=1';
			var teamsURL = 'https://www.masseyratings.com/scores.php?s=305972&sub=11590&all=1&mode=2&format=2';
			try {
				fetchData(teamsURL, gamesURL, 'ncaa_basketball_rankings');
			}
			catch(err) {
				console.log(err + ": " + err.message);
			}
			finally {
				resolve();
			}
		});
		return promise;
	}

	// NBA Basketball: 
	var nbaBB = function () {
		var promise = new Promise(function(resolve, reject) {
			var gamesURL = 'https://www.masseyratings.com/scores.php?s=305191&sub=305191&all=1&mode=2&format=1';
			var teamsURL = 'https://www.masseyratings.com/scores.php?s=305191&sub=305191&all=1&mode=2&format=2';
			try {
				fetchData(teamsURL, gamesURL, 'nba_basketball_rankings');
			}
			catch(err) {
				console.log(err + ": " + err.message);
			}
			finally {
				resolve();
			}
		});
		return promise;
	}

	// NHL Hockey:
	var nhlHockey = function () {
		var promise = new Promise(function(resolve, reject) {
			var gamesURL = 'https://www.masseyratings.com/scores.php?s=305192&sub=305192&all=1&mode=2&format=1';
			var teamsURL = 'https://www.masseyratings.com/scores.php?s=305192&sub=305192&all=1&mode=2&format=2';
			try {
				fetchData(teamsURL, gamesURL, 'nhl_hockey_rankings');
			}
			catch(err) {
				console.log(err + ": " + err.message);
			}
			finally {
				resolve();
			}
		});
		return promise;
	}

	// NFL Football:
	var nflFootball = function () {
		var promise = new Promise(function(resolve, reject) {
			var gamesURL = 'https://www.masseyratings.com/scores.php?s=300936&sub=300936&all=1&mode=2&format=1';
			var teamsURL = 'https://www.masseyratings.com/scores.php?s=300936&sub=300936&all=1&mode=2&format=2';
			try {
				fetchData(teamsURL, gamesURL, 'nfl_football_rankings');
			}
			catch(err) {
				console.log(err + ": " + err.message);
			}
			finally {
				resolve();
			}
		});
		return promise;
	}

	// NCAA Women's Basketball:
	var ncaaWBB = function () {
		var promise = new Promise(function(resolve, reject) {
			var gamesURL = 'https://www.masseyratings.com/scores.php?s=305973&sub=11590&all=1&mode=2&format=1';
			var teamsURL = 'https://www.masseyratings.com/scores.php?s=305973&sub=11590&all=1&mode=2&format=2';
			try {
				fetchData(teamsURL, gamesURL, 'ncaa_womens_basketball_rankings');
			}
			catch(err) {
				console.log(err + ": " + err.message);
			}
			finally {
				resolve();
			}
		});
		return promise;
	}

	// MLB Baseball:
	var mlbBaseball = function () {
		var promise = new Promise(function(resolve, reject) {
			var gamesURL = 'https://www.masseyratings.com/scores.php?s=294524&sub=14342&all=1&mode=3&format=1';
			var teamsURL = 'https://www.masseyratings.com/scores.php?s=294524&sub=14342&all=1&mode=3&format=2';
			try {
				fetchData(teamsURL, gamesURL, 'mlb_baseball_rankings');
			}
			catch(err) {
				console.log(err + ": " + err.message);
			}
			finally {
				resolve();
			}
		});
		return promise;
	}

	ncaaFBS()
		.then(ncaaMBB)
		.then(nbaBB)
		.then(nhlHockey)
		.then(nflFootball)
		.then(ncaaWBB)
		.then(mlbBaseball);
}

function getTwitterHandle(teamName, luTblName, callback) {
	const client = new Client({
		connectionString: process.env.DATABASE_URL,
		ssl: true,
	});
	client.connect();
	var twitterHandle = '';
	client.query('SELECT twitter_handle FROM ' + luTblName + ' WHERE team_name = \'' + teamName + '\';', (err, res) => {
		console.log(teamName);
		console.log(res);
		if (err) throw err;
		twitterHandle = res.rows[0].twitter_handle;
		client.end();
		console.log(twitterHandle);
		callback(twitterHandle);
	});
}

function tweetTopTen(rankings, luTblName) {
	let league = luTblName.substring(luTblName.indexOf("LU_TWITTER_") + "LU_TWITTER_".length + 1, luTblName.length).toUpperCase();
	getTwitterHandle(rankings[0]["Team"], luTblName, (twitter1) => {
		getTwitterHandle(rankings[1]["Team"], luTblName, (twitter2) => {
			getTwitterHandle(rankings[2]["Team"], luTblName, (twitter3) => {
				getTwitterHandle(rankings[3]["Team"], luTblName, (twitter4) => {
					getTwitterHandle(rankings[4]["Team"], luTblName, (twitter5) => {
						getTwitterHandle(rankings[5]["Team"], luTblName, (twitter6) => {
							getTwitterHandle(rankings[6]["Team"], luTblName, (twitter7) => {
								getTwitterHandle(rankings[7]["Team"], luTblName, (twitter8) => {
									getTwitterHandle(rankings[8]["Team"], luTblName, (twitter9) => {
										getTwitterHandle(rankings[9]["Team"], luTblName, (twitter10) => {
											var tweetMessage = 'This week\'s ' + league + ' Top Ten:\n'
												+ '1: @' + twitter1 + '\n'
												+ '2: @' + twitter2 + '\n'
												+ '3: @' + twitter3 + '\n'
												+ '4: @' + twitter4 + '\n'
												+ '5: @' + twitter5 + '\n'
												+ '6: @' + twitter6 + '\n'
												+ '7: @' + twitter7 + '\n'
												+ '8: @' + twitter8 + '\n'
												+ '9: @' + twitter9 + '\n'
												+ '10: @' + twitter10 + '\n'
												+ 'Full Rankings: markov-rankings.herokuapp.com';
											Twitter.post('statuses/update', { status: tweetMessage }, function(err, data, response) {
												console.log('Tweeted FBS rankings.');
											});
										});
									});
								});
							});
						});
					});
				});
			});
		});
	});

	/*
	var tweetMessage = 'This week\'s FBS Top Ten:\n'
		+ '1: @' + getTwitterHandle(rankings[0]["Team"], (twitterHandle) => {return twitterHandle}) + '\n'
		+ '2: @' + getTwitterHandle(rankings[1]["Team"], (twitterHandle) => {return twitterHandle}) + '\n'
		+ '3: @' + getTwitterHandle(rankings[2]["Team"], (twitterHandle) => {return twitterHandle}) + '\n'
		+ '4: @' + getTwitterHandle(rankings[3]["Team"], (twitterHandle) => {return twitterHandle}) + '\n'
		+ '5: @' + getTwitterHandle(rankings[4]["Team"], (twitterHandle) => {return twitterHandle}) + '\n'
		+ '6: @' + getTwitterHandle(rankings[5]["Team"], (twitterHandle) => {return twitterHandle}) + '\n'
		+ '7: @' + getTwitterHandle(rankings[6]["Team"], (twitterHandle) => {return twitterHandle}) + '\n'
		+ '8: @' + getTwitterHandle(rankings[7]["Team"], (twitterHandle) => {return twitterHandle}) + '\n'
		+ '9: @' + getTwitterHandle(rankings[8]["Team"], (twitterHandle) => {return twitterHandle}) + '\n'
		+ '10: @' + getTwitterHandle(rankings[9]["Team"], (twitterHandle) => {return twitterHandle}) + '\n'
		+ 'Full Rankings: markov-rankings.herokuapp.com';
	Twitter.post('statuses/update', { status: tweetMessage }, function(err, data, response) {
		console.log('Tweeted FBS rankings.');
	});
	*/
}

function sendToDatabase(rankings, league) {
	const client = new Client({
		connectionString: process.env.DATABASE_URL,
		ssl: true,
	});
	client.connect();
	client.query('CREATE TABLE IF NOT EXISTS ' + league + ' (id SERIAL PRIMARY KEY, date_retrieved TIMESTAMP, rankings TEXT);', (err, res) => {
		console.log(league + 'table');
		if (err) throw err;
		client.query('INSERT INTO ' + league + ' (date_retrieved, rankings) VALUES (now(), $1)', [JSON.stringify(rankings)], (err, res) => {
			if (err) throw err;
			client.end();
		});
	});
}

function fetchData(teamsURL, scoresURL, league) {
	console.log("Start " + league);
	request(scoresURL, function (error, response, body) {
		if (error) {
			console.log(error);
		} else {
			data = body;
			data = data.split(/,[ ]*|[\n]/);
			var scores = []; 
			/* scores format:
				[
					{
						"Team": int >= 0, 
						"Team Venue": 'Home' or 'Away' (string), 
						"Team Score": int >= 0, 
						"Opponent"; int >= 0,
						"Opponent Venue": 'Home' or 'Away' (string), 
						"Opponent Score": int >= 0
					}, 
					...(for each game)
				]
			*/
			for (var i = 0; i < data.length; i++) {
				if (i % 8 === 0) { // not sure what this number from the data represents? Game ID maybe?
					continue;
				} else if (i % 8 === 1) { // Date of game
					continue;
				} else if (i % 8 === 2) { // Team id
					scores.push({});
					scores[scores.length - 1]["Team"] = parseInt(data[i]) - 1;
				} else if (i % 8 === 3) { // Team venue (i.e. Home, Away, Neutral)
					var venue;
					if (data[i] === '1') {
						venue = "Home";
					} else if (data[i] === '-1') {
						venue = "Away";
					} else if (data[i] === '0') {
						venue = "Neutral";
					} else {
						venue = "N/A";
					}
					scores[scores.length - 1]["Team Venue"] = venue;
				} else if (i % 8 === 4) { // Team score
					scores[scores.length - 1]["Team Score"] = parseInt(data[i]);
				} else if (i % 8 === 5) { // Opponent id
					scores[scores.length - 1]["Opponent"] = parseInt(data[i]) - 1;
				} else if (i % 8 === 6) {
					var venue;
					if (data[i] === '1') {
						venue = "Home";
					} else if (data[i] === '-1') {
						venue = "Away";
					} else if (data[i] === '0') {
						venue = "Neutral";
					} else {
						venue = "N/A";
					}
					scores[scores.length - 1]["Opponent Venue"] = venue;
				} else if (i % 8 === 7) {
					scores[scores.length - 1]["Opponent Score"] = parseInt(data[i]);
				}
			}
			request(teamsURL, function (error2, response2, body2) {
				body2 = body2.split(/,[ ]*|[\n]/);
				var teamNameToId = {};
				/* teamNameToId format: 
					(Two-Way Map)
					{
						"map": {
							string: int >= 0, 
							...(for each team)
							},
						"reverseMap": {
							int >= 0: string,
							...(for each team)
							}
					}
				*/
				for (var i = 1; i < body2.length; i += 2) {
					teamName = body2[i];
					teamId = parseInt(body2[i-1]) - 1;
					teamNameToId[teamName] = teamId;
				}
				var teamNameToId = new TwoWayMap(teamNameToId);
				try {
					var rankings = calculateRankings(scores, teamNameToId);
					// send rankings to database
					sendToDatabase(rankings, league);
					/*
					// send to Twitter
					var today = new Date();
					var dayOfTheWeek = today.getDay();
					if (dayOfTheWeek === 0 && league === 'ncaa_fbs_rankings') {
						console.log("Tweeting FBS rankings...");
						tweetTopTen(rankings, FBS_TWITTER_LU_TBL);
					}
					if (dayOfTheWeek === 2 && league === 'nfl_football_rankings') {
						console.log("Tweeting NFL rankings...");
						tweetTopTen(rankings, NFL_TWITTER_LU_TBL);
					}
					*/
				}
				catch(err) {
					console.log(err + ": " + err.message);
				}
			});
		}
	});
	console.log("End " + league);
}

function calculateRankings(data, teamNameToId) {
	teamCount = Object.keys(teamNameToId.map).length;
	//Convert scores to matrix:
	var ScoresMatrix = makeArray(teamCount, teamCount, 0);
	var NumOfMatches = makeArray(teamCount, teamCount, 0);
	var WinLossRecords = makeArray(teamCount, 3, 0);
	for (var i = 0; i < data.length; i++) {
		row = data[i];
		teamId = row["Team"];
		opponentId = row["Opponent"];
		NumOfMatches[teamId][opponentId]++;
		ScoresMatrix[teamId][opponentId] += row["Team Score"];
		//ScoresMatrix[teamId][opponentId] = (ScoresMatrix[teamId][opponentId]*(NumOfMatches[teamId][opponentId] - 1) + row["Team Score"]) / NumOfMatches[teamId][opponentId];
		NumOfMatches[opponentId][teamId]++;
		ScoresMatrix[opponentId][teamId] += row["Opponent Score"];
		//ScoresMatrix[opponentId][teamId] = (ScoresMatrix[opponentId][teamId]*(NumOfMatches[opponentId][teamId] - 1) + row["Opponent Score"]) / NumOfMatches[opponentId][teamId];
		if (row["Team Score"] > row["Opponent Score"]) {
			WinLossRecords[teamId][0]++;
			WinLossRecords[opponentId][1]++;
		} else if (row["Team Score"] < row["Opponent Score"]) {
			WinLossRecords[teamId][1]++;
			WinLossRecords[opponentId][0]++;
		} else {
			WinLossRecords[teamId][2]++;
			WinLossRecords[opponentId][2]++;
		}
	}
	transpose(ScoresMatrix);

	// Create the Random Walk Probability Matrix:
	ProbabilityMatrix = makeArray(teamCount, teamCount, 0);
	sumOfScores = 0;
	for (var i = 0; i < ScoresMatrix.length; i++) {
		for (var j = 0; j < ScoresMatrix[i].length; j++) {
			sumOfScores += ScoresMatrix[i][j];
		}
	}
	for (var i = 0; i < ScoresMatrix.length; i++) {
		for (var j = 0; j < ScoresMatrix[i].length; j++) {
			ProbabilityMatrix[i][j] = ScoresMatrix[i][j] / sumOfScores;
		}
	}

	for (var i = 0; i < ProbabilityMatrix.length; i++) {
		var rowSum = 0;
		for (var j = 0; j < ProbabilityMatrix[i].length; j++) {
			rowSum += ProbabilityMatrix[i][j];
		}
		ProbabilityMatrix[i][i] = 1 - rowSum;
	}

	var Ratings = matrixMultiply(ProbabilityMatrix, ProbabilityMatrix);
	var tol = 0.0000000001
	while (Math.abs(Ratings[0][0] - Ratings[1][0]) > tol) { // could come up with a more robust end condition
		Ratings = matrixMultiply(Ratings, Ratings);
	}
	Ratings = Ratings[0];
	var Standings = {};
	var topRating, id, name, record;
	for (var i = 0; i < Ratings.length; i++) {
		Standings[i] = {};
		topRating = Math.max.apply(Math, Ratings);
		id = Ratings.indexOf(topRating);
		name = teamNameToId.revGet(id);
		Standings[i]["Team"] = name;
		Ratings[id] = -1;
		// Add Win-Loss Record: 
		record = "(" + WinLossRecords[id][0] + "-" + WinLossRecords[id][1];
		if (WinLossRecords[id][2] === 0) {
			record += ")";
		} else {
			record += "-" + WinLossRecords[id][2] + ")";
		}
		Standings[i]["Record"] = record; 
	}
	return Standings;
}

function TwoWayMap(map) {
	this.map = map;
	this.reverseMap = {};
	for (var key in map) {
		var value = map[key];
		this.reverseMap[value] = key;
	}
}
TwoWayMap.prototype.get = function(key) { return this.map[key]; };
TwoWayMap.prototype.revGet = function(key) { return this.reverseMap[key]; };

function makeArray(m, n, val) {
	var arr = [];
	for (var i = 0; i < m; i++) {
		arr[i] = [];
		for (var j = 0; j < n; j++) {
			arr[i][j] = val;
		}
	}
	return arr;
}

function transpose(arr) {
	for (var i = 0; i < arr.length; i++) {
		for (var j = 0; j < i; j++) {
			var temp = arr[i][j];
			arr[i][j] = arr[j][i];
			arr[j][i] = temp;
		}
	}
}

function matrixMultiply(A, B) {
	var C = makeArray(A.length, B[0].length, 0);
	for (var i = 0; i < C.length; i++) {
		for (var j = 0; j < C[i].length; j++) {
			for (var k = 0; k < C.length; k++) {
				C[i][j] += A[i][k] * B[k][j];
			}
		}
	}
	return C;
}