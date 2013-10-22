$(document).ready(function () {
	var renderCard = function (data) {
		$('#card-view .loading').addClass('hidden');
		$('#card-view').data('id', data.card.id);
				
		$('#card-view .card-main').append(JST['card_title']({
			card: data.card
		}));
		
		$('#card-view .card-main').append(JST['card_description']({
			card: data.card
		}));
				
		$('#card-view .sidebar').append(JST['card_sidebar']({
			card: data.card,
			members: data.members,
			participants: data.participants
		}));
	};
	
	var resetCard = function () {
		$('#card-view').addClass('hidden');
		$('#card-view').data('id', '');
		
		$('#card-view .loading').removeClass('hidden');
		
		$('#card-view .card-main').empty();
		$('#card-view .sidebar').empty();
	};
	
	$('#board-lists').on('click', '.card-link', function(event) {
		event.preventDefault();
		var $target = $(event.target);

		while ( !($target.data('id')) ) {
			$target = $target.parent();
		}
		
		$('#card-view').removeClass('hidden');
				
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
	
	$('#card-view').on('click', function(event) {		
		if ( $(event.target).is('#card-view') ) {
			resetCard();
		}
	});
	
	$('#card-view').on('click', '.card-page > .exit', function(event) {
		resetCard();
	});		
	
});