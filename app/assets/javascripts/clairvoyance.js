window.CV = {
  Models: {},
  Collections: {},
  Routers: {},
  Views: {},

  usersInitialize: function ($sections) {
    CV.userRouter = new CV.Routers.UsersRouter($sections);

    var data = JSON.parse($('#bootstrapped_user').html());
    CV.user = new CV.Models.User(data.user);

    Backbone.history.start();
  },

  boardsInitialize: function ($sections) {
    new CV.Routers.BoardsRouter($sections);

// bootstrap will have board.includes(:cards, :catagories, :members)
    var data = JSON.parse($('#bootstrap').html());
    CV.board = new CV.Models.Boards(data.board);

    Backbone.history.start();
  }
}