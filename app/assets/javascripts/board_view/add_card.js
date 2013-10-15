$(document).ready(function () {
/* Render Functions */
  var renderNewCard = function (event) {
    var $target = $(event.target);

    $target.addClass('hidden');
    $target.parent().children('.new-card').removeClass('hidden');
  };

  var resetCardRender = function () {
    $('.add-card').removeClass('hidden');
    $('.new-card').addClass('hidden');
  };

  $('body').on('click', '.add-card', function (event) {
    resetCardRender();
    renderNewCard(event);
  });

  $('body').on('click', function(event) {
    var $target = $(event.target);
    if (
      !($target.hasClass('new-card')) &&
      !($target.parent().hasClass('add-card')) &&
      !($target.hasClass('add-card')) &&
      !($target.parent().hasClass('new-card')) &&
      !($target.parent().parent().hasClass('new-card'))
    ) {
      resetCardRender();
    }
  });


/* Submit Functions */  
  var appendCard = function($form, data) {
		$form.parent().parent().parent().children('ul').append(
			'<li data-id"' + data.id + '" data-idx="' + data.sort_idx + 
			'"><a href="/cards/' + data.id + '/edit"><div class="card-text card">' + 
			data.title + '</div></a></li>'
		);
  };

  $('body').on('click', '.new-card button', function(event) {
    event.preventDefault();
    $(event.target).parent().submit();
  });

  $('body').on("ajax:success", ".actually-card-new-form", function(event, data){
    var $form = $(this);
		
    appendCard($form, data);

    $form[0].reset();
    resetCardRender();
  });
  
/* Sorting Functions */
	var reorderCards = function () {
		$('#board-lists').children().each(function (idxL, list) {
			var $list = $(list);
			
			$list.children('ul').children().each(function (idxC, card) {
				var $card = $(card);
				// console.log($card.data('id'));
				
				if ($card.data('idx') !== idxC) {			
					$.ajax({
						url: '/cards/' + $card.data('id'),
						type: "PUT",
						dataType: 'json',
						data: {
							card: {
								sort_idx: idxC
							}
						},
						success: function (resp) {
							console.log('card success');
							$card.data('idx', resp.sort_idx);
						},
						errror: function (resp) {
							console.log('card update failed');
							console.log(resp);
						}
					});			
				}
				
			});
			
			var newCardIdx = $list.children('ul').children().length;
			$list.children('.new-card-form')
					 .children('.new-card')
					 .children('form')
					 .children('.card-sort-idx')
					 .val(newCardIdx);
		});
	};
	
  $(".list ul").sortable({
    connectWith: ".list ul",
		dropOnEmpty: true,
    start: function (event, ui) {
      // ui.item.toggleClass("highlight");
    },
    stop: function (event, ui) {
      // ui.item.toggleClass("highlight");
			reorderCards();
    }
  });
  $(".list ul").disableSelection();
});