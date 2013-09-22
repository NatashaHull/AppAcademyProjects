require 'set'

DICTIONARY = File.readlines('dictionary.txt').map(&:chomp).sort
def adjacent_words(word, dictionary=DICTIONARY)
  adjacent_words_array = []
  word_duplicate = word.dup
  word.split('').each_with_index do |letter_in_word, letter_i|
    ("a".."z").each do |changed_letter|
      next if letter_in_word == changed_letter
      check_word = word_duplicate.dup
      check_word[letter_i] = changed_letter
      adjacent_words_array << check_word if dictionary.include?(check_word)
    end
  end
  adjacent_words_array
end

def similar_letter_count(word, end_word)
  correctly_placed_letters = 0
  0.upto(word.length-1) { |letter_i| correctly_placed_letters += 1 if word[letter_i] == end_word[letter_i] }
  word.length - correctly_placed_letters
end

def find_chain(start_word, end_word)
  current_word = start_word
  current_words = [start_word]
  visited_words = Set[start_word]
  path = { start_word => [start_word] }
  until current_word == end_word
    return false if current_words.empty?
    current_words.sort_by! { |word| path[word].length + similar_letter_count(word, end_word) }
    current_word = current_words.shift
    break if current_word == end_word
    adjacent_words(current_word).each do |word|
      next if visited_words.include?(word)
      current_words << word
      visited_words << word
      path[word] = path[current_word] + [word]
    end
  end
  path[end_word]
end

p find_chain("week", "year")
p find_chain("brake", "brand")
p find_chain("brake", "salad")