window.getPostUrls = function() {
  var dict = {
		"00000": "noCar_noOrigin_noYear_noMpg_noHorsepower",
		"00001": "noCar_noOrigin_noYear_noMpg_yesHorsepower",
		"00010": "noCar_noOrigin_noYear_yesMpg_noHorsepower",
		"00011": "noCar_noOrigin_noYear_yesMpg_yesHorsepower",
		"00100": "noCar_noOrigin_yesYear_noMpg_noHorsepower",
		"00101": "noCar_noOrigin_yesYear_noMpg_yesHorsepower",
		"00110": "noCar_noOrigin_yesYear_yesMpg_noHorsepower",
		"00111": "noCar_noOrigin_yesYear_yesMpg_yesHorsepower",
		"01000": "noCar_yesOrigin_noYear_noMpg_noHorsepower",
		"01001": "noCar_yesOrigin_noYear_noMpg_yesHorsepower",
		"01010": "noCar_yesOrigin_noYear_yesMpg_noHorsepower",
		"01011": "noCar_yesOrigin_noYear_yesMpg_yesHorsepower",
		"01100": "noCar_yesOrigin_yesYear_noMpg_noHorsepower",
		"01101": "noCar_yesOrigin_yesYear_noMpg_yesHorsepower",
		"01110": "noCar_yesOrigin_yesYear_yesMpg_noHorsepower",
		"01111": "noCar_yesOrigin_yesYear_yesMpg_yesHorsepower",
		"10000": "yesCar_noOrigin_noYear_noMpg_noHorsepower",
		"10001": "yesCar_noOrigin_noYear_noMpg_yesHorsepower",
		"10010": "yesCar_noOrigin_noYear_yesMpg_noHorsepower",
		"10011": "yesCar_noOrigin_noYear_yesMpg_yesHorsepower",
		"10100": "yesCar_noOrigin_yesYear_noMpg_noHorsepower",
		"10101": "yesCar_noOrigin_yesYear_noMpg_yesHorsepower",
		"10110": "yesCar_noOrigin_yesYear_yesMpg_noHorsepower",
		"10111": "yesCar_noOrigin_yesYear_yesMpg_yesHorsepower",
		"11000": "yesCar_yesOrigin_noYear_noMpg_noHorsepower",
		"11001": "yesCar_yesOrigin_noYear_noMpg_yesHorsepower",
		"11010": "yesCar_yesOrigin_noYear_yesMpg_noHorsepower",
		"11011": "yesCar_yesOrigin_noYear_yesMpg_yesHorsepower",
		"11100": "yesCar_yesOrigin_yesYear_noMpg_noHorsepower",
		"11101": "yesCar_yesOrigin_yesYear_noMpg_yesHorsepower",
		"11110": "yesCar_yesOrigin_yesYear_yesMpg_noHorsepower",
		"11111": "yesCar_yesOrigin_yesYear_yesMpg_yesHorsepower",
	};
	
	return dict;
}


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


window.whichPostUrl = function(carNameVal, originNameVal, yearVal, mpgVal, horsePowerVal) {
	var lenCarName = ((carNameVal.length > 0)? '1' : '0');
	var lenOriginName = ((originNameVal.length > 0)? '1' : '0');
	var lenYear = ((yearVal.length > 0)? '1' : '0');
	var lenMpg = ((mpgVal.length > 0)? '1' : '0');
	var lenHorsePower = ((horsePowerVal.length > 0)? '1' : '0');

	var digitKeyForUrl = (lenCarName + lenOriginName + lenYear + lenMpg + lenHorsePower);
	var allKeyUrls = getPostUrls();

	var urlToPost = allKeyUrls[digitKeyForUrl];

	// alert(" url to post: " + urlToPost);
	return urlToPost;
}


$(document).on('turbolinks:load', function() {
	$('input[name="car_name_val"]').on('keyup', function(event) {
		var carNameVal = $("#car_name_val").val();
		var originNameVal = $("#country_origin").val();
		var yearVal = $("#year_val").val();
		var mpgVal = $("#mpg_val").val();
		var horsePowerVal = $("#horsepower_val").val();

		var result = null;
		var dictionary = {};
		// var scriptUrl = "/statics/retrieve_searches";
		var myObj = {"carName": carNameVal, "originName": originNameVal};

		// var scriptUrl = "/statics/" + whichPostUrl(carNameVal, originNameVal, yearVal, mpgVal, horsePowerVal);
		var scriptUrl = "/coche_datos/" + whichPostUrl(carNameVal, originNameVal, yearVal, mpgVal, horsePowerVal);

		// alert("originNameVal: " + (originNameVal.length));

		event.stopPropagation(); // need this?

		Rails.ajax({
			type: "POST",
			url: scriptUrl,
			data: new URLSearchParams(myObj).toString()
		});
			
	});

	$('input[name="country_origin"]').on('keyup', function(event) {
		var carNameVal = $("#renovated_search").val();
		var originNameVal = $("#country_origin").val();

		var result = null;
		var dictionary = {};
		var scriptUrl = "/statics/post_car_name";
		var myObj = {"carName": carNameVal, "originName": originNameVal};

		// alert("hello!");

		event.stopPropagation(); // need this?

		Rails.ajax({
			type: "POST",
			url: scriptUrl,
			data: new URLSearchParams(myObj).toString()
		});
	});
});


