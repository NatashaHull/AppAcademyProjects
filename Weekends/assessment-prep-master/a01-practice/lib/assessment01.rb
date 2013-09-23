def is_prime?(num)
  (2..Math.sqrt(num)).each do |factor|
    return false if num % factor == 0
  end
  true
end

def primes(count)
  primes = []
  potential_prime = 2
  until primes.length == count
    primes << potential_prime if is_prime?(potential_prime)
    potential_prime == 2 ? potential_prime += 1 : potential_prime += 2
  end
  primes
end

def factorials_rec(num)
  return [num] if num == 1
  factorials = factorials_rec(num-1)
  factorials << num * factorials.last
end

class Array
  def dups
    dups_hash = {}
    self.each do |el|
      indeces = find_indeces(el)
      dups_hash[el] = indeces if indeces.length > 1
    end
    dups_hash
  end

  def find_indeces(el)
    indeces = []
    0.upto(self.length-1) do |index|
      indeces << index if self[index] == el
    end
    indeces
  end
end

class String
  def substrings
    subs = []
    0.upto(self.length-1) do |start_sub|
      (start_sub+1).upto(self.length-1) do |end_sub|
        subs << self.slice(start_sub..end_sub)
      end
    end
    subs
  end

  def symmetric?
    self == self.reverse
  end

  def symmetric_substrings
    subs = self.substrings
    symmetric_subs = []
    subs.each { |sub| symmetric_subs << sub if sub.symmetric? }
    symmetric_subs
  end
end

class Array
  def bubble_sort(&blk)
    self.dup.bubble_sort!(&blk)
  end
  def bubble_sort!(&blk)
    blk = Proc.new { |num1, num2| num1 <=> num2 } unless blk
    self.length.times do
      (0..self.length-2).each do |el_i|
        if blk.call(self[el_i], self[el_i+1]) == 1
          self[el_i], self[el_i+1] = self[el_i+1], self[el_i]
        end
      end
    end
    self
  end
end
