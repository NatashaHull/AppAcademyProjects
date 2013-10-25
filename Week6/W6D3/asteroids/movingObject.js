(function() {
  var Asteroids = window.Asteroids = (window.Asteroids || {});

  var MovingObject = Asteroids.MovingObject = function(pos, vel) {
    this.pos = pos;
    this.vel = vel;
  }

  MovingObject.prototype.move = function() {
    this.pos[0] += this.vel[0];
    this.pos[1] += this.vel[1];
  }

  MovingObject.prototype.draw = function(ctx) {
    ctx.fillStyle = this.color;
    ctx.beginPath();
    ctx.arc(
      this.pos[0],
      this.pos[1],
      this.radius,
      0,
      (2 * Math.PI) - .25,
      false
    );
    ctx.closePath();
    ctx.fill();
    ctx.stroke();
  };

  MovingObject.prototype.isCollidedWith = function(otherObject) {
    var xDistance = Math.abs(otherObject.pos[0] - this.pos[0])
    var yDistance = Math.abs(otherObject.pos[1] - this.pos[1])
    var distance = Math.sqrt(Math.pow(xDistance, 2) + Math.pow(yDistance, 2));
    if((this.radius + otherObject.radius) >= distance) {
      return true;
    }
    return false;
  };
})();