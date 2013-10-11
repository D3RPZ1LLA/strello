$(document).ready(function() {
  // console.log('click');

  $('#card-title-button').on('click', function(event) {
    event.preventDefault();
    $("#card-title-form").submit();
  });

  $("#card-title-form").on("ajax:success", function(event, data){
    var $form = $(this);
    $('.card-title h3').html(data.title);
    CV.resetAllRender();
  });

  $('#card-description-button').on('click', function(event) {
    event.preventDefault();
    $('#card-description-form').submit();
  });

  $("#card-description-form").on("ajax:success", function(event, data){
    var $form = $(this);
    $('.card-description h4').html(data.description);
    CV.resetAllRender();
  });
});

