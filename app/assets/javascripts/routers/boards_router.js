CV.Routers.BoardsRouter = Backbone.Router.extend({
  routes: {
    "":                   "current",
    "/future":            "future",
    "/current":           "current",
    "/pending":           "pending",
    "/setting":           "settings"
  },

  initialize: function($finished, $current, $pending) {
    console.log('yest');

    this.$finished = $finished;
    this.$current = $current;
    this.$pending = $pending;
  },

  current: function () {
    this.$sections.finished.html("<button>Finished</button>");
    this.$sections.pending.html("<button>Pending</button");

    var currentView = new CV.Views.CardSet({
      el: this.$sections.current,
      collection: CV.board.get('current_cards')
    });

    currentView.render();
  },


  pending: function () {

  },

  future: function () {

  }
});