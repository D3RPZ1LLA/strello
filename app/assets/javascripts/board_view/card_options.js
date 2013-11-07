$(document).ready(function() {
	var ST = (window.ST || {});
	
	var fetchOptionMenu = ST.fetchOptionMenu = function (event) {
		var $target = $(event.target);
				
		if ($target.closest('.card').length !== 0) {
			return $target.closest('.card').children('.option-menu')
		} else {
			return $target.closest('.list').children('.option-menu');
		}
	}
	
	$('body').on('click', '.card .option-icon', function (event) {
		event.stopPropagation();
		var $optionMenu = ST.fetchOptionMenu(event);
		
		$('.option-menu').each(function(){
			var $dat = $(this);
			
			if ($dat.data('id') === $optionMenu.data('id')) {
				$dat.toggleClass('hidden');
			} else {
				$dat.addClass('hidden');
			}
		});
	});
	
	$('body').on('submit', '.delete-card', function (event) {
		$(event.target).closest('li').remove();
	});
	
});