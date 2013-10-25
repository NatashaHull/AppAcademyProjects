def range(start_num, end_num)
  range_array = [start_num] unless range_array
  range_array += range(start_num+1, end_num) unless start_num == end_num
  range_array
end

p range(1, 10)

def sum_array_iterative(arr)
  sum = 0
  sum_array = arr.dup
  until sum_array.length == 0
    sum += sum_array.pop
  end
  sum
end

def sum_array_recursive(arr)
  sum = 0
  add_together_rest_of_array(arr.dup, sum)
end

def add_together_rest_of_array(sum_array, sum)
  if sum_array.length > 0
    sum += sum_array.pop
    add_together_rest_of_array(sum_array, sum)
  else
    sum
  end
end

puts sum_array_iterative([1,3,5])
puts sum_array_recursive([1,3,5])

def exponent_recursion_one(num, exp)
  return 1 if exp == 0
  num * exponent_recursion_one(num, exp-1)
end

def exponent_recursion_two(num, exp)
  if exp == 0
    1
  elsif exp % 2 != 0
    recursive_result = exponent_recursion_two(num, ((exp-1)/2))
    num * recursive_result * recursive_result
  else
    recursive_result = exponent_recursion_two(num, exp/2)
    recursive_result * recursive_result
  end
end

puts 2 ** 32
puts exponent_recursion_one(2, 32)
puts exponent_recursion_two(2, 32)

class Array
  def deep_dup(arr=self)
    [].tap do |duplicated_array|
      arr.each { |el| el.is_a?(Array)? duplicated_array << deep_dup(el) : duplicated_array << el }
    end
  end
end

#Creating test variables from exercise source
robot_parts = [["nuts", "bolts", "washers"], ["capacitors", "resistors", "inductors"]]
robot_parts_copy = robot_parts.deep_dup
sample_array = [1, [2], [3, [4]]]
sample_array_copy = sample_array.deep_dup

# shouldn't modify initial arrays
robot_parts_copy[1] << "LEDs"
sample_array_copy[2][1] << [5]

p robot_parts[1]
p robot_parts_copy[1]
p sample_array
p sample_array_copy