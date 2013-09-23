describe("Player", function() {
  var player;
  var song;

  beforeEach(function() {
    player = new Player();
    song = new Song();
  });

  it("should be able to play a Song", function() {
    player.play(song);
    expect(player.currentlyPlayingSong).toEqual(song);
  });

  describe("when song has been paused", function() {
    beforeEach(function() {
      player.play(song);
      player.pause();
    });

    it("should indicate that the song is currently paused", function() {
      expect(player.isPlaying).toBe(false);
    });

    it("should be possible to resume", function() {
      player.resume();
      expect(player.isPlaying).toBe(true);
      expect(player.currentlyPlayingSong).toEqual(song);
    });
  });
});
