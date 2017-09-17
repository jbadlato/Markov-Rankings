var express = require('express');
var app = express();

app.set('port', (process.env.PORT || 5000));

app.use(express.static(__dirname));

// views is directory for all template files
app.set('views', __dirname);
app.set('view engine', 'ejs');

app.get('/', function(request, response) {
	response.render('index');
});

app.listen(app.get('port'), function () {
	console.log('Node app is running on port', app.get('port'));
});

XLSX = require('xlsx');

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

app.get("/getData", function (req, res) {
	var workbook = XLSX.readFile('2017 Game Results Data.xlsx');
	var worksheet = workbook.Sheets['Sheet1'];
	var headers = {};
	var data = [];
	for (z in worksheet) {
		if (z[0] === '!') continue;
		//parse out the column, row, and value
		var tt = 0;
		for (var i = 0; i < z.length; i++) {
			if (!isNaN(z[i])) {
				tt = i;
				break;
			}
		};
		var col = z.substring(0, tt);
		var row = parseInt(z.substring(tt));
		var value = worksheet[z].v;

		//store header names
		if(row == 1 && value) {
			headers[col] = value;
			continue;
		}

		if(!data[row]) data[row]={};
		data[row][headers[col]] = value;
	}
	//drop those first two rows which are empty
	data.shift();
	data.shift();

	//Number each team:
	teamId = 0;
	map = {};
	for (i = 0; i < data.length; i++) {
		row = data[i];
		teamName = row["Team"];
		if (!(teamName in map)) {
			map[teamName] = teamId;
			teamId++;
		}
	}
	var teamNameToId = new TwoWayMap(map);
	var teamCount = Object.keys(teamNameToId.map).length;

	//Convert scores to matrix:
	var ScoresMatrix = makeArray(teamCount, teamCount, 0);
	var NumOfMatches = makeArray(teamCount, teamCount, 0);
	for (var i = 0; i < data.length; i++) {
		row = data[i];
		if (row["Game Type"] !== "Division 1") {
			continue;
		}
		team = row["Team"];
		opponent = row["Opponent"];
		teamId = teamNameToId.get(team);
		opponentId = teamNameToId.get(opponent);
		NumOfMatches[teamId][opponentId]++;
		ScoresMatrix[teamId][opponentId] = (ScoresMatrix[teamId][opponentId]*(NumOfMatches[teamId][opponentId] - 1) + row["Team Score"]) / NumOfMatches[teamId][opponentId];
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
	console.log('done');
	res.send(Standings);
});