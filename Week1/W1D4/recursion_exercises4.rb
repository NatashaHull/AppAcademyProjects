def subsets(arr)
  if arr.length == 0
    subsets_array = [[]]
  else
    subsets_array = subsets(arr[0...-1])
    subsets_array << [arr.last]
    0.upto(arr.length-2) { |i| subsets_array << arr[i..-1] }
    subsets_array
  end
end

p subsets([]) # => [[]]
p subsets([1]) # => [[], [1]]
p subsets([1, 2]) # => [[], [1], [2], [1, 2]]