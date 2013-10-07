CV.Models.User = Backbone.Model.extend({
  rootUrl: '/users',

  initialize: function () {
    var cards = this.get('cards');
    if (!!cards) {
      this.set('cards', new CV.Collections.Cards(cards));
    }
  }
});