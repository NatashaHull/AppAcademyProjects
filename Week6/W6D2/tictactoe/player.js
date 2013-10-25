(function(root) {
  var TicTacToe = root.TicTacToe = (root.TicTacToe || {});

  var readline = require('readline');
  TicTacToe.reader = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  TicTacToe.Player = function(game) {
    this.game = game;
  }

  TicTacToe.Player.prototype.promptMove = function() {
    var that = this;
    TicTacToe.reader.question("Enter your move (row, col): ", function(pos) {
      var move = pos.replace(" ", "").split(",");
      move[0] = parseInt(move[0]);
      move[1] = parseInt(move[1]);
      that.game.board.makeMove(move);
    });
  }
})(this);