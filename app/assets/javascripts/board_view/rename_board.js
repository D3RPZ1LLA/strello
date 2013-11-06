$(document).ready(function() {
/* Render Functions */
	var renderRenameBoard = function () {
		$('#rename-board').removeClass('hidden');
		$('#rename-board').children('label').children('input').focus();
	};
	
	var resetRenameBoard = function () {
		$('#rename-board').addClass('hidden');
	}
	
	$('#board-name span').on('click', function(event) {
		if ($('#rename-board').hasClass('hidden')) {
			renderRenameBoard();
		} else {
			resetRenameBoard();
		}
	});
	
	$('body').on('click', function(event) {
		var $target = $(event.target);
		
		if (
			!($target.parent().parent().is('#board-name')) &&
			!($target.is('#rename-board')) &&
			!($target.parent().is('#rename-board')) &&
			!($target.parent().parent().is('#rename-board'))
		) {
			
			resetRenameBoard();
		}
	});
	
/* Submit Functions */
	$('#rename-board button').on('click', function(event) {
		event.preventDefault();
		$('#rename-board').submit();
	});
	
	$('#rename-board').on('ajax:success', function (event, data) {
		$('#board-name span').html(data.title);
		
		resetRenameBoard();
	});
});