JournalApp.Views.PostIndexView = Backbone.View.extend({
  template: JST['posts/index'],

  initialize: function () {
    var that = this;

    var renderCallback = that.render.bind(that);
    that.listenTo(that.collection, "add", renderCallback);
    that.listenTo(that.collection, "change", renderCallback);
    that.listenTo(that.collection, "remove", renderCallback);
  },

  events: {
    "click .delete": "deletePost"

    deletePost: function(event) {
      var idx = parseInt($(event.target).attr("data-id"));

    }
  },

  render: function() {
    var that = this
    $.ajax({
      type: "GET",
      url: "/posts"
      success: function(posts) {
        var renderedContent = that.template(posts);
        that.$el.html(renderedContent);
      }
    });
    return that;
  }
});