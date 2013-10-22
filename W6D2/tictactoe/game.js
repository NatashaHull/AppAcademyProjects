var Board = require('./board.js').TicTacToe.Board;
var Player = require('./player.js').TicTacToe.Player;

(function(root) {
  var TicTacToe = root.TicTacToe = (root.TicTacToe || {});

  TicTacToe.Game = function() {
    this.board = new Board(this);
    this.players = [new Player(this),
                    new Player(this)];
    this.currentPlayer = 0;
  }

  TicTacToe.Game.prototype.run = function() {
    this.board.show();
    if (this.board.over()) {
      if (this.board.won()) {
        this.switchPlayer();
        console.log("Player " + (this.currentPlayer + 1) + " won!");
      } else {
        console.log("It was a tie!");
      }
      playerRoot.TicTacToe.reader.close();
    } else {
      this.players[this.currentPlayer].promptMove();
    }
  }

  TicTacToe.Game.prototype.switchPlayer = function() {
    this.currentPlayer = (this.currentPlayer == 0) ? 1 : 0;
  }
})(this);

new this.TicTacToe.Game().run();