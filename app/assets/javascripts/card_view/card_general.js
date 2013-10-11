$(document).ready(function() {
	$('.card-page .exit').on('click', function(event) {
		var boardId = $(event.target).data("board-id");
		
		window.location.href = "/boards/" + boardId;
	});
});
