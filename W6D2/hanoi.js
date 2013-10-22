var readlines = require('readline');
var reader = readlines.createInterface({
  input: process.stdin,
  output: process.stdout
});

(function(root) {
  var Hanoi = root.Hanoi = (root.Hanoi || {});

  Hanoi.Game = function() {
    this.towers = [[1,2,3], [], []];
  }

  Hanoi.Game.prototype.run = function() {
    if(this.towers[2].length === 3) {
      console.log("You win!");
      reader.close();
    } else {
      this.promptMove();
    }
  }

  Hanoi.Game.prototype.promptMove = function() {
    this.printTowers();
    var that = this
    reader.question("Enter first tower: \n", function(ftower) {
      reader.question("Enter second tower: \n", function(stower) {
        ftower = parseInt(ftower) - 1;
        stower = parseInt(stower) - 1;
        that.makeMove(ftower, stower);
      });
    });
  }

  Hanoi.Game.prototype.makeMove = function(ftower, stower) {
    if(this.validMove(ftower, stower)) {
      this.towers[stower].unshift(this.towers[ftower].shift());
    } else {
      console.log("This move is invalid!");
    }
    this.run();
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

  Hanoi.Game.prototype.printTowers = function() {
    for (var i = 0; i < this.towers.length; i++) {
      console.log("Tower " + (i + 1) + " has " + this.towers[i]);
    }
  }
})(this);

new this.Hanoi.Game().run();