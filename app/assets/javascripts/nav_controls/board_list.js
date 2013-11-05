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
			!($target.parent().parent().parent().parent().parent().hasClass('board-list')) &&
			!($target.hasClass('new-board-form')) &&
			!($target.parent().hasClass('new-board-form')) &&
			!($target.parent().parent().hasClass('new-board-form'))
		) {
			$('.board-list').addClass('hidden');
		}
	});
	
	$('.board-list > .exit').on('click', function(event) {
		$('.board-list').addClass('hidden');
	});
	
/* New Board */
	// $('.board-list .new-board-link').on('click', function(event) {
	// 	event.preventDefault();
	// 	var $form = $('.board-list .new-board-form');
	// 	console.log($form);
	// 	
	// 	$form.toggleClass('hidden');
	// 	$form.children('label').children('input').focus();
	// });
});