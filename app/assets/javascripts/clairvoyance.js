window.CV = {
  Models: {},
  Collections: {},
  Routers: {},
  Views: {},

  initialize: function ($finished, $current, $pending, $sidebar) {
    new CV.Routers.BoardsRouter($finished, $current, $pending, $sidebar);

    var data = JSON.parse($('#bootstrap').html());
    CV.board = new CV.Models.Boards(data.board);

    Backbone.history.start();
  }
}