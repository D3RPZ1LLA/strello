$(document).ready(function() {
	$('#board-lists').sortable({
		stop: function (event, ui) {
			var nonListPassed = false;
			
			$(event.target).children().each(function (idx, li) {
				var $li = $(li);
				var properIdx = nonListPassed ? idx - 1: idx;
				
				if ($li.hasClass('list') && $li.data('idx') !== properIdx) {
					
					$li.data('idx') !== idx

					console.log('3');

					$.ajax({
						url: '/catagories/' + $li.data('id'),
						type: "PUT",
						dataType: 'json',
						data: {
							catagory: {
								sort_idx: nonListPassed ? idx - 1: idx
							}
						},
						success: function (resp) {
							console.log('success');
							$li.data('idx', resp.sort_idx);
						}
					});
					
				} else if (!($li.hasClass('list'))) {
						nonListPassed = true;
						$li.children('form').children('#catagory-sort-idx').val(idx);
				}
			});
		}
	});
});