JournalApp.Views.PostDetailView = Backbone.View.extend({
  template: JST['posts/detail'],

  // initialize: function () {
  //   var id = id;
  // },

  render: function(postId) {
    var that = this
    $.ajax({
      type: "GET",
      url: "/posts/" + postId,
      success: function(postData) {
        var renderedContent = that.template({ post: postData});
        that.$el.html(renderedContent);
      }
    });
    return that;
  }
});