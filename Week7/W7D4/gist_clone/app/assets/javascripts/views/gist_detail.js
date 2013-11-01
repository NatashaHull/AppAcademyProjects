GistClone.Views.GistDetail = Backbone.View.extend({
  tagName: "li",

  template: JST['gists/detail'],

  events: {
    "click #star": "starGist",
    "click #unstar": "unstarGist"
  },

  render: function() {
    var renderedContent = this.template({
      gist: this.model
    });

    this.$el.html(renderedContent);
    return this;
  },

  starGist: function() {
    var that = this;
    var star = this.model.star();
    star.set("gist_id", this.model.id);
    star.save(null, {
      success: function() {
        that.swapButtons();
      },
      error: function() {
        alert("Something went wrong!");
      }
    });
  },

  unstarGist: function() {
    var that = this;
    var star = this.model.star();
    star.destroy({
      success: function() {
        that.swapButtons();
      },
      error: function() {
        alert("Something went wrong!");
      }
    });
    // console.log(star);
//     console.log(star.get("gist_id"));
//     console.log(star.url());
  },

  swapButtons: function() {
    this.$el.find('#star').toggleClass("hidden");
    this.$el.find('#unstar').toggleClass("hidden");
  }
});