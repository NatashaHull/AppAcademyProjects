JournalApp.Routers.PostsRouter = Backbone.Router.extend({
  initialize: function($rootEl) {
    this.$rootEl = $rootEl
  },

  routes: {
    "": "index",
    "posts/new": "newPost",
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

  newPost: function() {
    var that = this;
    var post = new JournalApp.Models.Post();
    var postFormView = new JournalApp.Views.PostFormView({
      collection: JournalApp.posts,
      model: post
    });
    that.$rootEl.html(postFormView.render().$el);
  },

  edit: function(id) {
    var that = this;
    var post = JournalApp.posts.get(id)
    var postFormView = new JournalApp.Views.PostFormView({
      collection: JournalApp.posts,
      model: post
    });
    that.$rootEl.html(postFormView.render().$el);
  }
});