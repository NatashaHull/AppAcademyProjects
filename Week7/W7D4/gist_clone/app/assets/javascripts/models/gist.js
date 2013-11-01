GistClone.Models.Gist = Backbone.Model.extend({
  urlRoot: "/gists",

  star: function() {
    if(!this._star) {
      this._star = new GistClone.Models.Star();
    }

    return this._star
  },

  parse: function(resp, options) {
    if (resp.star) {
      this.star().set(resp.star[0]);
      delete resp.stars;
    }
    return resp;
  }
});