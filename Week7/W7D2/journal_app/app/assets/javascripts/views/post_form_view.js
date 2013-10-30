JournalApp.Views.PostFormView = Backbone.View.extend({
  template: JST['posts/form'],

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
    var that = this
    event.preventDefault();
    var form = $(event.currentTarget);
    var postData = form.serializeJSON();
    that.model.set(postData);
    that.model.save(null, {
      success: function() {
        that.collection.add(that.model);
        Backbone.history.navigate("#", { trigger: true });
      },

      error: function(model, errors) {
        var valErrors = errors.responseJSON;
        valErrors.forEach(function(error) {
          $("#post").prepend(error + "</br>");
        });
      },
    });
  }
});