JournalApp.Views.PostIndexView = Backbone.View.extend({
  template: JST['posts/index'],

  initialize: function () {
    var that = this;

    var renderCallback = that.render.bind(that);
    that.listenTo(that.collection, "add", renderCallback);
    that.listenTo(that.collection, "change:title", renderCallback);
    that.listenTo(that.collection, "remove", renderCallback);
    that.listenTo(that.collection, "reset", renderCallback);
  },

  events: {
    "click .delete": "deletePost",
  },

  render: function() {
    var that = this
    var renderedContent = that.template({ posts: that.collection });
    that.$el.html(renderedContent);
    return that;
  },

  deletePost: function(event) {
    var that = this;
    var idx = parseInt($(event.target).attr("data-id"));
    var post = that.collection.get(idx);
    post.destroy({
      success: function() {
        that.collection.remove(post);
      }
    });
  }
});