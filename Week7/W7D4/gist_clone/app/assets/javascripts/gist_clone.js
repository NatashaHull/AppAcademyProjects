window.GistClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    GistClone.gists = new GistClone.Collections.Gists();
    GistClone.gists.fetch({
      success: function() {
        new GistClone.ApplicationRouter();
        Backbone.history.start();
      }
    });
  }
};

$(document).ready(function(){
  GistClone.initialize();
});
