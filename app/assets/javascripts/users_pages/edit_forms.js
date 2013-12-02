$(document).ready(function () {
	$('#account-settings li').on('click', function(event) {
		event.stopPropagation();
		
		var dataType = $(event.target).data('type');
		
		if (typeof dataType === 'undefined') {
			return null;
		}
		
		var $form = $('#account-settings form').filter( function(index) {
			return $(this).data('type') === dataType;
		});
		
		var $otherForms = $('.hidden-form').filter( function(index) {
			return $(this).data('type') !== dataType ||
			$(this).closest('#account-settings').length === 0;
		})
		
		$form.toggleClass('hidden');
		$otherForms.addClass('hidden');
	});
	
	$('body').on('click', function(event) {
		$('#account-settings form').addClass('hidden');
	});
});