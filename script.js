$(document).ready(function() {
	$("#recalculate").click(function() {
		$.get("/getData", function(data, status) {
			console.log(JSON.stringify(data));
			$("#standings").empty();
			for (var i = 0; i < Object.keys(data).length; i++) {
				$("#standings").append('<li>' + data[i] + '</li>');
			}
		});
	});
});

