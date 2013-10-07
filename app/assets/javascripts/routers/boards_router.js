CV.Routers.BoardsRouter = Backbone.Router.extend({
  routes: {
    "":                   "boardPersonal",
    "b/:id":              "boardShow"
  },

  initialize: function($finished, $current, $pending, $sidebar) {
    this.$finished = $finished;
    this.$current = $current;
    this.$pending = $pending;
    this.$sidebar = $sidebar;


  }
});