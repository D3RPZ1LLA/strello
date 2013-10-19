$(document).ready(function () {
	$('body').on('click', '.exit', function(event) {
		var $target = $(event.target);
				
		if ($target.parent().hasClass('hidden-form')) {
			$target.parent().addClass('hidden');
		} else if ($target.parent().parent().hasClass('hidden-form')) {
			$target.parent().parent().addClass('hidden');
		}
	})
});