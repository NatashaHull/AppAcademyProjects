def stock_picker(arr)
  best_difference = 0
  best_days = []
  arr.each_index do |first_day|
    break if first_day == arr.length-1
    (first_day+1...arr.length).each do |last_day|
      if arr[last_day] - arr[first_day] > best_difference
        best_difference = arr[last_day] - arr[first_day]
        best_days = [first_day, last_day]
      end
    end
  end
  best_days
end