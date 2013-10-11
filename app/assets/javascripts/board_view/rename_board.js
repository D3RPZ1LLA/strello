$(document).ready(function() {
/* Render Functions */
	var renderRenameBoard = function () {
		$('#rename-board').removeClass('hidden');
	};
	
	var resetRenameBoard = function () {
		$('#rename-board').addClass('hidden');
	}
	
	$('#board-name span').on('click', function(event) {
		$('#rename-board').toggleClass('hidden');
	});
	
	$('body').on('click', function(event) {
		var $target = $(event.target);
		
		if (
			!($target.parent().parent().is('#board-name')) &&
			!($target.is('#rename-board')) &&
			!($target.parent().is('#rename-board'))
		) {
			
			resetRenameBoard();
		}
	});
	
/* Submit Functions */
	$('#rename-board button').on('click', function(event) {
		event.preventDefault();
		console.log('click');
		$('#rename-board').submit();
	});
	
	$('#rename-board').on('ajax:success', function (event, data) {
		$('#board-name span').html(data.title);
		
		resetRenameBoard();
	});
});