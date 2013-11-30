$(document).ready(function () {
	$('.clickable').on('click', function () {
		if (
			$(event.target).closest('.big-avatar').length !== 0 
		) {
			$('.avatar-edit').toggleClass('hidden');
		}
	});
	
	$('body').on('click', function () {
		if (
			$(event.target).closest('.avatar-upload').length === 0 &&
			$(event.target).closest('.big-avatar').length === 0
		) {
			$('.avatar-edit').addClass('hidden');
		}
	});
});