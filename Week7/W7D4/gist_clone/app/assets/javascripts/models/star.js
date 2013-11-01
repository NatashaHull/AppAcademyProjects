GistClone.Models.Star = Backbone.Model.extend({
  //url: "gists/2/star"
  url: function() {
    //return "/gists/2/star";
    return ("/gists/" + this.get("gist_id") + "/star");
  }
});