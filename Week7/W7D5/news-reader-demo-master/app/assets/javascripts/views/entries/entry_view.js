NewReader.Views.EntryView = Backbone.View.extend({
  template: JST['entries/detail'],

  render: function() {
    var renderedContent = this.template({
      entry: this.model
    });
    this.$el.html(renderedContent);
    return this;
  }
});