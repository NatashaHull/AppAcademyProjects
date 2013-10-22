Array.prototype.my_includes = function(val) {
  for(var i = 0; i < this.length; i++) {
    if(this[i] === val) {
      return true;
    }
  };
  return false;
}

Array.prototype.my_uniq = function() {
  var uniq_array = [];
  for(var i = 0; i < this.length; i++) {
    if(!uniq_array.my_includes(this[i])) {
      uniq_array.push(this[i]);
    }
  };
  return uniq_array;
}

console.log([1, 2, 1, 3, 3].my_uniq());

Array.prototype.two_sum = function() {
  var two_sum_array = []
  for(var i = 0; i < (this.length-1); i++) {
    for(var j = (i+1); j < this.length; j++) {
      if(this[i] + this[j] === 0) {
        two_sum_array.push([i, j]);
      }
    };
  };
  return two_sum_array;
}

console.log([-1, 0, 2, -2, 1].two_sum());

Array.prototype.my_transpose = function() {
  var transposed_array = []
  for(var i = 0; i < this.length; i++) {
    var transposed_row = []
    for(var j = 0; j < this[i].length; j++) {
      transposed_row.push(this[j][i]);
    };
    transposed_array.push(transposed_row);
  };
  return transposed_array;
}

var rows = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ];

console.log(rows.my_transpose());