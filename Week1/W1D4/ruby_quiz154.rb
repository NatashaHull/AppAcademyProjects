def make_change(amount, currency = [25,10,5,1])
  coins = currency.sort_by { |coin| coin - amount % coin }
  change = []
  if amount == coins.last
    change << coins.last
  elsif amount > coins.last
    change << coins.last
    remainder = amount - coins.last
    change += make_change(remainder, coins)
  else
    coins.pop
    change += make_change(amount, coins)
  end
  change
end

p make_change(39)
p make_change(14, [10, 7, 1])