def remix(mixes)
  alcohols = []
  soft_drinks = []
  mixes.each do |mix|
    alcohols << mix[0]
    soft_drinks << mix[1]
  end
  alcohols.shuffle.zip(soft_drinks.shuffle)
end

p remix([
  ["rum", "coke"],
  ["gin", "tonic"],
  ["scotch", "soda"]
])
#=> [["rum, "tonic"], ["gin", "soda"], ["scotch", "coke"]]