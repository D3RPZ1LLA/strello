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
	});
});