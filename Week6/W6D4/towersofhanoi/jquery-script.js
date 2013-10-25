$(document).ready(function() {
  var towersUI = new Hanoi.TowersUI();
  towersUI.render();

  $(".tower").on("click", function(e) {
    console.log(towersUI.firstCurrentDiv);
    if(towersUI.firstCurrentDiv) {
      towersUI.secondClickActions(e);
    } else {
      towersUI.firstClickActions(e);
    }
  });
});