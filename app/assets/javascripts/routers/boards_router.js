CV.Routers.BoardsRouter = Backbone.Router.extend({
  routes: {
    "":                   "current",
    "/future":            "future",
    "/current":           "current",
    "/pending":           "pending",
    "/setting":           "settings"
  },

  initialize: function($finished, $current, $pending) {
    this.$finished = $finished;
    this.$current = $current;
    this.$pending = $pending;
  },

  current: function () {

  },

  pending: function () {

  },

  future: function () {

  }
});