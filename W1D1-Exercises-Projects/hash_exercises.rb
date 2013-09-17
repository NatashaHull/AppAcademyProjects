def set_add_el(hash, element)
  hash[element] = true
  hash
end

def set_remove_el(hash, element)
  hash.delete(element)
  hash
end

def set_list_els(hash)
  hash.keys
end

def set_member?(hash, element)
  hash.has_key?(element)
end

def set_union(hash1, hash2)
  hash1.merge(hash2)
end

def set_intersection(hash1, hash2)
  result = {}
  hash1.keys.each do |k1|
    hash2.keys.each do |k2|
      result[k1] = true if k1 == k2
    end
  end
  result
end

def set_minus(hash1, hash2)
  result = {}
  intersection = set_intersection(hash1, hash2)
  combined_hash = set_union(hash1, hash2)
  combined_hash.keys.each do |key|
    result[key] = true unless intersection.has_key?(key)
  end
  result
end

p set_add_el({}, :x) # => make this return {:x => true}
p set_add_el({:x => true}, :x) # => {:x => true} # This should automatically work if the first method worked
p set_remove_el({:x => true}, :x) # => {}
p set_list_els({:x => true, :y => true}) # => [:x, :y]
p set_member?({:x => true}, :x) # => true
p set_union({:x => true}, {:y => true}) # => {:x => true, :y => true}
p set_intersection({:x => true, :z => true}, {:x => true, :y => true}) # I'm not going to tell you how the last two work
p set_minus({:x => true, :z => true}, {:x => true, :y => true}) # Return all elements of the first array that are not in the second array, not vice versa

def correct_hash(hash, offset)
  result = {}
  keys = hash.keys
  values = hash.values
  0.upto(keys.length-1) do |key_i|
    if key_i + offset < keys.length
      result[keys[key_i + offset]] = values[key_i]
    else
      result[keys[key_i + offset - keys.length]] = values[key_i]
    end
  end
  result
end

wrong_hash = { :a => "banana", :b => "cabbage", :c => "dental_floss", :d => "eel_sushi" }
p correct_hash(wrong_hash, 1)