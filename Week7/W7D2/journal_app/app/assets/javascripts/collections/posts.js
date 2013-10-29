JournalApp.Collections.Posts = Backbone.Collection.extend({
  model: JournalApp.Models.Post,
  url: '/posts'
});