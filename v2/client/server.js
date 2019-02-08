const express = require('express');
const app = express();
const port = 5000;
let { Client } = require('pg');

const client = new Client({
	connectionString: process.env.DATABASE_URL,
	ssl: true
});

client.connect((err)=> {
	if (err) {
		console.log('Error connecting to database.', {errorStack: err.stack});
	} else {
		console.log('Connected to database successfully.');
	}
});

app.set('port', (process.env.PORT || 5000));

app.use(express.static(__dirname));

app.listen(app.get('port'), function () {
	console.log('Node app is running on port', app.get('port'));
});

app.get('/', function(request, response) {
	response.sendFile(__dirname + '/Frontend/views/home.html');
});

app.get('/league/:id', function(request, response) {

});
	
app.get('/season/:id', function(request, response) {

});

app.get('/team/:id', function(request, response) {

});

app.get('/api/leagues', async function(request, response) {
	// build query to database
	let SQL = "SELECT id, name, logo_file FROM league;";
	await selectQuery(SQL)
		.then((res) => {
	// send list of leagues to client
			response.send(res);
		});
});

app.get('/api/ranks', function(request, response) {
	// get league from URL
	let league = request.query.league;
	// build query to database

	// send rankings to client

});

app.get('/api/schedule', function(request, response) {
	// get league and team from URL
	let league = request.query.league;
	let team = request.query.team;
	// build query to database

	// send schedule to client

});

app.get('/api/teams', function(request, response) {
	// get league from URL
	let league = request.query.league;
	// build query to database

	// send list of teams to client
});

function selectQuery(QUERY) {
	return new Promise((resolve, reject) => {
		try{
			client.query(QUERY, (err, res) => {
				if (err) throw err;
				resolve(res);
			});
		} catch (err) {
			reject(err);
		}
	});
}