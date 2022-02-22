$(document).on('turbolinks:load', function() {
	$input = $('*[data-behavior="autocomplete"]');
	$divThree = $('#search-results-three');
	var removeDiv = "false";

	var options = {
		url: function(phrase) {
			return "/coche_datos/buscar_latest_autocomplete.json?q=" + phrase;
		},
		getValue: "name",
		list: {
			maxNumberOfElements: 10,
			onSelectItemEvent: function() {
				var selectedItemValue = $("#inputOne").getSelectedItemData().name;
				$("#inputTwo").val(selectedItemValue).trigger("change");
				$("#search-results-two").text(selectedItemValue);
			},
			onLoadEvent: function() {
				// if($("#search-results-three").children().length > 0) {
				/* if(removeDiv == "true") {
					$("#search-results-three").remove();
					removeDiv = "false";
				} */
			},
			onShowListEvent: function() {
				var itemsLength = $("#inputOne").getItems().length;
				// var items = $("#inputOne").getItems();
				// var itemData = $("#inputOne").getItemData(0).name;
				// $("#search-results-three").text("on show list event -- " + itemData + " length: " + data);
				// $("#search-results-three").text("on show list event -- " + itemData + " itemsLength: " + itemsLength);
				for(let i = 0; i < itemsLength; i++) {
					var itemDataTmp = $("#inputOne").getItemData(i).name;
					$("#search-results-three").append("<p>" + itemDataTmp + "</p>");
					// $("#search-results-three").append(itemDataTmp);
				}
				// removeDiv = "true";
			}

		}
	};

	$input.easyAutocomplete(options);
	// $divThree.easyAutocomplete(options);
});

