(function() {
  var Hanoi = window.Hanoi = (window.Hanoi || {})

  var TowersUI = Hanoi.TowersUI = function() {
    this.game = new Hanoi.Game();
  };

  TowersUI.prototype.render = function() {
    var gameTowers = this.game.towers;
    var displayTowers = $(".game > div")
    for(var i = 0; i < gameTowers.length; i++) {
      var tower = $(displayTowers[i])
      var setterHtml = "";
      for(var j = 0; j < gameTowers[i].length; j++) {
        setterHtml += "<div>(";
        switch(gameTowers[i][j]) {
        case 1:
          setterHtml += "==|==";
          break;
        case 2:
          setterHtml += "===|===";
          break;
        default:
          setterHtml += "====|====";
        }
        setterHtml += ")</div>";
      }
      tower.html(setterHtml);
    }
  }


  TowersUI.prototype.firstClickActions = function(e) {
    this.firstCurrentDiv = $(e.currentTarget);
    this.firstCurrentDiv.toggleClass('highlighted');
  };

  TowersUI.prototype.secondClickActions = function(e) {
    var $secondCurrentDiv = $(e.currentTarget);
    var firstTower = parseInt(this.firstCurrentDiv.attr('data-tower'));
    var secondTower = parseInt($secondCurrentDiv.attr('data-tower'));
    this.firstCurrentDiv.toggleClass('highlighted');
    this.game.makeMove(firstTower, secondTower);
    this.render();
    this.game.run();
    this.firstCurrentDiv = undefined;
  };
})();