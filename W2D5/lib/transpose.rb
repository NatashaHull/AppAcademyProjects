def my_transpose(arr)
  transposed_array = []
  (0...arr.length).each do |col|
    col_array = []
    (0...arr.length).each do |row|
      col_array << arr[row][col]
    end
    transposed_array << col_array
  end
  transposed_array
end