CV.Routers.UsersRouter = Backbone.Router.extend({
  routes: {
    "":                   "home",
    "/:id":               "userShow",
    "/edit":              "userEdit"
  },

  initialize: function ($sections) {
    // header, finished, current, pending, footer
    this.$sections = $sections
  },

  home: function () {
    var currentView = new CV.Views.Current({
      el: this.$sections.current
      // collection: CV.user.cards
    });
  },

  userShow: function (id) {

  },

  userEdit: function () {

  }
});