GistClone.ApplicationRouter = Backbone.Router.extend({
  routes: {
    "": "index",
    "gists/new": "newGist",
    "gists/:id": "show"
  },

  index: function() {
    var indexView = new GistClone.Views.GistsIndex({
      collection: GistClone.gists
    });
    this._swapView(indexView);
  },

  show: function(id) {
    var showView = new GistClone.Views.GistDetail({
      model: GistClone.gists.get(id)
    });
    this._swapView(showView);
  },

  newGist: function() {
    var newView = new GistClone.Views.GistForm({
      model: new GistClone.Models.Gist(),
      collection: GistClone.gists
    });

    this._swapView(newView);
  },

  _swapView: function(newView) {
    if (this._prevView) {
      this._prevView.remove();
    }
    this._prevView = newView;
    $("#content").html(newView.render().$el);
  }
});