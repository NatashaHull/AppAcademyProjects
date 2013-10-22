function Piece(color){
	this.color = color;
};

Piece.prototype.flip = function() {
  if (this.color === "black"){
    this.color = "white";
  } else {
    this.color = "black";
  }
};

exports.Piece = Piece;