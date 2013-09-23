function Player() {
}
Player.prototype.play = function(song) {
  this.currentlyPlayingSong = song;
};

Player.prototype.pause = function() {
  this.isPlaying = false;
};

Player.prototype.resume = function() {
  this.isPlaying = true;
};

Player.prototype.makeFavorite = function() {
  return 'Favorited!';
};
