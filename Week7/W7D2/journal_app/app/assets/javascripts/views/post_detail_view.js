JournalApp.Views.PostDetailView = Backbone.View.extend({
  template: JST['posts/detail'],

  render: function() {
    var that = this
    var renderedContent = that.template({ post: that.model });
    that.$el.html(renderedContent);
    return that;
  }
});