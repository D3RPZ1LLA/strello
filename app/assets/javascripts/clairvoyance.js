window.CV = {
  Models: {},
  Collections: {},
  Routers: {},
  Views: {},

  initialize: function ($finished, $current, $pending) {
    new CV.Routers.BoardsRouter($finished, $current, $pending);

// bootstrap will have board.includes(:cards, :catagories, :members)
    var data = JSON.parse($('#bootstrap').html());
    CV.board = new CV.Models.Boards(data.board);

    Backbone.history.start();
  }
}