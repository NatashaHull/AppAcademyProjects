Assessment = {};

Assessment.mergeSort = function(array) {
  if(array.length <= 1) return array;
  var middle = array.length / 2;
  var left = array.slice(0, middle);
  var right = array.slice(middle);
  
  return Assessment.merge(Assessment.mergeSort(left), Assessment.mergeSort(right));
};

Assessment.merge = function(left, right) {
  var result = [];
  
  while(left.length > 0 && right.length > 0) {
    if(left[0] < right[0]) {
      result.push(left.shift());
    } else {
      result.push(right.shift());
    }
  }
  
  return result.concat(left).concat(right);
}

Assessment.recursiveExponent = function(base, power) {
  if(power === 1) return base;
  return base * Assessment.recursiveExponent(base, power - 1);
};

Assessment.powCall = function (base, power, callback) {
  var result = Assessment.recursiveExponent(base, power);
  callback(result);
  return result;
};

Assessment.transpose = function (matrix) {
  var columns = [];
  
  for (var i = 0; i < matrix[0].length; i++) {
    columns.push([]);
  }

  for (var i = 0; i < matrix.length; i++) {
    for (var j = 0; j < matrix[i].length; j++) {
      columns[j].push(matrix[i][j]);
    }
  }

  return columns;
};

Assessment.primes = function (n) {
  var primeArr = [];
  var i = 1;
  
  while(primeArr.length < n) {
    i++;
    if(isPrime(i)) primeArr.push(i); 
  }
  
  return primeArr;
};

var isPrime = function(n) {
  var i = parseInt(n / 2) + 1;
  while(--i > 1) {
    if(n % i == 0) return false;
  }
  return true;
};

Function.prototype.myCall = function(context, rgs) {
  return this.bind(context, rgs)();
};

Function.prototype.inherits = function(Parent) {
  function Surrogate() {};
  Surrogate.prototype = Parent.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
};