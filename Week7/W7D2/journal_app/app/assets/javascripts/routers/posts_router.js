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
    var indexView = new JournalApp.Views.PostIndexView({
      collection: JournalApp.posts
    });
    $("#content").html(indexView.render().$el);
  },

  show: function(id) {
    var that = this
    var post = JournalApp.posts.get(id)
    var detailView = new JournalApp.Views.PostDetailView({
      model: post
    });
    that.$rootEl.html(detailView.render().$el);
  }
});