describe("Song", function() {
  it("should play", function() {
    var song = new Song();
    expect(song.play()).toBe('Ladida...');
  });
});  

