(function() {
  var Asteroids = window.Asteroids = (window.Asteroids || {});

  var Game = Asteroids.Game = function(canvas) {
    this.canvas = canvas;
    this.ctx = canvas.getContext('2d');
    this.asteroids = [];
    this.ship = new Asteroids.Ship([250, 250], [0, 0])
  }

  Game.prototype.addAsteroids = function(num){
    for (var i = 0; i < num; i++){
      newAsteroid = Asteroids.Asteroid.randomAsteroid(this.DIM_X(), this.DIM_Y());
      this.asteroids.push(newAsteroid);
    }
  }

  Game.prototype.DIM_X = function() {
    return this.canvas.width;
  }

  Game.prototype.DIM_Y = function() {
    return this.canvas.height;
  }

  Game.prototype.draw = function(){
    this.ctx.clearRect(0, 0, this.DIM_X(), this.DIM_Y());
    for (var i = 0; i < this.asteroids.length; i++){
      this.asteroids[i].draw(this.ctx);
    }
    this.ship.draw(this.ctx);
    this.ship.draw(this.ctx);
    for(var i = 0; i < this.ship.bullets.length; i++) {
      this.ship.bullets[i].draw(this.ctx);
    }
  }

  Game.prototype.start = function() {
    var that = this
    this.addAsteroids(5)
    this.bindKeyHandlers();
    this.interval = setInterval(function() {
      that.step();
    }, 30);
  }

  Game.prototype.move = function() {
    for (var i = 0; i < this.asteroids.length; i++){
      this.asteroids[i].move();
    }
    this.ship.move();
    for(var i = 0; i < this.ship.bullets.length; i++) {
      this.ship.bullets[i].move();
    }
  }

  Game.prototype.step = function() {
    this.move();
    this.draw();
    if(this.checkColoisions()) {
      this.stop();
    }
  };

  Game.prototype.stop = function() {
    clearInterval(this.interval);
  }

  Game.prototype.checkColoisions = function(){
    for (var i = 0; i < this.asteroids.length; i++){
     if (this.asteroids[i].isCollidedWith(this.ship)){
       alert("Your ship has been hit!");
       return true;
     }
    }
    for(var i = 0; i < this.ship.bullets.length; i++) {
      asteroid = this.ship.bullets[i].hitAsteroids(this.asteroids)
      if (asteroid === 0 || asteroid) {
        this.asteroids = this.asteroids.splice(asteroid, 1)
      }
    }
  }

  Game.prototype.bindKeyHandlers = function(){
    var that = this
    key('up', function() { that.ship.power("up") });
    key('down', function() { that.ship.power("down"); });
    key('left', function() { that.ship.power("left"); });
    key('right', function() { that.ship.power("right"); });
    key('space', function() { that.ship.fireBullet(); });
  }
})();