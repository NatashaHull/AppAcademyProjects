class Array
  def my_each(&prc)
    0.upto(self.length-1) { |i| prc.call(self[i]) }
  end

  def my_map(&prc)
    [].tap do |mapped_array|
      self.my_each { |el| mapped_array << prc.call(el) }
    end
  end

  def my_select(&prc)
    [].tap do |selected_els|
      self.my_each { |el| selected_els << el if prc.call(el) }
    end
  end

  def my_inject(&prc)
    accumulator = self[0]
    1.upto(self.length-1) { |el_i| accumulator = prc.call(accumulator, self[el_i]) }
    accumulator
  end

  def my_sort!(&prc)
    sorting_array = self
    self.length.times do |i|
      0.upto(self.length-2) do |el_i|
        if prc.call(sorting_array[el_i], sorting_array[el_i+1]) == 1
          sorting_array[el_i], sorting_array[el_i+1] = sorting_array[el_i+1], sorting_array[el_i]
        end
      end
    end
    sorting_array
  end
end

def splat_block_call(*args, &prc)
  if prc == nil
    puts "NO BLOCK GIVEN!"
  else
    yield(*args)
  end
end

[1,2,3].my_each { |i| puts i }
p [1,2,3].my_map { |i| i + 1 }
p [1,2,3].my_select { |i| i % 2 != 0 }
puts [1,2,3].my_inject { |sum, num| sum + num }
p [5, 3, 1, 2, 7, 0].my_sort! { |num1, num2| num1 <=> num2 }
p [5, 3, 1, 2, 7, 0].my_sort! { |num1, num2| num2 <=> num1 }

splat_block_call(1, 3, 5, 7) { |*args| p args }
splat_block_call(1, 3, 5, 7)