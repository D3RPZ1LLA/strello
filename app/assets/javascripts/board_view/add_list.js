$(document).ready(function () {
/* Render Functions */
	var renderNewList = function () {
		$('.new-list').addClass('hidden');
		$('#add-list-form').removeClass('hidden');
	}
	
	var resetNewList = function () {
		$('.new-list').removeClass('hidden');
		$('#add-list-form').addClass('hidden');
	}
  
	$('.new-list').on('click', function(event) {
		renderNewList();
	});
	
	$('body').on('click', function(event) {
		var $target = $(event.target);
		
		if(
			!($target.hasClass('new-list')) &&
			!($target.is('#add-list-form')) &&
			!($target.parent().is('#add-list-form'))
		) {
			
			resetNewList();
		}
	});
	
/* Submit Functions */
	var appendList = function (data) {
		$('#new-catagory-li').before(
      '<li class="list" data-id="' + data.id + 
			'" data-idx="' + data.sort_idx + '"><h4>' + data.title + 
			'</h4><ul class="group"></ul><div class="new-card-form"><div class="new-card hidden"><form class="actually-card-new-form" action="/catagories/' + data.id + '/cards" method="POST" accept-charset="utf-8"	data-remote="true"><input type="hidden"	name="authenticity_token"	value="<%= form_authenticity_token %>"><textarea name="card[title]"></textarea><br><button class="save">Add</button></form></div><div class="add-card">Add a card...</div></div></li>'
		);
				
		var minWidth = parseInt($('.board').css('min-width').slice(0, -2));
		minWidth += 290;
		$('.board').css('min-width', minWidth);
	};
	
	$('#add-list-form').on('click', 'button', function(event) {
		event.preventDefault();
		$(this).submit();
	});
	
	$('#add-list-form').on('ajax:success', function(event, data) {		
		var $form = $(this);
		var $newCatagoryLi = $('#new-catagory-li');
		
		appendList(data);
		
		$form[0].reset();
		$form.children('#catagory-sort-idx').val($('#board-lists').children().length - 1);
		$newCatagoryLi.detach();
		$('#board-lists').append($newCatagoryLi);
		resetNewList();
		
		reorderLists();
	});
	
	
/* Sorting Functions */
	var reorderLists = function () {
			var nonListPassed = false;
			
			$('#board-lists').children().each(function (idx, li) {
				var $li = $(li);
				var properIdx = nonListPassed ? idx - 1: idx;
				
				if ($li.hasClass('list') && $li.data('idx') !== properIdx) {

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
							$li.data('idx', resp.sort_idx);
						},
						error: function (resp) {
							console.log('catagory update failed');
							console.log(resp);
						}
					});
					
				} else if ($li.is('#new-catagory-li')) {
					nonListPassed = true;
					$li.children('form').children('#catagory-sort-idx').val(idx);
				}
			});
		};
	
	$('#board-lists').sortable({
		stop: function (event, ui) {
			reorderLists();
		}
	});
	
});