describe("WakeboardGame", function() {
  it("should have WakeboardGame defined on the global object", function() {
    expect(WakeboardGame).toBeDefined();
  });

  it("should have Boat defined on WakeboardGame", function() {
    expect(WakeboardGame.Boat).toBeDefined();
  });

  it("should not have Boat defined on window", function() {
    expect(window.Boat).toBeUndefined();
  });

  it("should have Wakeboarder defined on WakeboardGame", function() {
    expect(WakeboardGame.Wakeboarder).toBeDefined();
  });
  
  it("should not have Wakeboarder defined on window", function() {
    expect(window.Wakeboarder).toBeUndefined();
  });
  
  it("should not have Boat's methods defined on window", function() {
    expect(window.power).toBeUndefined();
    expect(window.turn).toBeUndefined();
    expect(window.sink).toBeUndefined();
  });
  
  it("should not have Wakeboarder's methods defined on window", function() {
    expect(window.jump).toBeUndefined();
    expect(window.spin).toBeUndefined();
    expect(window.grind).toBeUndefined();
    expect(window.crash).toBeUndefined();
  });

  it("should allow creation of a Boat with the proper methods", function() {
    var boat = new WakeboardGame.Boat('Nautique');

    expect(boat.sponsor).toBe('Nautique');
    expect(boat.power()).toBe('power');
    expect(boat.turn()).toBe('turn');
    expect(boat.sink()).toBe('sink');
  });
  
  it("should allow creation of a Wakeboarder with the proper methods", function() {
    var wakeboarder = new WakeboardGame.Wakeboarder('JD Webb', 'Hyperlite');

    expect(wakeboarder.name).toEqual('JD Webb');
    expect(wakeboarder.sponsor).toEqual('Hyperlite')
    expect(wakeboarder.jump()).toEqual('jump');
    expect(wakeboarder.spin()).toEqual('spin');
    expect(wakeboarder.grind()).toEqual('grind');    
    expect(wakeboarder.crash()).toEqual('crash');
  });
});

