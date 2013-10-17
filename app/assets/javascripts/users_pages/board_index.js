$(document).ready(function () {

	var resetNewBoardForm = function () {
		$('.new-board-form').addClass('hidden');
	};

	$('.board-index .new-board-link').on('click', function(event) {
		event.preventDefault();
		var $form = $('.board-index .new-board-form');
		
		$form.toggleClass('hidden');
		if (!($form.hasClass('hidden'))) {
			$form.children('label').children('input').focus();
		}
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
	
	$('.board-index .new-board-form .exit').on('click', function (event) {
		resetNewBoardForm();
	});

});