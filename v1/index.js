var express = require('express');
var app = express();
const { Client } = require('pg');

app.set('port', (process.env.PORT || 5000));

app.use(express.static(__dirname));

app.listen(app.get('port'), function () {
	console.log('Node app is running on port', app.get('port'));
});

app.get('/', function(request, response) {
	response.sendFile(__dirname + '/views/index.html');
});

app.get('/learn-more', function(request, response) {
	response.sendFile(__dirname + '/views/learn_more.html')
})


function sendRankings(res, league) {
	const client = new Client({
		connectionString: process.env.DATABASE_URL,
		ssl: true,
	});
	client.connect();
	client.query('SELECT * FROM ' + league + ' ORDER BY date_retrieved DESC LIMIT 1', (err, res2) => {
		if (err) throw err;
		res.send(res2);
		client.end();
	});
}

app.get("/college-football", function (req, res) {
	sendRankings(res, 'ncaa_fbs_rankings');
});

app.get("/college-basketball", function (req, res) {
	sendRankings(res, 'ncaa_basketball_rankings');
});

app.get("/nba-basketball", function (req, res) {
	sendRankings(res, 'nba_basketball_rankings');
});

app.get("/nhl-hockey", function (req, res) {
	sendRankings(res, 'nhl_hockey_rankings');
});

app.get("/nfl-football", function (req, res) {
	sendRankings(res, 'nfl_football_rankings');
});

app.get("/college-basketball-womens", function (req, res) {
	sendRankings(res, 'ncaa_womens_basketball_rankings');
});

app.get("/mlb-baseball", function (req, res) {
	sendRankings(res, 'mlb_baseball_rankings');
});