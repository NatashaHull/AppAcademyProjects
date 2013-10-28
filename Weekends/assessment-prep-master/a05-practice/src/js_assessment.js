Assessment = {};

Assessment.mergeSort = function(array) {
  if(array.length <= 1) {
    return array;
  }

  var leftArr = array.slice(0, array.length/2);
  var rightArr = array.slice(array.length/2);
  var arr1 = Assessment.mergeSort(leftArr);
  var arr2 = Assessment.mergeSort(rightArr);
  return Assessment.merge(arr1, arr2);
};

Assessment.merge = function(arr1, arr2) {
  var mergedArray = [];
  if(arr1.length > 0 && arr2.length > 0) {
    if(arr1[0] < arr2[0]) {
      mergedArray.push(arr1.shift());
    } else {
      mergedArray.push(arr2.shift());
    }
  } else if(arr1.length === 0) {
    return arr2;
  } else {
    return arr1;
  }

  return mergedArray.concat(Assessment.merge(arr1, arr2));
};

Assessment.recursiveExponent = function(base, power) {
  if(power === 0) {
    return 1;
  } else {
    return base * Assessment.recursiveExponent(base, power-1);
  }
};

Assessment.powCall = function (base, power, callback) {
  var result = Assessment.recursiveExponent(base, power);
  callback(result);
  return result
};

Assessment.transpose = function (matrix) {
  var transposed_arr = []
  for(var i = 0; i < matrix.length; i++) {
    transposed_row = []
    for(var j=0; j < matrix[i].length; j++) {
      transposed_row.push(matrix[j][i]);
    }
    transposed_arr.push(transposed_row);
  }
  return transposed_arr;
};

Assessment.primes = function (n) {
  primesArr = [];
  var prime = 2;
  while(n > primesArr.length) {
    if(Assessment.isPrime(prime)) {
      primesArr.push(prime);
    }
    prime++;
  }
  return primesArr;
};

Assessment.isPrime = function(num) {
  for(var i = 2; i <= Math.sqrt(num); i++) {
    if(num % i === 0) {
      return false;
    }
  }
  return true;
}

Function.prototype.myCall = function (context, argArray) {
  return this.bind(context, argArray)();
};

Function.prototype.inherits = function (Parent) {
  function Substitute() {};
  Substitute.prototype = Parent.prototype;
  this.prototype = new Substitute;
};