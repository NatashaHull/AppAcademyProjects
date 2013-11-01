NewReader.Collections.Feeds = Backbone.Collection.extend({
  model: NewReader.Models.Feed,

  url: '/feeds'
}),