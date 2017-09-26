var express = require('express');
var app = express();
const { Client } = require('pg');

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

app.get("/college-football", function (req, res) {
	console.log('college football get request');
	const client = new Client({
		connectionString: process.env.DATABASE_URL,
		ssl: true,
	});
	client.connect();
	client.query('SELECT * FROM ncaa_fbs_rankings ORDER BY date_retrieved DESC LIMIT 1', (err, res2) => {
		if (err) throw err;
		console.log('retrieved most recent fbs rankings. sending...');
		res.send(res2);
		client.end();
	});
});

app.get("/college-basketball", function (req, res) {
	console.log('college basketball get request');
	const client = new Client({
		connectionString: process.env.DATABASE_URL,
		ssl: true,
	});
	client.connect();
	client.query('SELECT * FROM ncaa_fbs_rankings ORDER BY date_retrieved DESC LIMIT 1', (err, res2) => {
		if (err) throw err;
		console.log('retrieved most recent ncaa BB rankings. sending...');
		res.send(res2);
		client.end();
	});
});