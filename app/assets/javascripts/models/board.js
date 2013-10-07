CV.Models.Board = Backbone.Model.extend({
  urlRoot: '/boards',
  initialize: function () {
    // this.cards = new CV.Collections.Cards(this.cards);
//     this.catagories = new CV.Collections.Catagories(this.catagories);
//     this.members = new CV.Collections.Members(this.members);
    var cards = this.get('cards');
    if (!!cards) {
      this.set('cards', new CV.Collections.Cards(cards));

      var finished = [];
      var current = [];
      var pending = [];
      var current_date = new Date();

      this.get('cards').models.forEach(function(card) {
        var start_date = new Date(card.get('start_date'));
        if (start_date < current_date) {
          var due_date = new Date(card.get('due_date'));
          if (due_date < current_date ) {
            finished.push(card);
          } else {
            current.push(card);
          }
        } else {
          pending.push(card);
        }
      });

      this.set('finished_cards', new CV.Collections.Cards(finished));
      this.set('current_cards', new CV.Collections.Cards(current));
      this.set('pending_cards', new CV.Collections.Cards(pending));
    }
  }
});