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
	
	var appendList = function (data) {
		console.log('la');
		console.log(data)
		$('.list').last().after(
      '<li class="list"><h4>' + data.title + '</h4><ul class="group"></ul><div class="new-card-form"><div class="new-card hidden"><form class="actually-card-new-form" action="/catagories/' + data.id + '/cards" method="POST" accept-charset="utf-8"	data-remote="true"><input type="hidden"	name="authenticity_token"	value="<%= form_authenticity_token %>"><textarea name="card[title]"></textarea><br><button class="save">Add</button></form></div><div class="add-card">Add a card...</div></div></li>'
		);
	};
	
/* Submit Functions */
	$('#add-list-form').on('click', 'button', function(event) {
		event.preventDefault();
		$(this).submit();
	});
	
	$('#add-list-form').on('ajax:success', function(event, data) {
		var $form = $(this);
		
		appendList(data);
		
		$form[0].reset();
		resetNewList();
	});
});