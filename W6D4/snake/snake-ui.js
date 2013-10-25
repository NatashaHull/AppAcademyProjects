(function() {
  var SnakeGame = window.SnakeGame = (window.SnakeGame || {})

  var View = SnakeGame.View = function() {};

  View.prototype.start = function() {
    this.board = new SnakeGame.Board();
    var that = this;
    $(document).on("keydown", function(e) {
      var keyNum = e.keyCode;
      switch(keyNum) {
      //Handles ASWD;
      case 68:
        that.board.snake.turn("E");
        break;
      case 65:
        that.board.snake.turn("W");
        break;
      case 87:
        that.board.snake.turn("N");
        break;
      case 83:
        that.board.snake.turn("S");
        break;
      //Handles arrow keys;
      case 39:
        that.board.snake.turn("E");
        break;
      case 37:
        that.board.snake.turn("W");
        break;
      case 38:
        that.board.snake.turn("N");
        break;
      case 40:
        that.board.snake.turn("S");
        break;
      }
    });
    this.timeId = setInterval(function() {
      that.step();
    }, 350);
  };

  View.prototype.step = function() {
    this.board.snake.move();
    this.board.render();
    if(this.board.over) {
      this.stop();
    }
  };

  View.prototype.stop = function() {
    clearTimeout(this.timeId)
    alert("You lost!")
  };
})();