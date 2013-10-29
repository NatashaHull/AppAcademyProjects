JournalApp.Routers.PostsRouter = Backbone.Router.extend({
  initialize: function($rootEl) {
    this.$rootEl = $rootEl
  },

  routes: {
    "": "index",
    "posts/:id": "show"
  },

  index: function() {
    var that = this
    var indexView = new JournalApp.Views.PostIndexView();
    $("#content").html(indexView.render().$el);
  },

  show: function(postId) {
    var that = this
    var detailView = new JournalApp.Views.PostDetailView();
    that.$rootEl.html(detailView.render(postId).$el);
  }
});