$(document).ready(function () {
	$('.hidden-form').on('click', function(event) {
		event.stopPropagation();
		
		var $target = $(event.target);
				
		if ($target.closest('.exit').length !== 0) {
			$target.closest('.hidden-form').addClass('hidden');
		}
	})
});