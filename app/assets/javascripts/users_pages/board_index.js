$(document).ready(function () {

	var resetNewBoardForm = function ($form) {
		$('.new-board-form').each(function() {
			if ($(this).data('id') !== $form.data('id')) {
				$(this).addClass('hidden');
			}
		});
	};
	
	var fetchForm = function ($boardLink) {
		return $boardLink.parent().children('.new-board-form');
	};

	$('body .new-board-link').on('click', function(event) {
		event.preventDefault();
		var $form = fetchForm($(event.target).closest('.new-board-link'));
		
		$form.toggleClass('hidden');
		if (!($form.hasClass('hidden'))) {
			$form.children('label').children('input').focus();
		}
	});
	
	$('body').on('click', function (event) {
		var $target = $(event.target);
		var $form = $();
		
		if (
			$target.closest('.new-board-form').length !== 0
			// !($target.hasClass('new-board-form')) &&
// 			!($target.parent().hasClass('new-board-form')) &&
// 			!($target.parent().parent().hasClass('new-board-form')) &&
// 			!($target.hasClass('new-board-link')) && 
// 			!($target.parent().hasClass('new-board-link')) &&
// 			!($target.parent().parent().hasClass('new-board-link'))
		) {
			$form = $target.closest('.new-board-form');
		} else if ( 
			$target.closest('.new-board-link').length !== 0
		) {
			$form = fetchForm($target.closest('.new-board-link'));
		}
		
		resetNewBoardForm($form);		
	});
	
	$('.new-board-form .exit').on('click', function (event) {
		resetNewBoardForm($());
	});

});