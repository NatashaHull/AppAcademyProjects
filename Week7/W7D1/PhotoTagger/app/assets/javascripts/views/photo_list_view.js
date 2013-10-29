(function(root){
  var Photos = root.Photos = (root.Photos || {} );
  var PhotoListView = Photos.PhotoListView = function(){
    this.$el = $('<div>');
  };

  PhotoListView.initialize = function() {
    var photoListView = new PhotoListView();
    var currentUserId = parseInt($('#content').attr('data-current-user-id'));
    Photos.Photo.fetchByUserId(currentUserId, function(){
      var renderedContent = photoListView.render().$el;
      $("#content").append(renderedContent);
    });
  }

  PhotoListView.prototype.render = function(){
    this.$el.html('');
    var ulConstruct = $('<ul>');
    this.$el.append(ulConstruct);

    Photos.Photo.all.forEach(function(phot) {
      var liConstructor = $("<li>");
      //.text() prevents html injection of the attr.
      liConstructor.text(phot.get("title"));

      ulConstruct.append(liConstructor);
    });
    this.$el.append(ulConstruct);
    return this;
  };
})(this);


