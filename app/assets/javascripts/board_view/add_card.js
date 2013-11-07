$(document).ready(function () {
/* Render Functions */
  var renderNewCard = function (event) {
    var $target = $(event.target);

    $target.addClass('hidden');
    $target.parent().children('.new-card').removeClass('hidden');
		$target.parent().children('.new-card').children('form').children('textarea').focus();
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
			'<li data-id="' + data.id + '" data-idx="' + data.sort_idx + 
			'" data-catagory-id="' + data.catagory_id + 
			'"><a class="card-link" href="/cards/' + data.id + 
			'"><div class="card-text card">' + 
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
	var ST = (window.ST || {});
	
	ST.reorderCards = function () {
		var alteredCards = [];
		
		$('#board-lists').children().each(function (idxL, list) {
			var $list = $(list);
			
			$list.children('ul').children().each(function (idxC, card) {
				var $card = $(card);
				
				if ($card.data('idx') !== idxC || $card.data('catagory-id') !== $list.data('id')) {			
					
					alteredCards.push({
						id: $card.data('id'),
						catagory_id: $list.data('id'),
						sort_idx: idxC
					});
					
					$card.data('idx', idxC);
				}
				
			});
			
			var newCardIdx = $list.children('ul').children().length;
			$list.children('.new-card-form')
					 .children('.new-card')
					 .children('form')
					 .children('.card-sort-idx')
					 .val(newCardIdx);
		});
		
		if (alteredCards.length > 0 ) {
			$.ajax({
				url: '/boards/' + $('.board').data('id') + '/cards/reorder',
				async: false,
				type: "PUT",
				data: {
					cards: alteredCards
				},
				success: function (resp) {

				},
				error: function () {
					
				}
			});
		}
	};
		
  ST.sorted = $(".list ul").sortable({
    connectWith: ".list ul",
		dropOnEmpty: true,
    start: function (event, ui) {
      // ui.item.toggleClass("highlight");
    },
    stop: function (event, ui) {
      // ui.item.toggleClass("highlight");
			ST.reorderCards();
    }
  });
	
  $(".list ul").disableSelection();
});