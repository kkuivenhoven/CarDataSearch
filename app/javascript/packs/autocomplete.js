
$(document).on('turbolinks:load', function() {
	$input = $('*[data-behavior="autocomplete"]');

	// var options = {
		// data: ["John", "Paul", "George", "Ringo"]
	// };

	var options = {
		url: function(phrase) {
			return "/coche_datos/buscar_autocomplete.json?q=" + phrase;
		},
		getValue: "name",
		template: {
			type: "links",
			fields: {
				link: "link"
			}
		},
	};

	// $('*[data-behavior="autocomplete"]').easyAutocomplete(options);
	$input.easyAutocomplete(options);
});

window.myFunction = function() {
	alert(" HELLO!");
}
