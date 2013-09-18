def divisible_by_seven_and_greater_than(num)
  i = num + 1
  loop do
    break if (i % 7 == 0)
    i += 1
  end
  i
end

num = 250
puts divisible_by_seven_and_greater_than(num)

def factors(num)
  (2..num).select { |divisor| num % divisor == 0 }
end

p factors(250)


def bubble_sort(arr)
  length = arr.length
  length.times do
    (0..(length - 2)).each do |current_el|
      next_el = current_el + 1
      if arr[current_el] > arr[next_el]
        arr[current_el], arr[next_el] = arr[next_el], arr[current_el]
      end
    end
  end
  arr
end

p bubble_sort([5,3,1,4,5,3,7,4])


def substrings(str)
  substrings = []
  length = str.length - 1
  (0..length).each do |sub_start|
    (sub_start..length).each do |sub_end|
      substrings << str[sub_start..sub_end]
    end
  end
  substrings.uniq
end

def subwords(str, dictionary)
  sub_words = substrings(str).select { |sub| dictionary.include?(sub) }
end


dictionary = File.readlines('dictionary.txt').map(&:chomp)

p substrings("cat")
p subwords("moonboots", dictionary)