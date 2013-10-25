(function() {
  var TicTacToe = window.TicTacToe = (window.TicTacToe || {});
  var Board = TicTacToe.Board;

  TicTacToe.Game = function() {
    this.board = new Board(this);
    this.currentPlayer = 0;
  }

  TicTacToe.Game.prototype.run = function() {
    if (this.board.over()) {
      if (this.board.won()) {
        this.switchPlayer();
        alert("Player " + (this.currentPlayer + 1) + " won!");
      } else {
        alert("It was a tie!");
      }
    }
  }

  TicTacToe.Game.prototype.switchPlayer = function() {
    this.currentPlayer = (this.currentPlayer == 0) ? 1 : 0;
  }

  TicTacToe.Game.prototype.currentMark = function() {
    return (this.currentPlayer === 0) ? "X" : "O";
  }
})();