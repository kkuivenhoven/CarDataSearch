window.checkIfTextFieldsFilledOut = function() {
	var carNameVal = $("#car_name_val").val();
	var originNameVal = $("#country_origin").val();
	var yearVal = $("#year_val").val();

}

window.mpgFieldsContainer = function() {
  var mpgDiv = document.getElementById('mpg_fields_container');
  if(mpgDiv.style.display == 'none') {
    mpgDiv.style.display = 'block';
  } else {
    mpgDiv.style.display = 'none';
  }
}

window.horsepowerFieldsContainer = function() {
  var horsepowerDiv = document.getElementById('horsepower_fields_container');
  if(horsepowerDiv.style.display == 'none') {
    horsepowerDiv.style.display = 'block';
  } else {
    horsepowerDiv.style.display = 'none';
  }
}

window.hideMPGHorsepowerFields = function() {
  var mpgDiv = document.getElementById('mpg_fields_container');
  mpgDiv.style.display = 'none';

  var horsepowerDiv = document.getElementById('horsepower_fields_container');
  horsepowerDiv.style.display = 'none';
}

window.disableCheckboxes = function() {
	$("input.mpg_checkbox").attr("disabled", "disabled");
	$("input.horsepower_checkbox").attr("disabled", true);
}

$(document).on('turbolinks:load', function() {
	var curUrl = $(location).attr("pathname");

	if(curUrl == "/coche_datos/search_all_cars") {
		hideMPGHorsepowerFields();
		// disableCheckboxes();

		var scriptUrl = "/coche_datos/noCar_noOrigin_noYear_noMpg_noHorsepower"
		Rails.ajax({
			type: "POST",
			url: scriptUrl,
		});
	}
}); 


