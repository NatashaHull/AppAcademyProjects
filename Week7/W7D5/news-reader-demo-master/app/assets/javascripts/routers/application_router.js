NewReader.ApplicationRouter = Backbone.Router.extend({
  initialize: function($rootEl) {
    this.$rootEl = $rootEl;
  }

  routes: {
    "": "index",
    "feeds/:id": "show"
  },

  index: function() {
    var indexView = new NewReader.Views.FeedIndexView({
      collection: NewReader.feeds
    });
    this._swapView(indexView);
  },

  show: function(id) {
    var feed = NewReader.feeds.get(id);
    var showView = new NewReader.Views.FeedView({
      model: feed
    });
    this._swapView(showView);
  },

  _swapView: function(newView) {
    if(this._prevView) {
      this._prevView.remove();
    }

    this._prevView = newView;
    this.$rootEl.html(newView.render().$el);
  }
});