JournalApp.Routers.PostsRouter = Backbone.Router.extend({
  initialize: function($rootEl) {
    this.$rootEl = $rootEl
  },

  routes: {
    "": "index",
    "posts/:id": "show",
    "posts/:id/edit": "edit"
  },

  index: function() {
    var that = this
    var indexView = new JournalApp.Views.PostIndexView({
      collection: JournalApp.posts
    });
    that.$rootEl.html(indexView.render().$el);
  },

  show: function(id) {
    var that = this
    var post = JournalApp.posts.get(id)
    var detailView = new JournalApp.Views.PostDetailView({
      model: post
    });
    that.$rootEl.html(detailView.render().$el);
  },

  edit: function(id) {
    var that = this;
    var post = JournalApp.posts.get(id)
    var postEditView = new JournalApp.Views.PostEditView({
      model: post
    });
    that.$rootEl.html(postEditView.render().$el);
  }
});