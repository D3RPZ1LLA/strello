CV.Routers.UsersRouter = Backbone.Router.extend({
  routes: {
    "":                   "home",
    "/:id":               "userShow",
    "/edit":              "userEdit"
  },

  initialize: function ($sections) {
    console.log("user router init");
  },

  home: function () {

  },

  userShow: function () {

  },

  userEdit: function () {

  }
});