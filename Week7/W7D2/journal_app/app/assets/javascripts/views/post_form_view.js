JournalApp.Views.PostFormtView = Backbone.View.extend({
  template: JST['posts/edit'],

  events: {
    "submit #post": "editPost"
  },

  render: function() {
    var that = this
    var renderedContent = that.template({ post: that.model });
    that.$el.html(renderedContent);
    return that;
  },

  editPost: function(event) {
    event.preventDefault();
    var form = $(event.currentTarget);
    var postData = form.serializeJSON();
    this.model.set(postData);
    this.model.save(null, {
      success: function() {
        this.collection.set(model);
        Backbone.history.navigate("#", { trigger: true });
      },

      error: function(errors) {
        console.log(errors);
        // errors.forEach(function(error) {
//           $("#post").prepend(error);
//         });
      },
    });
  }
});