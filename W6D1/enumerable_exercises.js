Array.prototype.multiples = function(multiple) {
  var multiples = [];
  for (var i = 0; i < this.length; i++){
    multiples.push(this[i] * multiple);
  }
  return multiples;
}

console.log([1,2,3,4,5].multiples(5));

Array.prototype.myEach = function(someFunction){
  for (var i = 0; i < this.length; i++){
    someFunction(this[i]);
  }
  return this;
}

var putsFunction = function(value){
  console.log(value);
}

console.log([1,2,3,4,5].myEach(putsFunction));

Array.prototype.myMap = function(someFunction){
  var secondArray = [];
  function pushChangedValue(value){
    secondArray.push(someFunction(value));
  }
  this.myEach(pushChangedValue);
  return secondArray;
}

var timesTwoFunction = function(value) {
  return value * 2;
}

console.log([1,2,3,4,5].myMap(timesTwoFunction));

Array.prototype.myInject = function(someFunction) {
  accum = this[0]

  function alterValues(value) {
    accum = someFunction(accum, value)
  }

  this.slice(1).myEach(alterValues);
  return accum;
}

var add = function(accum, value) {
  return accum + value;
}

console.log([1,2,3,4,5].myInject(add));