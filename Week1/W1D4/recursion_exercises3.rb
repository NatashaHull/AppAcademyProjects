def merge_sort(arr)
  return arr if arr.length <= 1
  if arr.length == 2
    left, right = [arr[0]], [arr[1]]
  else
    middle = arr.length/2
    left, right = arr[0..middle], arr[middle+1..-1]
    left, right = merge_sort(left), merge_sort(right)
  end
  merge(left,right)
end

def merge(left, right)
  merged_list = []
  return merged_list if left.empty? || right.empty?
  until left.empty? || right.empty?
    if left.first <= right.first
      merged_list << left.first
      left.shift
    else
      merged_list << right.first
      right.shift
    end
  end
  merged_list += right if left.empty?
  merged_list += left if right.empty?
  merged_list
end

p merge_sort([0,5,7,3,4,2,-1])
p merge_sort([7, 5, 6, 4, 2, 3, 1, 9, 0])