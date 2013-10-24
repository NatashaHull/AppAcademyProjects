(function() {
  var Asteroids = window.Asteroids = (window.Asteroids || {});

  var Bullet = Asteroids.Bullet = function(pos, vel) {
    Asteroids.MovingObject.call(this, pos, vel);
    this.radius = 10;
    this.color = "#FF0000";
  }

  Bullet.inherits(Asteroids.MovingObject);

  Bullet.prototype.hitAsteroids = function(asteroids) {
    for(var i = 0; i < asteroids.length; i++) {
      if(asteroids[i].isCollidedWith(this)) {
        if(asteroids[i].radius > 5) {
          asteroids[i].radius /= 2
        } else {
          return i;
        }
      }
    }
  }
})();