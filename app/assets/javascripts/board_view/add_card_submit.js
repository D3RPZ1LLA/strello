$(document).ready(function() {

  var newCard = function(data) {
    return '<a href="/cards/' + data.id + '/edit">' +
    '<li class="card"><div class="card-text">' + data.title +
    '</div></li></a>';
  }

  $('.new-card button').on('click', function(event) {
    event.preventDefault();
    $(event.target).parent().submit();
  });

  $(".actually-card-new-form").on("ajax:success", function(event, data){
    var $form = $(this);

    $($form).parent().parent().parent().children('ul').append(newCard(data));

    $form[0].reset();
    CV.resetCardRender();
  });


});