$(document).ready(function(){
/* Render Functions */
	var renderAssignMember = function () {
		$('.sidebar .assign-member').removeClass('hidden');		
	};
	
	var resetAssignMember = function () {
		$('.sidebar .assign-member').addClass('hidden');		
	};
	
	$('.assign-member-button').on('click', function (event) {
		$('.sidebar .assign-member').toggleClass('hidden');		
	});
	
	$('body').on('click', function (event) {
		var $target = $(event.target);
		
		if(
			!($target.hasClass('assign-member-button')) &&
			!($target.hasClass('assign-member')) &&
			!($target.parent().hasClass('assign-member')) &&
			!($target.parent().parent().hasClass('assign-member'))
		) {
			resetAssignMember();
		} 
	});
	
	var appendAvatar = function (data) {
		var persisted = false;
		
		$('.members').children().each(function (index, el) {
			console.log($(el).data('id'));
			console.log( data);
			if ($(el).data('id') === data.user_id) {
				persisted = true;
			}
		});
		
		if (!persisted) {
			$('.sidebar .members').append(
				'<li data-id="' + data.user_id + '"><div class="avatar"><img alt="Happy-cat1" src="/assets/happy-cat1.jpg"</div></li>'
			);
		}
	};
	
/* Submit Functions */
	$('#new-participation button').on('click', function(event) {
		event.preventDefault();
		$('#new-participation').submit();
	});
	
	$('#new-participation').on('ajax:success', function(event, data) {
		var $form = $(this);
		
		appendAvatar(data);
		
		$form[0].reset();
		resetAssignMember();
	});
});