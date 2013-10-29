(function(root){
  var Photos = root.Photos = (root.photos || {});

  var Photo = Photos.Photo = function(attr){
    this.attributes = _.extend({}, attr);
  };

  Photo.all = (Photo.all || []);
  Photo._events = ( Photo._events || {});

  Photo.on = function(eventName, callback){
    if( ! this._events[eventName]) {
      this._events[eventName] = []
    };

    this._events[eventName].push(callback);
  };

  Photo.trigger = function(eventName){
    this._events[eventName].forEach(function(callback){
      callback();
    });
  };

  Photo.fetchByUserId = function(userId, callback) {
    $.ajax({
      type: "GET",
      url: "/users/" + userId + "/photos.json",
      success: function(photos) {
        var photoObjs = [];
        (photos).forEach(function(phot) {
          photoObjs.push(new Photo(phot));
        });
        _.extend(Photo.all, photoObjs);
        callback(photoObjs);
      }
    });
  };

  Photo.prototype.get = function(attr_name){
    return this.attributes[attr_name];
  };

  Photo.prototype.set = function(attr_name, value){
    return this.attributes[attr_name] = value;
  };

  Photo.prototype.deleteUnassignableAttrs = function() {
    delete this.attributes["created_at"];
    delete this.attributes["updated_at"];
  }

  Photo.prototype.save = function(callback){
    if(!this.attributes.id){
      this.create(callback);
    }
    else {
      this.update(callback);
    }
  };

  Photo.prototype.update = function(callback){
    var that = this;
    this.deleteUnassignableAttrs();
    $.ajax({
      type: "PUT",
      url: '/api/photos/' + that.get('id'),
      data: { photo: that.attributes },
      success: function(photoObj) {
        _.extend(that.attributes, photoObj);
        callback(photoObj);
      }
    })
  }

  Photo.prototype.create = function(callback) {
    var that = this;
    $.ajax({
      type: "POST",
      url: '/api/photos/',
      data: that.attributes,
      success: function(photoObj) {
        _.extend(that.attributes, photoObj);
        Photo.all.push(that);
        that.add(photoObj);
        callback(photoObj);
      }
    })
  }

  Photo.prototype.add = function(data) {
    $('#content ul').append("<li>" + data.title + "</li>");
  }
})(this);