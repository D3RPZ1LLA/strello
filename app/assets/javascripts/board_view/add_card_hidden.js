$(document).ready(function () {
  /* Render Functions */
  var renderNewCard = function (event) {
    var $target = $(event.target);

    $target.addClass('hidden');
    $target.parent().children('.new-card').removeClass('hidden');
  };

  CV.resetCardRender = function () {
    $('.add-card').removeClass('hidden');
    $('.new-card').addClass('hidden');
  };

  $('.add-card').on('click', function (event) {
    CV.resetCardRender();
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
      CV.resetCardRender();
    }
  });
});