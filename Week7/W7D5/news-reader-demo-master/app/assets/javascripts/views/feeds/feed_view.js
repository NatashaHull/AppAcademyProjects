NewReader.Views.FeedView = Backbone.View.extend({
  template: JST['feeds/detail'],

  render: function() {
    var renderedContent = this.template({
      feed: this.model
    });
    this.$el.html(renderedContent);
    return this;
  }
});