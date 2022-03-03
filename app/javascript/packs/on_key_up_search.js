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


window.gatherHorsepowerInput = function(horsepowerVal) {
	var gatheredVals = {};
	$("#horsepower_fields_container").find('input[type="number"]').each(function(index, elem){
		if(elem.name == "horsepower_input") {
			if(elem.value.length == 0) {
				gatheredVals["horsepowerLower"] = "50";
			} else {
				gatheredVals["horsepowerLower"] = elem.value;
			}
		} 
		if(elem.name == "horsepower_two_input") {
			if(elem.value.length == 0) {
				gatheredVals["horsepowerHigher"] = "500";
			} else {
				gatheredVals["horsepowerHigher"] = elem.value;
			}
		}
	});
	return gatheredVals; 
}

window.gatherMpgInput = function(mpgVal) {
	var gatheredVals = {};
	$("#mpg_fields_container").find('input[type="number"]').each(function(index, elem){
		if(elem.name == "MPG_input") {
			if(elem.value.length == 0) {
				gatheredVals["mpgLower"] = "1";
			} else {
				gatheredVals["mpgLower"] = elem.value;
			}
		} 
		if(elem.name == "MPG_two_input") {
			if(elem.value.length == 0) {
				gatheredVals["mpgHigher"] = "50";
			} else {
				gatheredVals["mpgHigher"] = elem.value;
			}
		}
	});
	return gatheredVals; 
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


window.whichPostUrl = function(carNameVal, originNameVal, yearVal, mpgVal, horsepowerVal) {
	var lenCarName = ((carNameVal.length > 0)? '1' : '0');
	var lenOriginName = ((originNameVal.length > 0)? '1' : '0');
	var lenYear = ((yearVal.length > 0)? '1' : '0');

	var digitKeyForUrl = (lenCarName + lenOriginName + lenYear + mpgVal + horsepowerVal);
	var allKeyUrls = getPostUrls();

	var urlToPost = allKeyUrls[digitKeyForUrl];
	return urlToPost;
}


$(document).on('turbolinks:load', function() {
	$('input[name="car_name_val"]').on('keyup', function(event) {
		var carNameVal = $("#car_name_val").val();
		var originNameVal = $("#country_origin").val();
		var yearVal = $("#year_val").val();
		var mpgVal = $("#mpg_checkbox").is(":checked");
		var horsepowerVal = $("#horsepower_checkbox").is(":checked");

		var horsepowerInputs = gatherHorsepowerInput(horsepowerVal);
		var mpgInputs = gatherMpgInput(mpgVal);
		var valsToSend = {"carName": carNameVal, "originName": originNameVal, "yearVal": yearVal};
		$.extend(valsToSend,horsepowerInputs);
		$.extend(valsToSend,mpgInputs);

		mpgVal = ((mpgVal == true) ? '1' : '0');
		horsepowerVal = ((horsepowerVal == true) ? '1' : '0');

		var result = null;
		var dictionary = {};
		var myObj = {"carName": carNameVal, "originName": originNameVal};

		var scriptUrl = "/coche_datos/" + whichPostUrl(carNameVal, originNameVal, yearVal, mpgVal, horsepowerVal);

		Rails.ajax({
			type: "POST",
			url: scriptUrl,
			data: new URLSearchParams(myObj).toString()
		});
			
	});

	$('input[name="country_origin"]').on('keyup', function(event) {
		var carNameVal = $("#car_name_val").val();
		var originNameVal = $("#country_origin").val();
		var yearVal = $("#year_val").val();
		var mpgVal = $("#mpg_checkbox").is(":checked");
		var horsepowerVal = $("#horsepower_checkbox").is(":checked");

		var horsepowerInputs = gatherHorsepowerInput(horsepowerVal);
		var mpgInputs = gatherMpgInput(mpgVal);
		var valsToSend = {"carName": carNameVal, "originName": originNameVal, "yearVal": yearVal};
		$.extend(valsToSend,horsepowerInputs);
		$.extend(valsToSend,mpgInputs);

		mpgVal = ((mpgVal == true) ? '1' : '0');
		horsepowerVal = ((horsepowerVal == true) ? '1' : '0');

		var scriptUrl = "/coche_datos/" + whichPostUrl(carNameVal, originNameVal, yearVal, mpgVal, horsepowerVal);

		var result = null;
		var dictionary = {};
		var myObj = {"carName": carNameVal, "originName": originNameVal};

		Rails.ajax({
			type: "POST",
			url: scriptUrl,
			data: new URLSearchParams(myObj).toString()
		});
	});

	$('input[name="horsepower_input"]').on('keyup', function(event) {
		var carNameVal = $("#car_name_val").val();
		var originNameVal = $("#country_origin").val();
		var yearVal = $("#year_val").val();
		var mpgVal = $("#mpg_checkbox").is(":checked");
		var horsepowerVal = $("#horsepower_checkbox").is(":checked");

		var horsepowerInputs = gatherHorsepowerInput(horsepowerVal);
		var mpgInputs = gatherMpgInput(mpgVal);
		var valsToSend = {"carName": carNameVal, "originName": originNameVal, "yearVal": yearVal};
		$.extend(valsToSend,horsepowerInputs);
		$.extend(valsToSend,mpgInputs);

		mpgVal = ((mpgVal == true) ? '1' : '0');
		horsepowerVal = ((horsepowerVal == true) ? '1' : '0');

		var scriptUrl = "/coche_datos/" + whichPostUrl(carNameVal, originNameVal, yearVal, mpgVal, horsepowerVal);

		Rails.ajax({
			type: "POST",
			url: scriptUrl,
			data: new URLSearchParams(valsToSend).toString()
		});
	});

	$('input[name="horsepower_two_input"]').on('keyup', function(event) {
		var carNameVal = $("#car_name_val").val();
		var originNameVal = $("#country_origin").val();
		var yearVal = $("#year_val").val();
		var mpgVal = $("#mpg_checkbox").is(":checked");
		var horsepowerVal = $("#horsepower_checkbox").is(":checked");

		var horsepowerInputs = gatherHorsepowerInput(horsepowerVal);
		var mpgInputs = gatherMpgInput(mpgVal);
		var valsToSend = {"carName": carNameVal, "originName": originNameVal, "yearVal": yearVal};
		$.extend(valsToSend,horsepowerInputs);
		$.extend(valsToSend,mpgInputs);

		mpgVal = ((mpgVal == true) ? '1' : '0');
		horsepowerVal = ((horsepowerVal == true) ? '1' : '0');

		var scriptUrl = "/coche_datos/" + whichPostUrl(carNameVal, originNameVal, yearVal, mpgVal, horsepowerVal);

		Rails.ajax({
			type: "POST",
			url: scriptUrl,
			data: new URLSearchParams(valsToSend).toString()
		});
	});

	$('input[name="year_val"]').on('keyup', function(event) {
		var carNameVal = $("#car_name_val").val();
		var originNameVal = $("#country_origin").val();
		var yearVal = $("#year_val").val();
		var mpgVal = $("#mpg_checkbox").is(":checked");
		var horsepowerVal = $("#horsepower_checkbox").is(":checked");

		var horsepowerInputs = gatherHorsepowerInput(horsepowerVal);
		var mpgInputs = gatherMpgInput(mpgVal);
		var valsToSend = {"carName": carNameVal, "originName": originNameVal, "yearVal": yearVal};
		$.extend(valsToSend,horsepowerInputs);
		$.extend(valsToSend,mpgInputs);

		mpgVal = ((mpgVal == true) ? '1' : '0');
		horsepowerVal = ((horsepowerVal == true) ? '1' : '0');

		var scriptUrl = "/coche_datos/" + whichPostUrl(carNameVal, originNameVal, yearVal, mpgVal, horsepowerVal);

		Rails.ajax({
			type: "POST",
			url: scriptUrl,
			data: new URLSearchParams(valsToSend).toString()
		});
	});

	$('input[name="MPG_input"]').on('keyup', function(event) {
	// $("#mpg_checkbox").click(function() {
		if($("#mpg_checkbox").is(':checked') == true) {
			var carNameVal = $("#car_name_val").val();
			var originNameVal = $("#country_origin").val();
			var yearVal = $("#year_val").val();
			var mpgVal = $("#mpg_checkbox").is(":checked");
			var horsepowerVal = $("#horsepower_checkbox").is(":checked");

			var horsepowerInputs = gatherHorsepowerInput(horsepowerVal);
			var mpgInputs = gatherMpgInput(mpgVal);
			var valsToSend = {"carName": carNameVal, "originName": originNameVal, "yearVal": yearVal};
			$.extend(valsToSend,horsepowerInputs);
			$.extend(valsToSend,mpgInputs);

			mpgVal = ((mpgVal == true) ? '1' : '0');
			horsepowerVal = ((horsepowerVal == true) ? '1' : '0');

			var scriptUrl = "/coche_datos/" + whichPostUrl(carNameVal, originNameVal, yearVal, mpgVal, horsepowerVal);

			Rails.ajax({
				type: "POST",
				url: scriptUrl,
				data: new URLSearchParams(valsToSend).toString()
			});
		}
	});

	$('input[name="MPG_two_input"]').on('keyup', function(event) {
		if($("#mpg_checkbox").is(':checked') == true) {
			var carNameVal = $("#car_name_val").val();
			var originNameVal = $("#country_origin").val();
			var yearVal = $("#year_val").val();
			var mpgVal = $("#mpg_checkbox").is(":checked");
			var horsepowerVal = $("#horsepower_checkbox").is(":checked");

			var horsepowerInputs = gatherHorsepowerInput(horsepowerVal);
			var mpgInputs = gatherMpgInput(mpgVal);
			var valsToSend = {"carName": carNameVal, "originName": originNameVal, "yearVal": yearVal};
			$.extend(valsToSend,horsepowerInputs);
			$.extend(valsToSend,mpgInputs);

			mpgVal = ((mpgVal == true) ? '1' : '0');
			horsepowerVal = ((horsepowerVal == true) ? '1' : '0');

			var scriptUrl = "/coche_datos/" + whichPostUrl(carNameVal, originNameVal, yearVal, mpgVal, horsepowerVal);

			Rails.ajax({
				type: "POST",
				url: scriptUrl,
				data: new URLSearchParams(valsToSend).toString()
			});
		}
	});

});
