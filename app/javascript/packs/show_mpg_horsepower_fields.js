window.checkIfTextFieldsFilledOut = function() {
	var carNameVal = $("#car_name_val").val();
	var originNameVal = $("#country_origin").val();
	var yearVal = $("#year_val").val();

}

window.mpgFieldsContainer = function() {
  var mpgDiv = document.getElementById('mpg_fields_container');
  if(mpgDiv.style.display == 'none') {
    mpgDiv.style.display = 'block';
    mpgPlaceholderDiv = 'none';
  } else {
    mpgDiv.style.display = 'none';
    mpgPlaceholderDiv = 'block';
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
	hideMPGHorsepowerFields();
	// disableCheckboxes();
}); 

