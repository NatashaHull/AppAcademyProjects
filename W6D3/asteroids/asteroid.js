(function() {
  Function.prototype.inherits = function(superClass) {
    function Surrogate() {};
    Surrogate.prototype = superClass.prototype;
    this.prototype = new Surrogate();
  };

  var Asteroids = window.Asteroids = (window.Asteroids || {});

  var Asteroid = Asteroids.Asteroid = function(pos, vel) {
    Asteroids.MovingObject.call(this, pos, vel);
    this.color = Asteroid.COLOR;
    this.radius = Asteroid.RADIUS();
  }

  Asteroid.inherits(Asteroids.MovingObject);

  Asteroid.COLOR = "#6666FF";

  Asteroid.RADIUS = function() {
    return Math.random() * 50;
  }

  Asteroid.randomAsteroid = function(dimX, dimY) {
    var x = Math.random() * dimX;
    var y = Math.random() * dimY;
    var pos = [x, y];
    var calculateRandomVel = function() {
      return (Math.random()) * [1, -1][Math.floor(Math.random() * 2)];
    }
    var vel = [calculateRandomVel(), calculateRandomVel()];
    return new Asteroid(pos, vel);
  };
})();