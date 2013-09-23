def is_prime?(num)
  (2...num).none? { |factor| num % factor == 0 }
end

def primes(count)
  primes = []

  i = 2
  until primes.count >= count
    primes << i if is_prime?(i)

    i += 1
  end

  primes
end

def factorials_rec(num)
  return [1] if num == 1

  rest_facs = factorials_rec(num - 1)
  rest_facs + [(rest_facs.last * num)]
end

class Array
  def dups
    positions = {}
    each_with_index do |item, index|
      unless positions.has_key?(item)
        positions[item] = []
      end

      positions[item] << index
    end

    positions.each_with_object({}) { |(key, val), h| h[key] = val if val.count > 1 }
  end
end

class String
  def symmetric_substrings
    symm_subs = []

    length.times do |start_pos|
      (1..(length - start_pos)).each do |len|
        next if len < 2

        substr = self[start_pos...(start_pos + len)]
        symm_subs << substr if substr == substr.reverse
      end
    end

    symm_subs
  end

  def subword_counts(dictionary)
    counts = Hash.new(0)
    length.times do |i1|
      length.times do |i2|
        next if i2 < i1

        substring = self[i1..i2]
        counts[substring] += 1 if dictionary.include?(substring)
      end
    end

    counts
  end
end

class Array
  def bubble_sort(&blk)
    self.dup.bubble_sort!(&blk)
  end

  def bubble_sort!(&blk)
    # See how I create a Proc if no block was given; this eliminates
    # having to later have two branches of logic, one for a block and
    # one for no block.
    blk = Proc.new { |x, y| x <=> y } unless blk

    sorted = false
    until sorted
      sorted = true

      count.times do |i|
        next if i == count - 1

        if blk.call(self[i], self[i + 1]) == 1
          # Parallel assignment; use it when swapping.
          self[i], self[i + 1] = self[i + 1], self[i]
          sorted = false
        end
      end
    end

    self
  end
end
