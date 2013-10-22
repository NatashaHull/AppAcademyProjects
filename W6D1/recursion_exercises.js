var range = function(start, end) {
  var elements = new Array();
  elements.push(start);
  if (start !== end) {
    elements = elements.concat(range(start+1, end));
  }
  return elements;
}

// console.log(range(10,20));

var sumIter = function(arr) {
  var accum = 0;
  for(var i = 0; i < arr.length; i++) {
    accum += arr[i];
  };
  return accum;
}

var sumRec = function(arr) {
  if(arr.length === 1) {
    return arr[0];
  } else {
    var accum = arr[0];
    accum += sumRec(arr.slice(1));
  }
  return accum;
}

// console.log(sumIter([1,2,3,4,5]));
// console.log(sumRec([1,2,3,4,5]));

var exp1 = function(num, pow) {
  if(pow === 0) {
    return 1
  } else {
    return num * exp1(num, pow-1)
  }
}

var exp2 = function(num, pow) {
  if(pow === 0) {
    return 1;
  } else if(pow % 2 === 0) {
     val = exp2(num, pow/2);
     return val * val;
  } else {
    val = exp2(num, (pow -1)/2);
    return num * (val * val);
  }
}

// console.log(exp1(2,4));
// console.log(exp2(2,4));

var fibIter = function(n) {
  var fib_nums = [];
  if(n > 0) {
    fib_nums.push(0);
  }
  if(n > 1) {
    fib_nums.push(1);
  }
  if(n > 2) {
    for(var i = 2; i < n; i++) {
      first = parseInt(fib_nums.slice(-1));
      second = parseInt(fib_nums.slice(-2))
      fib_nums.push( first + second );
    }
  }
  return fib_nums;
}

var fibRec = function(n) {
  switch(n) {
    case 0:
      return [];
      break;
    case 1:
      return [0];
      break;
    case 2:
      return [0,1];
      break;
    default:
      var fibs = fibRec(n-1);
      fibs.push(parseInt(fibs.slice(-1)) + parseInt(fibs.slice(-2)));
  }
  return fibs;
}

console.log(fibRec(5));