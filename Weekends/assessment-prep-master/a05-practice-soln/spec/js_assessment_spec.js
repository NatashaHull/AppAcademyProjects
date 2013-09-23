describe("recursiveExponent", function() {
  it("should recursively calculate 2^3==8", function() {
    expect(Assessment.recursiveExponent(2, 3)).toBe(8);
  });
  
  it("should recursively calculate 3^3==27", function() {
    expect(Assessment.recursiveExponent(3, 3)).toBe(27);
  });
});

describe("powCall", function() {
  it("should return result of exponentiation of base and power", function () {
    var dummy = function() {};
    expect(Assessment.powCall(3, 3, dummy)).toBe(27);
  });
  
  it("should call the callback passing the result of the exponentiation", function () {
    var exp = 0;
    var dummy = function(result) { 
      exp = result * 2; 
    };
    expect(Assessment.powCall(2, 3, dummy)).toBe(8);
    expect(exp).toBe(16);
  });
});

describe("transpose", function() {
  it("should return a transposed array", function() {
    var startArr = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    var endArr =   [[0, 3, 6], [1, 4, 7], [2, 5, 8]];
    expect(Assessment.transpose(startArr)).toEqual(endArr);
  });

  it("should return not modify the original array", function() {
    var startArr = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    var endArr =   [[0, 3, 6], [1, 4, 7], [2, 5, 8]];
    expect(Assessment.transpose(startArr)).toEqual(endArr);
    expect(endArr).toEqual([[0, 3, 6], [1, 4, 7], [2, 5, 8]]);
  });
});

describe("primes", function() {
  it("should return the first 5 primes in order", function() {
    expect(Assessment.primes(5)).toEqual([2, 3, 5, 7, 11]);
  });

  it("should handle 0 correctly", function() {
    expect(Assessment.primes(0)).toEqual([]);
  });
  
  it("should handle 1 correctly", function() {
    expect(Assessment.primes(1)).toEqual([2]);
  });
});

describe("mergeSort", function() {
  it("should sort the array", function() {
    var startArr = [3, 2, 1, 5, 6, 4];
    expect(Assessment.mergeSort(startArr)).toEqual([1, 2, 3, 4, 5, 6]);
  });
  
  it("should return [] when sorting array with 0 elements", function () {
    expect(Assessment.mergeSort([])).toEqual([]);
  });
  
  it("should sort an array with 1 element", function () {
    expect(Assessment.mergeSort([2])).toEqual([2]);
  });
});

describe("Function.prototype.myCall", function () {
  it("should call a function with the given this value", function () {
    function I() {};
    function U() {};
    
    U.prototype.scream = function(words) {
      return words.toUpperCase();
    };
    
    var i = new I();
    var u = new U();
    
    expect(u.scream.myCall(i, "icecream")).toBe("ICECREAM");
  });
});

describe("inherits", function() {
  var Animal, Dog, dog;

  beforeEach(function() {
    Animal = function() {
      this.name = "Yogi";
    };

    Animal.prototype.makeNoise = function() { return "Hi!"; };

    Dog = function() {
      this.age = 7;
    };

    Dog.inherits(Animal);

    Dog.prototype.bark = function() { return "Woof!"; };

    dog = new Dog();
  });

  it("should properly set up the prototype chain between a child and parent", function() {
    expect(dog.bark()).toBe("Woof!");
    expect(dog.makeNoise()).toBe("Hi!");
  });

  it("should not call the parent's constructor function", function() {
    expect(dog.name).toBeUndefined();
  });

  it("should maintain separation of parent and child prototypes", function() {
    Dog.prototype.someProperty = 42;
    var animal = new Animal();
    expect(animal.someProperty).toBeUndefined();
    expect(animal.makeNoise()).toBe("Hi!");
  });

  it("should properly work for longer inheritance chains", function() {
    var Poodle = function() { this.name = "Bill"; };

    Poodle.inherits(Dog);

    Poodle.prototype.shave = function() { return "Brrr."; };

    var poodle = new Poodle();
    expect(poodle.name).toBe("Bill");
    expect(poodle.shave()).toBe("Brrr.");
    expect(poodle.makeNoise()).toBe("Hi!");
    expect(poodle.bark()).toBe("Woof!");
  });
});
