Array.prototype.my_includes = function(val) {
  for(var i = 0; i < this.length; i++) {
    if(this[i] === val) {
      return true;
    }
  };
  return false;
}

	var grid = new Array(8)
  for (var i = 0; i < 8; i++){
    grid[i] = new Array(8);
  }

console.log(grid);
console.log([undefined].my_includes(undefined));