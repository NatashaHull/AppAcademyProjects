var Piece = require("./piece.js").Piece;
var Board = require("./board.js").Board;

function Game() {
	this.board = new Board();
	this.grid = this.board.grid;
};

// You will certainly need some more helper methods...

Game.prototype.won = function() {

};

Game.prototype.placePiece = function(pos, color) {
	this.board.grid[pos[0]][pos[1]] = new Piece(color);
};

Game.prototype.runLoop = function() {

};

Game.prototype.occupied = function(pos) {
  return this.grid[pos[0]][pos[1]];
};

Game.prototype.nearbyOppositePieces = function(pos, currentPlayerColor) {
  var oppositePiecePositions = [];
  for (var i = -1; i <= 1; i++) {
    for (var j = -1; j <= 1; j++) {
      var boardPosition = this.grid[pos[0]+i][pos[1]+j];
      if (boardPosition !== undefined && boardPosition.color !== currentPlayerColor) {
        oppositePiecePositions.push([pos[0]+i, pos[1]+j]);
      }
    }
  }
  return oppositePiecePositions;
}

Game.prototype.checkingVectors(pos, otherPlayerPositions) {
  var vectors = [];
  for(var i = 0; i < otherPlayerPositions.length; i++) {
    vectors.push(vector(pos, otherPlayerPositions[i]));
  }
  return vectors;
}

Game.prototype.validMove = function(pos, currentPlayerColor) {
  if(!this.board.onBoard(pos)) {
    return false;
  }
  if(this.occupied(pos)) {
    return false;
  }
  var nearbyOppositePiecePositions = this.nearbyOppositePieces(pos, currentPlayerColor)
  if (nearbyOppositePiecePositions.length === 0){
    return false;
  } else {
    var vectors = this.checkingVectors(pos, nearbyOppositePiecePositions);
    return surroundedOppositePiece(vectors, pos, currentPlayerColor);
  }
};

Game.prototype.surroundedOppositePiece(vectors, possiblePos, currentPlayerColor){
  for (var i = 0; i < vectors.length; i++){

    for (var j = 2; j < 7; j++){
      var checkingPosition = [possiblePos[0] + (j * vectors[i][0]),
        possiblePos[1] + (j * vectors[i][1])];
      if (!this.board.onBoard(checkingPosition)){
        break;
      } else if (this.grid[checkingPosition[0]][checkingPosition[1]] === undefined) {
        break;
      } else if (this.grid[checkingPosition[0]][checkingPosition[1]].color === currentPlayerColor){
        return true;
      }
    }
  }
  return false;
}

var vector = function(position1, position2){
  var vector_row = position2[0] - position1[0];
  var vector_col = position2[1] - position1[1];
  return [vector_row, vector_col];
}

exports.Game = Game;