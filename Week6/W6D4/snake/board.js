(function() {
  var SnakeGame = window.SnakeGame = (window.SnakeGame || {})

  var Board = SnakeGame.Board = function() {
    this.snake = new SnakeGame.Snake([3,3], '');
    this.apples = [];
    this.walls = [];
    this.generateApples(5);
  }

  Board.prototype.render = function() {
    this.clearBoard();
    this.renderSnake();
    this.renderApples();
  };

  Board.prototype.clearBoard = function() {
    for(var i = 0; i < 8; i++) {
      for(var j = 0; j < 8; j++) {
        var square = $('.game').find("#row" + i + "-" + j);
        square.removeClass("snake");
        square.removeClass("segment")
      }
    }
  }

  Board.prototype.renderSnake = function() {
    var snakeViewId = "#row" + this.snake.pos[0] + "-" + this.snake.pos[1]
    var snakeDiv = $('.game').find(snakeViewId)
    snakeDiv.addClass("snake");
    snakeDiv.removeClass("apple");

    for(var i = 0; i < this.snake.segments.length; i++) {
      if(this.snake.segments[i][0] === this.snake.pos[0] &&
         this.snake.segments[i][1] === this.snake.pos[1]) {
        console.log(this.snake.segments[i][0]);
        console.log(this.snake.pos[0]);
        this.over = true;
      } else {
        var segmentViewId = "#row" + this.snake.segments[i][0] + "-" + this.snake.segments[i][1]
        var segmentDiv = $('.game').find(segmentViewId)
        segmentDiv.addClass("segment");
      }
    }
  }

  Board.prototype.renderApples = function() {
    for(var i = 0; i < this.apples.length; i++) {
      if(this.apples[i][0] === this.snake.pos[0] &&
         this.apples[i][1] === this.snake.pos[1]) {
        var eatenAppleI = i;
        this.snake.eatApple(this.apples[i]);
      } else {
        var appleViewId = "#row" + this.apples[i][0] + "-" + this.apples[i][1]
        var appleDiv = $('.game').find(appleViewId)
        appleDiv.addClass("apple");
      }
    }
    if(eatenAppleI === 0 || eatenAppleI) {
      this.apples.splice(eatenAppleI, 1)
      eatenAppleI = false;
    }
    if(this.apples.length < 3) {
      this.generateApples(2);
    }
  }

  Board.prototype.generateApples = function(numApples) {
    for (var i = 0; i < numApples; i++) {
      this.apples.push(this.randomPos());
    }
  }

  Board.prototype.randomPos = function() {
    return [Math.floor(Math.random() * 7), Math.floor(Math.random() * 7)];
  }
})();