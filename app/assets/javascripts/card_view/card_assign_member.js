$(document).ready(function(){
/* Render Functions */
	$('.card-page').on('click', '#assign-member-button', function (event) {
		$('#new-participation-form').toggleClass('hidden');
	});
	
	$('.card-page').on('click', function (event) {
		if ($(event.target).closest('#new-participation-form').length === 0 &&
			  $(event.target).closest('#assign-member-button').length === 0) {
			$('#new-participation-form').addClass('hidden');
		}
	});
	
/* Submit Functions */
	var renderParticipation = function (data) {
		$('.members').children().each(function(idx, el) {
			var $el = $(el);
			if ($el.data('id') === data.user.id) {
				$el.children().removeClass('hidden');
			}
		});
				
		$('#new-participation-form li').each(function(idx, el) {
		  var $el = $(el);			
			if ($el.data('id') === data.user.id) {
				$el.data('participation-id', data.participation.id);
			}
		});
	};
	
	var derenderParticipation = function (user_id) {
		$('.members').children().each(function(idx, el) {
			var $el = $(el);
			if ($el.data('id') === user_id) {
				$el.children().addClass('hidden');
			}
		});
		
		$('#new-participation-form li').each(function(idx, el) {
			var $el = $(el);
			if ($el.data('id') === user_id) {
				$el.data('participation-id', "");
			}
		});
	};
	
	var createParticipation = function (cardId, user_id) { 		
		$.ajax({
			url: '/cards/' + cardId + '/participations',
			type: "POST",
			datatype: 'json',
			data: {
				participation: {
					user_id: user_id
				}
			},
			success: function (resp) {
				renderParticipation(resp);
			},
			error: function (resp) {
				console.log('new participation failed');
				console.log(resp);
			}
		});
	};
	
	var destroyParticipation = function (cardId, participation_id, user_id) {
		$.ajax({
			url: '/participations/' + participation_id,
			type: "DELETE",
			success: function () {
				derenderParticipation(user_id);
			},
			error: function () {
				console.log('participation ' + participation_id + ' was not destroyed.');
			}
		});
	}
	
	$('.card-page').on('click', '#new-participation-form > ul > li', function(event) {
		var cardId = $('#card-view').data('id');
		var $li = $(event.target).closest('li');	
				
		if ($li.data('participation-id')) {
			destroyParticipation(cardId, $li.data('participation-id'), $li.data('id'));
		} else {
			createParticipation(cardId, $li.data('id'));
		} 
	});
	
});