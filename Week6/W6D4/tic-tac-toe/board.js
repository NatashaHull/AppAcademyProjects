(function() {
  var TicTacToe = window.TicTacToe = (window.TicTacToe || {});

  TicTacToe.Board = function(game) {
    this.game = game;
    this.grid = new Array(3);
    for (var i = 0; i < 3; i++) {
      this.grid[i] = new Array(3);
    }
  }

  TicTacToe.Board.prototype.WIN_COMBOS = [[[0, 0], [1, 1], [2, 2]],
                    [[2, 0], [1,1], [0, 2]],
                    [[0, 0], [0, 1], [0, 2]],
                    [[1, 0], [1, 1], [1, 2]],
                    [[2, 0], [2, 1], [2, 2]],
                    [[0, 0], [1, 0], [2, 0]],
                    [[0, 1], [1, 1], [2, 1]],
                    [[0, 2], [1, 2], [2, 2]]]

  TicTacToe.Board.prototype.makeMove = function(move) {
    if (this.validMove(move)) {
      this.grid[move[0]][move[1]] = (this.game.currentPlayer == 0) ? "X" : "O";
      this.game.switchPlayer();
    } else {
      alert("Invalid move!");
    }
    this.game.run();
  }

  TicTacToe.Board.prototype.validMove = function(move) {
    if (move[0] < 0 || move[0] > 2 || move[1] < 0 || move[1] > 2) {
      return false;
    }
    return !this.grid[move[0]][move[1]];
  }

  TicTacToe.Board.prototype.over = function() {
    return this.tied() || this.won();
  }

  TicTacToe.Board.prototype.tied = function() {
    for (var row = 0; row < this.grid.length; row++) {
      for (var col = 0; col < this.grid.length; col++) {
        if (this.grid[row][col] === undefined) {
          return false;
        }
      }
    }
    return true;
  }

  TicTacToe.Board.prototype.won = function() {
    for (var i = 0; i < this.WIN_COMBOS.length; i++) {
      var combo = this.WIN_COMBOS[i];
      var first = this.grid[combo[0][0]][combo[0][1]];
      var second = this.grid[combo[1][0]][combo[1][1]];
      var third = this.grid[combo[2][0]][combo[2][1]];
      if (first !== undefined && (first === second && first === third)) {
        return true;
      }
    }
    return false;
  }
})();