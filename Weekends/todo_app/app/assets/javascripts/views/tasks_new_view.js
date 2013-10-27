TD.Views.NewTaskView = Backbone.View.extend({
  events: {
    "submit": "submit"
  },

  render: function () {
    var that = this;

    var renderedContent = JST["tasks/new"]();
    that.$el.html(renderedContent);
    return that;
  },

  submit: function() {
    event.preventDefault();
    var that = this;

    var formData = $(event.target).serializeJSON();
    var task = new TD.Models.Task(formData.task);

    that.collection.add(task);
    Backbone.history.navigate("#/");
  }
});