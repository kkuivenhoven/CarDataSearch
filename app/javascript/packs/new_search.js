// $("#fname").on("keydown", ".search", function(event) {
	// alert('Here!');
// });

// $("#fname").keyup(function(event) {
	// alert("hello!");
	// $("input").css("background-color", "yellow");
// });

// document.querySelector(".search#name").addEventListener("keydown", (event) => {
  // alert("Here!");
// });

// $(document).keydown(function(event) {
	// alert('You pressed down a key');
// });

/* $(document).ready(function() {
	$("#fname").on("input", function() {
		alert("shalom");
	});
}); */

// $('input[name=fname]').on('keyup', function() {
		// alert("laskdjf");
// });

// $(document).on('change', 'input[name=fname]', function() {
	// alert("ad.fjkadsflk");
// });

/* complete: function() {
	result = "completed";
	// console.log(" completed!");
} */

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
	// $('input[name="carname"]').on('keyup', function(event) {
	$('input[name="renovated_search"]').on('keyup', function(event) {
		// alert("shallmsdf");
		// console.log("sadfjkl");
		// var newValue = $("#fname").val();
		var newValue = $("#renovated_search").val();

		// var resultingJson = showGetResult(newValue);

		var result = null;
		var dictionary = {};
	  // dictionary["SearchResults"] = resultingJson;
	  // dictionary["SearchResults"] = newValue;
		var scriptUrl = "/statics/retrieve_searches";
		// var myObj = {"name":"John", "age":30, "car":null};
		var myObj = {"SearchPhrase": newValue};

		// console.log("send this json: " + sendThisJson);
		event.stopPropagation();

		Rails.ajax({
			type: "POST",
			url: scriptUrl,
			data: new URLSearchParams(myObj).toString()
		});
			
/*
		$.ajax({
			type: 'POST',
			url: scriptUrl,
			// dataType: 'JSON', // only what expect back
			contentType: 'application/json',
			data: myObj, 
			async: false,
			success: function(msg) {
				result = "success";
			}
		});  
*/
		// var postedSuccess = postGetResult(resultingJson);
		// console.log(postedSuccess);

		// var editForm = $("#edit-form")[0];
		// Rails.fire(editForm, 'submit');

		// alert(newValue);
			// url: "/coche_datos/buscar_autocomplete.json?q=" + newValue,

		/* $.get('/coche_datos/buscar_latest_autocomplete.json?q=chev',function(data){
			// data is a JS object parsed from a JSON response
			// alert(data);
			// $("#newVideoNameLabel").text(data);
			$.ajax({
				url: "/statics/execute_search",
				type: "POST",
				data: data,
				success: function(resp) {
					alert("successful post");
				}
		},'json'); */

		/* $.ajax({
			type: 'GET',
			dataType: "json",
			url: "/coche_datos/buscar_latest_autocomplete.json?q=chev",
			success: function(result) {
				alert(result);
				$("#newVideoNameLabel").text(result);
			}
		}); */

	});
});



window.newFunction = function() {
  alert("umm HELLO!");
}

window.callThis = function() {
	alert("sdf");
}
