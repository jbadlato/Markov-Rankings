$(document).ready(function() {
	$("#college_football").click(function() {
		$.get("/college-football", function(data, status) {
			console.log(JSON.stringify(data));
			$("#standings").empty();
			for (var i = 0; i < Object.keys(data).length; i++) {
				$("#standings").append('<li>' + data[i] + '</li>');
			}
		});
	});
	$("#college_basketball").click(function() {
		$.get("/college-basketball", function(data, status) {
			console.log(JSON.stringify(data));
			$("#standings").empty();
			for (var i = 0; i < Object.keys(data).length; i++) {
				$("#standings").append('<li>' + data[i] + '</li>');
			}
		})
	});
});

