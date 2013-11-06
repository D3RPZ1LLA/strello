$(document).ready(function() {
	$('body').on('click', '.option-icon', function (event) {
		event.stopPropagation();
		var $optionMenu = $(event.target).closest('.list').children('.option-menu');
		
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
		$('.option-menu').each(function() {
			var $dat = $(this);
			
			if ($dat.data('id') !== $optionMenu.data('id')) {
				$dat.addClass('hidden');
			}
		});
	});
});