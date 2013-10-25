class Array
  def my_uniq
    result = []
    self.each do |val|
      result << val unless result.include?(val)
    end
    result
  end

  def two_sum
    result = []
    0.upto(self.length-1) do |x|
      (x+1).upto(self.length-1) do |y|
        result << [x, y] if self[x] + self[y] == 0
      end
    end
    result
  end
end

p [1, 2, 1, 3, 3].my_uniq
p [-1, 0, 2, -2, 1].two_sum


def my_transpose(arr)
  result = []
  0.upto(arr.length-1) do |col|
		new_row = []
		arr.each do |row|
			new_row << row[col]
		end
		result << new_row
	end
	result
end

rows = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
	]

cols = [
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
  ]

p my_transpose(rows)
p my_transpose(cols)

def stock_picker(stocks)
	max_ids = [0,0]
	stocks.each_with_index do |buy, buy_i|
		buy_i.upto(stocks.length-1) do |sell_i|
			sell = stocks[sell_i]
			if sell - buy > stocks[max_ids[1]] - stocks[max_ids[0]]
				max_ids = [buy_i, sell_i]
			end
		end
	end
	max_ids
end

p stock_picker([0, 20, 5, 8])
p stock_picker([5,10,100,20])