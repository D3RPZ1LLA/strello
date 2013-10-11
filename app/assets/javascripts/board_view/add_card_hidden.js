$(document).ready(function () {
  /* Render Functions */
  var renderNewCard = function (event) {
    $(event.target).addClass('hidden');
    $('.new-card').removeClass('hidden');

  };

  CV.resetCardRender = function () {
    $('.add-card').removeClass('hidden');
    $('.new-card').addClass('hidden');
  };

  $('.add-card').on('click', function (event) {
    renderNewCard(event);
  });

  $('.logo').on('click', function (event) {
    CV.resetCardRender();
  });
});