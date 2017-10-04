function printRankings(data, status) {
	res = data.rows[0];
	rankings = JSON.parse(res.rankings);
	$('#standings').empty();
	$('#last_calculated').text('Last Calculated: ' + res.date_retrieved);
	for (var i = 0; i < Object.keys(rankings).length; i++) {
		$('#standings').append('<li>' + rankings[i].replace(/_/g," ") + '</li>');
	}
}

$(document).ready(function() {
	$("#college_football").click(function() {
		$.get("/college-football", function (data, status) {
			printRankings(data, status);
		});
	});
	$("#college_basketball").click(function() {
		$.get("/college-basketball", function (data, status) {
			printRankings(data, status);
		});
	});
	$('#nba_basketball').click(function() {
		$.get("/nba-basketball", function (data, status) {
			printRankings(data, status);
		});
	});
	$('#nhl_hockey').click(function() {
		$.get("/nhl-hockey", function (data, status) {
			printRankings(data, status);
		});
	});
	$('#nfl_football').click(function() {
		$.get("/nfl-football", function (data, status) {
			printRankings(data, status);
		});
	});
	$('#college_basketball_womens').click(function() {
		$.get("/college-basketball-womens", function (data, status) {
			printRankings(data, status);
		});
	});
	$('#mlb_baseball').click(function() {
		$.get("/mlb-baseball", function (data, status) {
			printRankings(data, status);
		});
	});
});