NewReader.Models.Feed = Backbone.Model.extend({
  urlRoot: '/feeds',

  entries: function() {
    if(!this._entries) {
      this._entries = new NewReader.Collections.Entries({
        feed: this
      });
    }

    return this._entries;
  },

  parse: function(resp, options) {
    this.entries().reset(resp.entries);
    delete resp.entries;
    return resp;
  }
});