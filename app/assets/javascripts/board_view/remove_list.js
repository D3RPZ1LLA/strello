$(document).ready(function() {
	var fetchOptionMenu = function (event) {
		var $target = $(event.target);
		
		if ($target.closest('.card').length !== 0) {
			$target.closest('.card').children('.option-menu')
		} else {
			return $target.closest('.list').children('.option-menu');
		}
	}
	
	$('body').on('click', 'h4 .option-icon', function (event) {
		event.stopPropagation();
		var $optionMenu = fetchOptionMenu(event);
		
		$('.option-menu').each(function(){
			var $dat = $(this);
			
			if ($dat.data('id') === $optionMenu.data('id')) {
				$dat.toggleClass('hidden');
			} else {
				$dat.addClass('hidden');
			}
		});
	});

	$('body').on('click', function (event) {
		var $target = $(event.target);
		var $optionMenu = $target.closest('.option-menu');
		$('.list > .option-menu').each(function() {
			var $dat = $(this);
			
			if ($dat.data('id') !== $optionMenu.data('id')) {
				$dat.addClass('hidden');
			}
		});
	});
	
	$('body').on('ajax:success', '.delete-list', function (event) {
		$(event.target).closest('.list').remove();
	});
});