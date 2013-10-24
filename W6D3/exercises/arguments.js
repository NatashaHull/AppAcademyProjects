//sum
var sum = function(){
  var sum = 0;
  for (var i = 0; i < arguments.length; i++){
    sum += arguments[i];
  }
  return sum;
}

// console.log(sum(1, 2, 3, 4));
// console.log(sum(1, 2, 3, 4, 5));

//bind
Function.prototype.myBind = function(){
  var args = Array.prototype.slice.call(arguments);
  var that = this;
  return function(){
    return that.apply(args[0], args.slice(1));
  }
}

var myFunction = function(){
  string = this
  for (var i = 0; i < arguments.length; i++){
    string += arguments[i];
  }
  return string;
}

var myObj = "wat";

var myBoundFunction = myFunction.myBind(myObj, 1, 2)
//console.log(myBoundFunction());

//curriedSum
Function.prototype.curry = function(numArgs){
  this.args = [];
  this.numArgs = numArgs;
  return this.curryCallback.bind(this);
}

Function.prototype.curryCallback = function(arg) {
  this.args.push(arg);
  if(this.args.length == this.numArgs) {
    return this.apply(null, this.args);
  } else {
    return this.curryCallback.bind(this);
  }
}

var sumThree = function(num1, num2, num3) {
  return num1 + num2 + num3;
}

var curriedSum = function(numArgs){
  var numbers = [];
  var _curriedSum = function(nextNum){
    numbers.push(nextNum);
    if (numbers.length == numArgs){
      return sum.apply(null, numbers);
    }else{
     return _curriedSum;
    }
  }
  return _curriedSum;
}

//console.log(sumThree.curry(3)(4)(20)(3));


var currySum = curriedSum(4);
console.log(currySum(5)(30)(20)(1));
