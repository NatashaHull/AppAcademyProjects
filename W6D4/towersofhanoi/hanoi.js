(function() {
  var Hanoi = window.Hanoi = (window.Hanoi || {});

  Hanoi.Game = function() {
    this.towers = [[1,2,3], [], []];
  }

  Hanoi.Game.prototype.run = function() {
    if(this.towers[2].length === 3) {
      alert("You win!");
    }
  }

  Hanoi.Game.prototype.makeMove = function(ftower, stower) {
    if(this.validMove(ftower, stower)) {
      this.towers[stower].unshift(this.towers[ftower].shift());
    } else {
      alert("This move is invalid!");
    }
  }

  Hanoi.Game.prototype.validMove = function(ftower, stower) {
    if(this.towers[ftower].length > 0) {
      var secondTowerTop = this.towers[stower][0];
      if(!secondTowerTop || this.towers[ftower][0] < secondTowerTop) {
        return true;
      }
    }
    return false;
  }
})();