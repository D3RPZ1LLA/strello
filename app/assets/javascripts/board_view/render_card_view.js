$(document).ready(function () {
	var renderCard = function (card) {
		
		console.log(card);
		
	};
	
	$('.card-link').on('click', function(event) {
		// event.preventDefault();
		var $target = $(event.target);

		while ( !($target.data('id')) ) {
			$target = $target.parent();
		}		
				
		$.ajax({
			url: '/cards/' + $target.data('id'),
			type: "GET",
			dataType: 'json',
			success: function(resp) {
				renderCard(resp);
			},
			error: function(resp) {
				console.log('error retrieving card data');
				console.log(resp);
			}
		});
			
	});
});