CV.Views.Current = Backbone.View.extend({
  initialize: function() {
  },
  events: {},
  render: function () {
    var dat = this;
    this.$el.html(JST['card_set']({
      cards: dat.collection.models
    }));
  }
});