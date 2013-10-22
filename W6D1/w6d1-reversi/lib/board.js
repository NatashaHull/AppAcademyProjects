var Piece = require("./piece.js").Piece;

Array.prototype.myIncludes = function(val) {
  for(var i = 0; i < this.length; i++) {
    if(this[i] === val) {
      return true;
    }
  };
  return false;
}

function Board(){
	this.grid = new Array(8)
  for (var i = 0; i < 8; i++){
    this.grid[i] = new Array(8);
  }
  this.grid[3][3] = new Piece("white");
  this.grid[3][4] = new Piece("black");
  this.grid[4][3] = new Piece("black");
  this.grid[4][4] = new Piece("white");
};

Board.prototype.full = function() {
  for (var i = 0; i < 8; i++){
    if (this.grid[i].myIncludes(undefined)){
      return false;
    }
  }
  return true;
};

Board.prototype.onBoard = function(pos) {
  return pos[0] < 7 && pos[0] > 0 && pos[1] < 7 && pos[1] > 0;
}

// Other helper methods may be helpful!

exports.Board = Board;