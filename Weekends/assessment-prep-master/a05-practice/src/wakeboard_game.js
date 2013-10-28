// WakeboardGame module
(function() {
  var WakeboardGame = window.WakeboardGame = (WakeboardGame || {});

  var Boat = WakeboardGame.Boat = function(sponsor) {
    this.sponsor = sponsor;
  };

  Boat.prototype.power = function() { return 'power'; };
  Boat.prototype.turn= function() { return 'turn'; };
  Boat.prototype.sink = function() { return 'sink'; };

  var Wakeboarder = WakeboardGame.Wakeboarder = function(name, sponsor) {
    this.name = name;
    this.sponsor = sponsor;
  };

  Wakeboarder.prototype.jump = function() { return 'jump'; };
  Wakeboarder.prototype.spin = function() { return 'spin'; };
  Wakeboarder.prototype.grind = function() { return 'grind'; };
  Wakeboarder.prototype.crash = function() { return 'crash'; };

  expect(wakeboarder.sponsor).toEqual('Hyperlite')
    expect(wakeboarder.jump()).toEqual('jump');
    expect(wakeboarder.spin()).toEqual('spin');
    expect(wakeboarder.grind()).toEqual('grind');    
    expect(wakeboarder.crash()).toEqual('crash')
})();
