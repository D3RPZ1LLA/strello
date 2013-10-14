$(document).ready(function(event) {
	$('.boards-button').on('click', function(event) {
		$('.board-list').toggleClass('hidden');
	});
	
	$('body').on('click', function(event) {
		var $target = $(event.target);
				
		if (
			!($target.hasClass('boards-button')) &&
			!($target.parent().hasClass('boards-button')) &&
			!($target.parent().parent().hasClass('boards-button')) &&
			!($target.hasClass('board-list')) &&
			!($target.parent().hasClass('board-list')) &&
			!($target.parent().parent().hasClass('board-list')) &&
			!($target.parent().parent().parent().hasClass('board-list')) &&
			!($target.parent().parent().parent().parent().hasClass('board-list')) &&
			!($target.parent().parent().parent().parent().parent().hasClass('board-list')) 
		) {
			$('.board-list').addClass('hidden');
		}
	});
	
	$('.board-list').on('click', '.exit', function(event) {
		$('.board-list').addClass('hidden');
	});
});