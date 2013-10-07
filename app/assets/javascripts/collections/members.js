CV.Collections.Members = Backbone.Collection.extend({
  model: CV.Models.User,
  url: '/users'
});