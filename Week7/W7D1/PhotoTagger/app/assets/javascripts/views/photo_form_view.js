(function(root) {
  var Photos = window.Photos = (window.Photos || {});

  var PhotoFormView = Photos.PhotoFormView = function() {
    this.$el = $('<div>');
  };

  PhotoFormView.initialize = function() {
    var photoFormView = new PhotoFormView();
    photoFormView.render();
    $("#content").append(photoFormView.$el);
    $("#photo_form").on("submit", function(event) {
      photoFormView.submit(event);
    });
  };

  PhotoFormView.prototype.render = function() {
    var formTemplate = JST["photo_form"];
    this.$el.append(formTemplate())
  };

  PhotoFormView.prototype.submit = function(event) {
    var that = this
    event.preventDefault();
    var photo = $("#photo_form").serializeJSON();
    (new Photos.Photo(photo)).save(function() {
      that.add(photo);
    });
  }
})(this);