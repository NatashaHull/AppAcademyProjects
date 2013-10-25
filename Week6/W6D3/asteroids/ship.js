(function() {
  var Asteroids = window.Asteroids = (window.Asteroids || {});

  var Ship = Asteroids.Ship = function(pos, vel) {
    Asteroids.MovingObject.call(this, pos, vel);
    this.radius = 30;
    this.color = "#009900"
    this.bullets = [];
  }

  Ship.inherits(Asteroids.MovingObject);

  Ship.prototype.power = function(direction) {
    if(direction === "up") {
      this.vel[1] -= 1;
    } else if(direction === "down") {
      this.vel[1] += 1;
    } else if(direction === "left") {
      this.vel[0] -= 1;
    } else /* "right" */ {
      this.vel[0] += 1;
    }
  }

  Ship.prototype.fireBullet = function() {
    var calcDirection = function(num) {
      return (num === 0) ? 0 : (num / Math.abs(num));
    }

    var bulletPos = [this.pos[0], this.pos[1]]
    var velX = (calcDirection(this.vel[0]) * 50)
    var velY = (calcDirection(this.vel[1]) * 50)
    if(velX !== 0 || velY !== 0){
      var bulletVel = [velX, velY];
      var bullet = new Asteroids.Bullet(bulletPos, bulletVel);
      this.bullets.push(bullet);
    }
  }
})();