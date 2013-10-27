TD.Views.TasksListView = Backbone.View.extend({
  render: function () {
    var that = this;

    var renderedContent = JST["tasks/list"]({
      tasks: that.collection
    });

    that.$el.html(renderedContent);
    return that;
  }
});