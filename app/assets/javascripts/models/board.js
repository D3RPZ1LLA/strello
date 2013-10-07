CV.Models.Board = Backbone.Model.extend({
  urlRoot: '/boards',
  initialize: function () {
    this.cards = new CV.Collections.Cards(this.cards);
    this.catagories = new CV.Collections.Catagories(this.catagories);
    this.members = new CV.Collections.Members(this.members);
  }
});