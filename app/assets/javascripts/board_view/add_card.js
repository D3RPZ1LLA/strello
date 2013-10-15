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
  var newCard = function(data) {
    return '<a href="/cards/' + data.id + '/edit">' +
    '<li class="card"><div class="card-text">' + data.title +
    '</div></li></a>';
  }

  $('body').on('click', '.new-card button', function(event) {
    event.preventDefault();
    $(event.target).parent().submit();
  });

  $('body').on("ajax:success", ".actually-card-new-form", function(event, data){
    var $form = $(this);
		
    $form.parent().parent().parent().children('ul').append(newCard(data));

    $form[0].reset();
    resetCardRender();
  });
  
/* Sorting Functions */
	var reorderCards = function () {
		
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