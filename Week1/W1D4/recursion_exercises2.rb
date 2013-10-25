def fibonacci_iterative(length)
  fibonacci_nums = []
  fibonacci_nums << 0
  fibonacci_nums << 1 if length > 1
  while fibonacci_nums.length < length
      fibonacci_nums << fibonacci_nums[-1] + fibonacci_nums[-2]
  end
  fibonacci_nums
end

def fibonacci_recursive(length)
  if length == 1
    [0]
  elsif length == 2
    [0,1]
  else
    fibonacci_nums = fibonacci_recursive(length-1)
    fibonacci_nums << fibonacci_nums[-1] + fibonacci_nums[-2]
    fibonacci_nums
  end
end

#Checking the iterative methods
p fibonacci_iterative(1)
p fibonacci_iterative(2)
p fibonacci_iterative(20)

#Checking the recursive methods
p fibonacci_recursive(1)
p fibonacci_recursive(2)
p fibonacci_recursive(20)


#Binary Search
def bsearch(arr, target)
  if arr.empty?
    puts "Value not in array"
    return 0
  end
  middle = (arr.length)/2
  if arr[middle] == target
    middle
  elsif arr[middle] < target
    middle + bsearch(arr[middle..-1], target)
  else
    bsearch(arr[0...middle], target)
  end
end

animals = ["cat", "dog", "giraffe", "mouse", "rat"]

#Checks the index against the bsearch value
puts animals.index("cat")
puts bsearch(animals, "cat")
puts animals.index("giraffe")
puts bsearch(animals, "giraffe")
puts animals.index("rat")
puts bsearch(animals, "rat")
