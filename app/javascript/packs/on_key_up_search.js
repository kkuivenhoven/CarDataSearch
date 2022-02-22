window.showGetResult = function(name) {
	var result = null;
	var scriptUrl = "/coche_datos/buscar_latest_autocomplete.json?q=chev"; // + name;
	$.ajax({
		url: scriptUrl,
		type: 'GET',
		dataType: 'json',
		async: false,
		success: function(data) {
			result = data;
		}
	});
	return result;	
}

/*
window.postGetResult = function(sendThisJson) {
	var result = null;
	var dictionary = {};
	// dictionary["SearchResults"] = sendThisJson;
	// var scriptUrl = "/statics/execute_search";
	var scriptUrl = "/statics/retrieve_searches";
  var myObj = {"name":"John", "age":30, "car":null};

	console.log("send this json: " + sendThisJson);
		
	$.ajax({
		type: 'POST',
		url: scriptUrl,
		dataType: 'JSON',
		data: myObj, 
		async: false,
	  success: function(data) {
			result = "success";
		}
	});
	return result;
} */


$(document).on('turbolinks:load', function() {
	$('input[name="renovated_search"]').on('keyup', function(event) {
		var newValue = $("#renovated_search").val();

		var result = null;
		var dictionary = {};
		var scriptUrl = "/statics/retrieve_searches";
		var myObj = {"SearchPhrase": newValue};

		event.stopPropagation(); // need this?

		Rails.ajax({
			type: "POST",
			url: scriptUrl,
			data: new URLSearchParams(myObj).toString()
		});
			
	});
});


