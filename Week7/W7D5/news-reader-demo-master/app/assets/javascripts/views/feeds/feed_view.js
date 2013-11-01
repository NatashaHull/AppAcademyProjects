NewReader.Views.FeedView = Backbone.View.extend({
  initialize: function(options) {
    this.listenTo(this.model.entries(), "sync", this.render);
  }

  template: JST['feeds/detail'],

  events: {
    "click .refreshEntries": "refreshEntries"
  },

  render: function() {
    var renderedContent = this.template({
      feed: this.model
    });
    this.$el.html(renderedContent);
    return this;
  },

  refreshEntries: function() {
    this.model.entries().fetch({});
  }
});