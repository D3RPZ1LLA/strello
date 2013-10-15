$(document).ready(function () {
	$('.new-board-link').on('click', function(event) {
		event.preventDefault();
		$('.new-board-form').toggleClass('hidden');
	});
});