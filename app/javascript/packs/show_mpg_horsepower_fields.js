window.checkIfTextFieldsFilledOut = function() {
	var carNameVal = $("#car_name_val").val();
	var originNameVal = $("#country_origin").val();
	var yearVal = $("#year_val").val();

}

window.mpgRangeFieldsContainer = function(displayVal) {
  var mpgRangeDiv = document.getElementById('mpg_range_fields_container');
  if(displayVal == "show") {
    mpgRangeDiv.style.display = 'block';
  } 
  if(displayVal == "hide") {
    mpgRangeDiv.style.display = 'none';
  }
}

window.mpgExactFieldsContainer = function(displayVal) {
  var mpgExactDiv = document.getElementById('mpg_exact_fields_container');
  if(displayVal == "show") {
    mpgExactDiv.style.display = 'block';
  } 
  if(displayVal == "hide") {
    mpgExactDiv.style.display = 'none';
  }
}

window.horsepowerRangeFieldsContainer = function(displayVal) {
  var horsepowerRangeDiv = document.getElementById('horsepower_range_fields_container');
  if(displayVal == "show") {
    horsepowerRangeDiv.style.display = 'block';
  } 
	if(displayVal == "hide") {
    horsepowerRangeDiv.style.display = 'none';
  }
}

window.horsepowerExactFieldsContainer = function(displayVal) {
  var horsepowerExactDiv = document.getElementById('horsepower_exact_fields_container');
  if(displayVal == "show") {
    horsepowerExactDiv.style.display = 'block';
	}
	if(displayVal == "hide") {
    horsepowerExactDiv.style.display = 'none';
  }
}

window.hideMPGHorsepowerFields = function() {
  var mpgRangeDiv = document.getElementById('mpg_range_fields_container');
  mpgRangeDiv.style.display = 'none';
  var mpgExactDiv = document.getElementById('mpg_exact_fields_container');
  mpgExactDiv.style.display = 'none';

  var horsepowerRangeDiv = document.getElementById('horsepower_range_fields_container');
  horsepowerRangeDiv.style.display = 'none';
  var horsepowerExactDiv = document.getElementById('horsepower_exact_fields_container');
  horsepowerExactDiv.style.display = 'none';
}

window.disableCheckboxes = function() {
	$("input.mpg_checkbox").attr("disabled", "disabled");
	$("input.horsepower_checkbox").attr("disabled", true);
}

window.selectGroupByValue = function(name, value) {
	const group = document.querySelectorAll(`input[name="${name}"]`);
	const input = [...group].find(el => el.value === value);
	alert(" input: " + input);
	if(input) input.checked = true;
}

window.radioBtnChanged = function() {
	var carNameVal = $("#car_name_val").val();
	var originNameVal = $("#country_origin").val();
	var yearVal = $("#year_val").val();
	var mpgVal = isMPGspecified();
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

window.mpgRadioCheck = function() {
	if($('#none_mpg').is(':checked') === true) {
		var mpgRangeDiv = document.getElementById('mpg_range_fields_container');
		mpgRangeDiv.style.display = 'none';
		var mpgExactDiv = document.getElementById('mpg_exact_fields_container');
		mpgExactDiv.style.display = 'none';
	}
	if($('#exact_mpg').is(':checked') === true) {
		mpgExactFieldsContainer("show");
		mpgRangeFieldsContainer("hide");
		$("#MPG_input").val("");
		$("#MPG_two_input").val("");
	}
	if($('#range_mpg').is(':checked') === true) {
		mpgRangeFieldsContainer("show");
		mpgExactFieldsContainer("hide");
		$("#MPG_exact_val").val("");
	}
	// radioBtnChanged();
}

window.horsepowerRadioCheck = function() {
	if($('#none_horsepower').is(':checked') === true) {
		var horsepowerRangeDiv = document.getElementById('horsepower_range_fields_container');
		horsepowerRangeDiv.style.display = 'none';
		var horsepowerExactDiv = document.getElementById('horsepower_exact_fields_container');
		horsepowerExactDiv.style.display = 'none';
	}
	if($('#exact_horsepower').is(':checked') === true) {
		horsepowerExactFieldsContainer("show");
		horsepowerRangeFieldsContainer("hide");
	}
	if($('#range_horsepower').is(':checked') === true) {
		horsepowerRangeFieldsContainer("show");
		horsepowerExactFieldsContainer("hide");
	}
}

$(document).on('turbolinks:load', function() {
	var curUrl = $(location).attr("pathname");

	if(curUrl == "/coche_datos/search_all_cars") {
		hideMPGHorsepowerFields();
		$('input:radio[name="mpg_value"][value="mpg_none"]').prop('checked', true);
		$('input:radio[name="horsepower_value"][value="horsepower_none"]').prop('checked', true);

		var scriptUrl = "/coche_datos/noCar_noOrigin_noYear_noMpg_noHorsepower"
		Rails.ajax({
			type: "POST",
			url: scriptUrl,
		});
	}
}); 


