#NUM_TO_S
NUMBERS = ("0".."9").to_a
("A".."F").each { |lnum| NUMBERS << lnum }

p NUMBERS

def num_to_s(num,base)
  result = ""
  divisor = 1
  until divisor > num
    next_num = (num / divisor) % base
    result += NUMBERS[next_num]
    divisor *= base
  end
  result.reverse
end

puts num_to_s(5, 10) #=> "5"
puts num_to_s(5, 2)  #=> "101"
puts num_to_s(5, 16) #=> "5"

puts num_to_s(234, 10) #=> "234"
puts num_to_s(234, 2)  #=> "11101010"
puts num_to_s(234, 16) #=> "EA"

#CAESAR CIPHER
def caesar(word, num)
  result = []
  0.upto(word.length-1) do |letter_i|
    letter_num = word[letter_i].ord + num
    if letter_num <= "z".ord
      result << letter_num.chr
    else
      result << (letter_num - ("z".ord - "a".ord)).chr
    end
  end
  result.join('')
end

puts caesar("hello", 3)