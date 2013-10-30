JournalApp.Views.PostDetailView = Backbone.View.extend({
  template: JST['posts/detail'],

  events: {
    "dblclick .post-data": "editProperty",
    "blur .post-data": "updateProperty"
  },

  render: function() {
    var that = this
    var renderedContent = that.template({ post: that.model });
    that.$el.html(renderedContent);
    return that;
  },

  editProperty: function(event) {
    var attr = $(event.target).attr("data-attribute")
    var editTemplate = JST['posts/form']
    var newEl = editTemplate({ post: this.model });
    var replacement = $(newEl).find("#post_" + attr);
    $(event.target).html(replacement);
  },

  updateProperty: function(event) {
    var that = this;
    var $targetDiv = $(event.target)
    var newVal = $targetDiv.val();
    var attr = $targetDiv.parent().attr("data-attribute");
    that.model.set(attr, newVal)
    that.model.save(null, {
      success: function() {
       $targetDiv.replaceWith(newVal);
      },

      error: function(model, error) {
        var valErrors = errors.responseJSON;
        valErrors.forEach(function(error) {
          $targetDiv.parent().prepend(error + "</br>");
        });
      }
    });
  }
});