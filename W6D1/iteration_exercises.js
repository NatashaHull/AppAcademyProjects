// Array.prototype.bubbleSort = function() {
//   return this.slice(0).bubbleSortBang();
// }

Array.prototype.bubbleSort = function() {
  var secondArray = this.slice(0);
  for(var j = 0; j <= secondArray.length; j++) {
    for(var i = 0; i < secondArray.length-1; i++) {
      var first_el = secondArray[i];
      var second_el = secondArray[i+1];
      if(first_el > second_el) {
        secondArray[i] = second_el;
        secondArray[i+1] = first_el;
      }
    };
  };
  return secondArray;
}

console.log([1,2,5,8,3,5,3,2,0].bubbleSort());


String.prototype.substrings = function() {
  var substrings = [];
  for (var i = 0; i < this.length; i++){
    for (var j = i; j < this.length; j++){
      substrings.push(this.slice(i,j+1));
    };
  };
  return substrings;
}

console.log(("cat").substrings());