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
	$('.card-page').on('click', '#new-participation-form > ul > li', function(event) {
		var participantId = $(event.target).closest('li').data('id');
		
		$.ajax({
			url: ,
			async: false,
			type: "PUT",
			datatype: 'json',
			data: {},
			success: function () {
				
			},
			error: function () {
				
			}
		});
	});
	
});