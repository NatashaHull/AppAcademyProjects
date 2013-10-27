window.TD = {
  // we'll eventually store Backbone classes inside of these namespaces
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},

  initialize: function ($rootEl, tasks) {
    var tasksListView = new TD.Views.TasksListView({
      collection: tasks
    });

    $rootEl.html(tasksListView.render().$el);
  }
};