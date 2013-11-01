GistClone.Views.GistsIndex = Backbone.View.extend({
  template: JST['gists/index'],

  initialize: function() {
    this.childViews = [];
    this.listenTo(this.collection, "add remove sync", this.render);
  },

  render: function() {
    var renderedContent = this.template({
      gists: this.collection
    });
    this.$el.html(renderedContent);
    this.generateChildViews();

    return this;
  },

  generateChildViews: function() {
    var that = this;
    this.collection.forEach(function(gist) {
      var showView = new GistClone.Views.GistDetail({
        model: gist
      });
      that.renderChildView(showView);
      that.childViews.push(showView);
    });
  },

  renderChildView: function(childView) {
    var ulEl = this.$el.children('.gists')
    ulEl.append(childView.render().$el);
  }

  // remove: we'll do this later?
});