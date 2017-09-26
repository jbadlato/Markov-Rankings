$(document).ready(function() {
	$("#college_football").click(function() {
		$.get("/college-football", function(data, status) {
			res = data.rows[0];
			rankings = JSON.parse(res.rankings);
			$("#standings").empty();
			$("#last_calculated").text('Last Calculated: ' + res.date_retrieved);
			for (var i = 0; i < Object.keys(rankings).length; i++) {
				$("#standings").append('<li>' + rankings[i] + '</li>');
			}
		});
	});
	$("#college_basketball").click(function() {
		$.get("/college-basketball", function(data, status) {
			res = data.rows[0];
			rankings = JSON.parse(res.rankings);
			$("#standings").empty();
			$("#last_calculated").text('Last Calculated: ' + res.date_retrieved);
			for (var i = 0; i < Object.keys(rankings).length; i++) {
				$("#standings").append('<li>' + rankings[i] + '</li>');
			}
		})
	});
});

