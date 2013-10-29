JournalApp.Views.PostIndexView = Backbone.View.extend({
  template: JST['posts/index'],

  // initialize: function () {
  //   var that = this;

  //   var renderCallback = that.render.bind(that);
  //   that.listenTo(that.collection, "add", renderCallback);
  //   that.listenTo(that.collection, "change:title", renderCallback);
  //   that.listenTo(that.collection, "remove", renderCallback);
  //   that.listenTo(that.collection, "reset", renderCallback);
  // },

  events: {
    "click .delete": "deletePost",

    deletePost: function(event) {
      var idx = parseInt($(event.target).attr("data-id"));
    }
  },

  render: function() {
    var that = this
    $.ajax({
      type: "GET",
      url: "/posts",
      success: function(postData) {
        var renderedContent = that.template({ posts: postData});
        that.$el.html(renderedContent);
      }
    });
    return that;
  }
});