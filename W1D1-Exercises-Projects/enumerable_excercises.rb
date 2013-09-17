def two_times(arr)
  arr.map { |i| i*2 }
end

class Array
  def my_each
    0.upto(self.length-1) do |num|
      yield(self[num])
    end
    self
  end
end

def is_odd?(num)
  num % 2 != 0
end

def median(arr)
  arr.sort!
  if is_odd?(arr.length)
    return arr[arr.length / 2]
  else
    n1 = arr[arr.length / 2]
    n2 = arr[(arr.length / 2) - 1]
    return (n1 + n2) / 2
  end
end

def concatenate(arr)
  arr.inject(:+)
end

# calls my_each twice on the array, printing all the numbers twice.
return_value = [1, 2, 3].my_each do |num|
  p num
end.my_each do |num|
  puts num
end

p return_value

p median([1,2,4,5])
p median([3,4,2])

p concatenate(["Yay ", "for ", "strings!"])