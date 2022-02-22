$(document).on('turbolinks:load', function() {
	$("#item").click(function() {
		let url="/statics/retrieve_searches/";
		var hello = "hello_world";
	
		$.ajax({
			url: url, 
			data: hello,
			success: function(data) {
				console.log("success");
			},
			error: function() {
				console.log("failure");
			}
		});
	});
});

