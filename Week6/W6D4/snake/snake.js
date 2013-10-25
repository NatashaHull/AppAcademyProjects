(function() {
  var SnakeGame = window.SnakeGame = (window.SnakeGame || {})

  var Snake = SnakeGame.Snake = function(pos, dir) {
    this.dir = dir;
    this.pos = pos;
    this.segments = [];
  }

  Snake.prototype.move = function() {
    this.moveSegments();
    switch(this.dir) {
    case 'N':
      this.pos[0] -= 1;
      break;
    case 'E':
      this.pos[1] += 1;
      break;
    case 'S':
      this.pos[0] += 1;
      break;
    case 'W':
      this.pos[1] -= 1;
    }

    for(var i = 0; i < this.pos.length; i++) {
      if(this.pos[i] > 7) {
        this.pos[i] -= 8
      } else if (this.pos[i] < 0) {
        this.pos[i] += 8
      }
    }
  }

  Snake.prototype.moveSegments = function() {
    if(this.segments.length > 0) {
      this.segments.pop();
      this.segments.unshift([this.pos[0], this.pos[1]]);
    }
  }

  Snake.prototype.turn = function(dir) {
    this.dir = dir;
  }

  Snake.prototype.eatApple = function(pos) {
    this.segments.push([pos[0], pos[1]]);
  }

})();