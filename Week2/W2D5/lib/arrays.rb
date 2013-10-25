class Array
  def my_uniq
    [].tap do |uniq_array|
      self.each { |el| uniq_array << el unless uniq_array.include?(el) }
    end
  end

  def two_sum
    indeces = []
    self.each_index do |el1|
      break if el1 == self.length-1
      (el1+1...self.length).each do |el2|
        indeces << [el1,el2] if (self[el1]+self[el2] == 0)
      end
    end
    indeces
  end
end