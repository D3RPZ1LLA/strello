CV.Routers.BoardsRouter = Backbone.Router.extend({
  routes: {
    "":                   "current",
    "/pending":           "pending",
    "/future":            "future"
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