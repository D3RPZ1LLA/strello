$(document).ready(function () {

/* Render Functions */
  var renderCardTitleEdit = function () {
    $('.card-title-detail').addClass('hidden');
    $('.card-title-input').removeClass('hidden');
    //mover focus to textarea
  };

  var renderCardDescriptionEdit = function () {
    $('.card-description-detail').addClass('hidden');
    $('.card-description-input').removeClass('hidden');
  };

  var resetAllRender = function () {
    var $inputs = $('.card-page .input');

    $inputs.each(function (index, el) {
      var $el = $(el);
      if (!$el.hasClass('hidden')) {
        $el.parent().children().not('.input').removeClass('hidden');
        $el.addClass('hidden');
      }
    });
  };

  $('body').on('click', '.card-title h3', function(event) {
    renderCardTitleEdit();
  });

  $('body').on('click', '.card-edit-button', function(event) {
    event.preventDefault();
  });

  $('body').on('click', '.card-description-detail', function(event) {
    renderCardDescriptionEdit();
  });

  $('body').on('click', function(event) {
    var $target = $(event.target);
    if (
      !($target.hasClass('input')) &&
      !($target.parent().hasClass('detail')) &&
      !($target.parent().hasClass('input')
    )) {
      resetAllRender();
    }
  });
	
/* Submit Functions */
  $('body').on('click', '#card-title-button', function(event) {
    event.preventDefault();
    $("#card-title-form").submit();
  });

  $('body').on('ajax:success', '#card-title-form', function(event, data){
    var $form = $(this);
    $('.card-title h3').html(data.title);
    resetAllRender();
  });

  $('body').on('click', '#card-description-button', function(event) {
    event.preventDefault();
    $('#card-description-form').submit();
  });

  $('body').on('ajax:success', '#card-description-form', function(event, data){
    var $form = $(this);
    $('.card-description h4').html(data.description);
    resetAllRender();
  });
});