CV.Models.User = Backbone.Model.extend({
  rootUrl: '/users',

  initialize: function () {
    if (!!this.cards) {
      this.cards = new CV.Collections.Cards(this.cards);
    }
  }
});