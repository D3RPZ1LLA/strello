$(document).ready(function () {
	var resetNewBoardForm = function () {
		$('.new-board-form').addClass('hidden');
	};
	
	$('.new-board-link').on('click', function(event) {
		event.preventDefault();
		$('.new-board-form').toggleClass('hidden');
	});
	
	$('body').on('click', function (event) {
		var $target = $(event.target);
		
		if (
			!($target.hasClass('new-board-form')) &&
			!($target.parent().hasClass('new-board-form')) &&
			!($target.parent().parent().hasClass('new-board-form')) &&
			!($target.hasClass('new-board-link')) && 
			!($target.parent().hasClass('new-board-link')) &&
			!($target.parent().parent().hasClass('new-board-link'))
		) {
			resetNewBoardForm();
		}
	});
	
	$('.new-board-form .exit').on('click', function (event) {
		resetNewBoardForm();
	});
});