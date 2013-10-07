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
    var finishedView = new CV.Views.Finished({
      el: this.$sections.finished,
      collection: CV.user.get('finished_cards')
    });

    var currentView = new CV.Views.Current({
      el: this.$sections.current,
      collection: CV.user.get('current_cards')
    });

    var pendingView = new CV.Views.Pending({
      el: this.$sections.pending,
      collection: CV.user.get('pending_cards')
    });

    finishedView.render();
    currentView.render();
    pendingView.render();
  },

  edit: function () {

  }
});