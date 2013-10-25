$(document).ready(function() {
  var game = new TicTacToe.Game();
  game.run();

  $('.game').on('click', 'div', function(e) {
    var currentDiv = $(e.currentTarget);
    var row = parseInt(currentDiv.attr('data-row'));
    var col = parseInt(currentDiv.attr('data-col'));
    if(game.board.validMove([row, col])) {
      currentDiv.html(game.currentMark());
    }
    game.board.makeMove([row, col]);
  });
});