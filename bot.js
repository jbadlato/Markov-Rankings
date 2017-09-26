var request = require('request');
const { Client } = require('pg');
const client = new Client({
	connectionString: process.env.DATABASE_URL,
	ssl: true,
});

module.exports = {
	start: function () {
		client.connect();
		client.query('SELECT table_schema, table_name FROM information_schema.tables;', (err, res) => {
			if (err) throw err;
			for (let row of res.rows) {
				console.log(JSON.stringify(row));
			}
			client.end();
		});

		// scrape data and calculate rankings
		console.log('bot.start() function');
		// NCAA FBS Football:
		var gamesURL = 'https://www.masseyratings.com/scores.php?s=295489&sub=11604&all=1&mode=2&format=1';
		var teamsURL = 'https://www.masseyratings.com/scores.php?s=295489&sub=11604&all=1&mode=2&format=2';
		fetchData(teamsURL, gamesURL, 'NCAAFBS');

		// NCAA Basketball:
		var gamesURL = 'https://www.masseyratings.com/scores.php?s=292154&sub=11590&all=1&mode=2&format=1';
		var teamsURL = 'https://www.masseyratings.com/scores.php?s=292154&sub=11590&all=1&mode=2&format=2';
		fetchData(teamsURL, gamesURL, 'NCAABB');
	}
	saveData: function () {
		// save rankings to database
	}
};

function fetchData(teamsURL, scoresURL, league) {
	request(scoresURL, function (error, response, body) {
		if (error) {
			console.log(error);
		} else {
			data = body
			data = data.split(/,[ ]*|[\n]/);
			var scores = [];
			for (var i = 0; i < data.length; i++) {
				if (i % 8 === 0) { // not sure what this number from the data represents?
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
				for (var i = 1; i < body2.length; i += 2) {
					teamName = body2[i];
					teamId = parseInt(body2[i-1]) - 1;
					teamNameToId[teamName] = teamId;
				}
				var teamNameToId = new TwoWayMap(teamNameToId);
				var rankings = calculateRankings(scores, teamNameToId);
				// send rankings to database
				if (league === 'NCAAFBS') {
					// send to NCAA FBS Football database
				} else if (league === 'NCAABB') {
					// send to NCAA Basketball database
				}
			});
		}
	});
}

function calculateRankings(data, teamNameToId) {
	teamCount = Object.keys(teamNameToId.map).length;
	//Convert scores to matrix:
	var ScoresMatrix = makeArray(teamCount, teamCount, 0);
	var NumOfMatches = makeArray(teamCount, teamCount, 0);
	for (var i = 0; i < data.length; i++) {
		row = data[i];
		teamId = row["Team"];
		opponentId = row["Opponent"];
		NumOfMatches[teamId][opponentId]++;
		ScoresMatrix[teamId][opponentId] = (ScoresMatrix[teamId][opponentId]*(NumOfMatches[teamId][opponentId] - 1) + row["Team Score"]) / NumOfMatches[teamId][opponentId];
		NumOfMatches[opponentId][teamId]++;
		ScoresMatrix[opponentId][teamId] = (ScoresMatrix[opponentId][teamId]*(NumOfMatches[opponentId][teamId] - 1) + row["Opponent Score"]) / NumOfMatches[opponentId][teamId];
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
	var topRating, id, name;
	for (var i = 0; i < Ratings.length; i++) {
		topRating = Math.max.apply(Math, Ratings);
		id = Ratings.indexOf(topRating);
		name = teamNameToId.revGet(id);
		Standings[i] = name;
		Ratings[id] = -1;
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