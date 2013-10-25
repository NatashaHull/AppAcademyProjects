var binarySearch = function(array, target){
  median = Math.floor(array.length / 2);
  if (array[median] === target){
    return median;
  } else if (array[median] < target){
    return median + binarySearch(array.slice(median), target);
  } else {
    return binarySearch(array.slice(0,median), target);
  }
}

var array = [1,2,3,4,5,6,7,8,9,10,11,12,13]

// console.log(binarySearch(array, 4));
// console.log(binarySearch(array, 7));
// console.log(binarySearch(array, 1));
// console.log(binarySearch(array, 12));
// console.log(binarySearch(array, 13));

// var makeChange = function(num) {
//   var changeAmounts = [25, 10, 5, 1];
//   var bestChange = 25;
//   for(var i = 0; i < changeAmounts.length; i++) {
//     var possibleBest = (num % changeAmounts[i]) + (num / changeAmounts[i])
//     var currentBest =  (num / bestChange) + (num % bestChange)
//     if(currentBest > possibleBest) {
//       bestChange = changeAmounts[i];
//     }
//   }
//   // console.log(num)
//   // console.log(bestChange)
//   if(num === bestChange) {
//     return [bestChange];
//   } else {
//     var suggestedChange = makeChange(num - bestChange);
//     suggestedChange.push(bestChange);
//     return suggestedChange;
//   }
// }

var makeChange2 = function(num) {
  var changeAmounts = [25, 10, 5, 1];
  for (var i = 0; i < changeAmounts.length; i++){
    if (num / changeAmounts[i] >= 1){
      var bestChange = changeAmounts[i];
      break;
    }
  }

  if (num === bestChange){
    return [bestChange];
  } else {
    var suggestedChange = [bestChange];
    return suggestedChange.concat(makeChange2(num-bestChange));
  }
}

console.log(makeChange2(89));