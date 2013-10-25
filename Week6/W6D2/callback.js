function Clock() {
  var now = new Date();
  this.hours = now.getHours();
  this.minutes = now.getMinutes();
  this.seconds = now.getSeconds();

  var clock = this;
  var tick = function() {
    clock.seconds += 5;
    if (clock.seconds >= 60) {
      clock.seconds -= 60;
      clock.minutes += 1;
    }
    if (clock.minutes >= 60) {
      clock.minutes -= 60;
      clock.hours += 1;
    }
    if (clock.hours >= 24) {
      clock.hours -= 24;
    }
    console.log(clock.hours + ":" + clock.minutes + ":" + clock.seconds);
    setTimeout(tick, 5000);
  };
  tick();
}

// new Clock();

var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var addNumbers = function(sum, numsleft, completionCallback) {
  if(numsleft > 0) {
    reader.question("Enter the next number:", function(num) {
      sum += parseInt(num);
      numsleft -= 1;
      addNumbers(sum, numsleft, completionCallback);
    });
  } else {
    completionCallback(sum);
  }
};

// addNumbers(0, 4, function (sum) {
//   console.log("Total Sum: " + sum);
//   reader.close();
// });

var crazyBubbleSort = function(arr, sortCompletionCallback) {
  var sortPassCallback = function(madeAnySwaps) {
    if (madeAnySwaps) {
      performSortPass(arr, 0, false, sortPassCallback);
    } else {
      reader.close();
      sortCompletionCallback(arr);
    }
  };
  sortPassCallback(true);
}

var askLessThan = function(el1, el2, callback) {
  console.log(el1 + " then " + el2);
  reader.question("Are these in the right order? (yes, no):\n", function(answer) {
    callback(answer === "yes");
  })
}

var performSortPass = function(arr, i, madeAnySwaps, callback) {
  if (i < arr.length - 1) {
    askLessThan(arr[i], arr[i + 1], function(lessThan) {
      if (!lessThan) {
        var temp = arr[i];
        arr[i] = arr[i + 1];
        arr[i + 1] = temp;
        madeAnySwaps = true;
      }
      performSortPass(arr, i + 1, madeAnySwaps, callback);
    })
  } else {
    callback(madeAnySwaps);
  }
}

crazyBubbleSort([3, 2, 1], function (arr) { console.log(arr) });