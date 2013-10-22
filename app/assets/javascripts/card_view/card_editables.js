$(document).ready(function () {
/* Render Functions */
  var renderCardTitleEdit = function () {
    $('.card-title-detail').addClass('hidden');
    $('.card-title-input').removeClass('hidden');
		$('.card-title-input textarea').focus();
  };

  var renderCardDescriptionEdit = function () {
    $('.card-description-detail').addClass('hidden');
    $('.card-description-input').removeClass('hidden');
		$('.card-description-input textarea').focus();
  };

  var derenderCardTitleEdit = function () {
    $('.card-title-detail').removeClass('hidden');
    $('.card-title-input').addClass('hidden');
  };
	
	var derenderCardDescriptionEdit = function () {
    $('.card-description-detail').removeClass('hidden');
    $('.card-description-input').addClass('hidden');
	};

  $('body').on('click', '.card-title', function(event) {
		var $target = $(event.target);
    renderCardTitleEdit();
  });

  $('body').on('click', function(event) {
    var $target = $(event.target);
    if ( $target.closest('.card-title').length === 0 ) {
			derenderCardTitleEdit();
    }
  });
	
  $('body').on('click', '.card-edit-button', function(event) {
    event.preventDefault();
  });

  $('body').on('click', '.card-description-detail', function(event) {
    renderCardDescriptionEdit();
  });
	
  $('body').on('click', function(event) {
    var $target = $(event.target);
    if ( $target.closest('.card-description').length === 0 ) {
      derenderCardDescriptionEdit();
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