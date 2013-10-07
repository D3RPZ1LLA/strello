CV.Routers.UsersRouter = Backbone.Router.extend({
  routes: {
    "":                   "current",
    "/finished":          "finished",
    "/current":           "current",
    "/pending":           "pending",
    "/edit":              "userEdit"
  },

  initialize: function ($sections) {
    // header, finished, current, pending, footer
    this.$sections = $sections
  },

  current: function () {
    this.$sections.finished.html("<button>Finished</button>");
    this.$sections.pending.html("<button>Pending</button");

    var currentView = new CV.Views.CardSet({
      el: this.$sections.current,
      collection: CV.user.get('current_cards')
    });

    // var pendingView = new CV.Views.Pending({
//       el: this.$sections.pending,
//       collection: CV.user.get('pending_cards')
//     });

    // finishedView.render();
    currentView.render();
    // pendingView.render();

  },

  pending: function () {

  },

  edit: function () {

  }
});