// WakeboardGame module

WakeboardGame = (function() {
  var Boat = function (sponsor) {
    this.sponsor = sponsor;
  };
  
  Boat.prototype.power = function() {
    return 'power';
  };

  Boat.prototype.turn = function() {
    return 'turn';
  };

  Boat.prototype.sink = function() {
    return 'sink';
  };

  var Wakeboarder = function (name, sponsor) {
    this.name = name;
    this.sponsor = sponsor;
  };

  Wakeboarder.prototype.jump = function() {
    return 'jump';
  };
  
  Wakeboarder.prototype.grind = function() {
    return 'grind';
  };

  Wakeboarder.prototype.spin = function() {
    return 'spin';
  };
  
  Wakeboarder.prototype.crash = function() {
    return 'crash';
  };
  
  return {
    Boat: Boat,
    Wakeboarder: Wakeboarder
  };
})();


