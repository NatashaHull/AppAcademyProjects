GistClone.Views.GistForm = Backbone.View.extend({
  template: JST['gists/form'],

  events: {
    "submit #gistForm": "saveGist"
  },

  saveGist: function(event) {
    event.preventDefault();
    var that = this;
    var gistData = $(event.currentTarget).serializeJSON();
    that.model.set(that.model.parse(gistData))
    that.model.save(null, {
      success: function() {
        that.collection.add(that.model, { at: 0 });
        Backbone.history.navigate('/', { trigger: true }); // root
      },
      error: function() {
        alert("You messed up!!!")
      }
    });
  },

  render: function() {
    var renderedContent = this.template({
      gist: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});