$(document).ready(function() {
	$('#board-sidebar-link').on('click', function(event) {
		$('#board-sidebar').removeClass('hidden');
	});
	
	$('#board-sidebar-exit').on('click', function(event) {
		$('#board-sidebar').addClass('hidden');
	});
});