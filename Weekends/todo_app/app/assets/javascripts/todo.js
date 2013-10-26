window.TD = {
  // we'll eventually store Backbone classes inside of these namespaces
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},

  initialize: function ($rootEl, tasks) {
    // we'll call `TD.initialize(rootEl, tasks)` from our HTML to
    // kick-off the JS client code.

    console.log("Achievement Unlocked: JS Client Code Runs!");
    console.log(tasks);
  }
};