$(document).ready(function () {
	$('body').on('click', '.exit', function(event) {
		var $target = $(event.target);
				
		if ($target.closest('.exit').length !== 0) {
			$target.closest('.hidden-form').addClass('hidden');
		}
	})
});