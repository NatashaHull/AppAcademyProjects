window.TD = {
  // we'll eventually store Backbone classes inside of these namespaces
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},

  initialize: function ($rootEl, tasksData) {
    var tasks = new TD.Collections.Tasks(tasksData);

    // startup a router
    new TD.Routers.TasksRouter($rootEl, tasks);
    // begin listening for navigation events
    Backbone.history.start();
  }
};