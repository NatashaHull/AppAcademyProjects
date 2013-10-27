window.TD = {
  // we'll eventually store Backbone classes inside of these namespaces
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},

  initialize: function ($rootEl, tasks) {
    new TD.Routers.TasksRouter($rootEl, tasks);
    Backbone.history.start();
  }
};
