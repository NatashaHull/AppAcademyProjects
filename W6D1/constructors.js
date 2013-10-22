function Cat(name, owner){
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function() {
  return this.owner + " loves " + this.name;
}

var cat1 = new Cat("David", "Owner1");
var cat2 = new Cat("Natasha", "Owner2");
var cat3 = new Cat("James", "Owner3");

console.log(cat1.cuteStatement());
console.log(cat2.cuteStatement());


Cat.prototype.cuteStatement = function() {
  return "everyone loves " + this.name + "!";
}

console.log(cat1.cuteStatement());
console.log(cat2.cuteStatement());

Cat.prototype.meow = function() {
  console.log("meow");
}


cat3.meow = function() {
  console.log(this.name + " says special meow");
}

cat1.meow();
cat3.meow();