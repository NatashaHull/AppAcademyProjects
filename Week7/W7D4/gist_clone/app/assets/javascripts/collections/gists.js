GistClone.Collections.Gists = Backbone.Collection.extend({
  model: GistClone.Models.Gist,
  url: "/gists"
});