NewReader.Collections.Entries = Backbone.Collection.extend({
  initialize: function(options) {
    this.feed = options.feed;
  },

  model: NewReader.Models.Entry,

  url: function() {
    return "/feeds/" + this.feed.id + "/entries";
  }
});