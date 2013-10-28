$(document).ready(function () {
	$('.user-header .avatar').on('click', function (event) {
		var $target = $(event.target);
		
		$('.logout-menu').toggleClass('hidden');
	});
	
	$('body').on('click', function (event) {
		var $target = $(event.target);
		
		if (
			$target.closest('.avatar').length === 0 &&
			$target.closest('.logout-menu').length === 0
		) {
			$('.logout-menu').addClass('hidden');
		}
	});
})