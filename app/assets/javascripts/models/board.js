CV.Models.Board = Backbone.Model.extend({
  urlRoot: '/boards',
  initialize: function () {
    this.catagories = new CV.Collection.Catagories(this.catagories);
  }
});