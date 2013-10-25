class Hangman
  DICTIONARY = File.readlines("dictionary.txt").map(&:chomp)
  attr_reader :display

  def initialize
    @errors = 0
    @guessed_letters = []
    @display = []
  end

  def create_display(solution_length)
    solution_length.times { @display << "_" }
  end

  def print_hangman
    case @errors
    when 1
      puts "-----------"
      puts "|         |"
      puts "|         |"
      puts "|         |"
      puts "|         |"
      puts "|         |"
      puts "| _ _     |"
      puts "-----------"
    when 2
      puts "-----------"
      puts "|         |"
      puts "|  |      |"
      puts "|  |      |"
      puts "|  |      |"
      puts "|  |      |"
      puts "| _|_     |"
      puts "-----------"
    when 3
      puts "-----------"
      puts "|  _____  |"
      puts "|  |      |"
      puts "|  |      |"
      puts "|  |      |"
      puts "|  |      |"
      puts "| _|_     |"
      puts "-----------"
    when 4
      puts "-----------"
      puts "|  _____  |"
      puts "|  |   |  |"
      puts "|  |      |"
      puts "|  |      |"
      puts "|  |      |"
      puts "| _|_     |"
      puts "-----------"
    when 5
      puts "-----------"
      puts "|  _____  |"
      puts "|  |   |  |"
      puts "|  |   O  |"
      puts "|  |      |"
      puts "|  |      |"
      puts "| _|_     |"
      puts "-----------"
    when 6
      puts "-----------"
      puts "|  _____  |"
      puts "|  |   |  |"
      puts "|  |   O  |"
      puts "|  |   |  |"
      puts "|  |      |"
      puts "| _|_     |"
      puts "-----------"
    when 7
      puts "-----------"
      puts "|  _____  |"
      puts "|  |   |  |"
      puts "|  |   O  |"
      puts "|  |  /|  |"
      puts "|  |      |"
      puts "| _|_     |"
      puts "-----------"
    when 8
      puts "-----------"
      puts "|  _____  |"
      puts "|  |   |  |"
      puts "|  |   O  |"
      puts "|  |  /|\\ |"
      puts "|  |      |"
      puts "| _|_     |"
      puts "-----------"
    when 9
      puts "-----------"
      puts "|  _____  |"
      puts "|  |   |  |"
      puts "|  |   O  |"
      puts "|  |  /|\\ |"
      puts "|  |  /   |"
      puts "| _|_     |"
      puts "-----------"
    when 10
      puts "-----------"
      puts "|  _____  |"
      puts "|  |   |  |"
      puts "|  |   O  |"
      puts "|  |  /|\\ |"
      puts "|  |  /\\  |"
      puts "| _|_     |"
      puts "-----------"
    end
  end

  def create_guesser
    puts "Would you like the word guesser to be a human or an ai? (example: 'human')"
    player = gets.chomp.downcase
    if player == "human"
      @guesser = HumanPlayer.new
    elsif player == "ai"
      @guesser = ComputerPlayer.new
    else
      puts "You must put either 'human', or 'ai'!"
      create_guesser
    end
  end

  def create_chooser
    puts "Would you like the word picker to be a human or an ai? (example: 'human')"
    player = gets.chomp.downcase
    if player == "human"
      @chooser = HumanPlayer.new
    elsif player == "ai"
      @chooser = ComputerPlayer.new
    else
      puts "You must put either 'human', or 'ai'!"
      create_chooser
    end
  end

  def create_players
    create_guesser
    create_chooser
  end

  def update_display(guess, indeces)
    indeces.each do |i|
      @display[i] = guess
    end
  end

  def play
    create_players
    solution_length = @chooser.create_solution
    create_display(solution_length)
    while @errors < 10
      puts "Secret word: #{@display.join(' ')}"
      puts "You have guessed: #{@guessed_letters.join(', ')}" if @guessed_letters.length > 0
      @guess = @guesser.guess(@display)
      validate_guess(@guesser)
      move = @chooser.evaluate_guess(@guess)
      if move
        update_display(move[0], move[1])
      else
        @errors += 1
        print_hangman
        puts "The secret word does not contain #{@guess}."
        puts "You have made #{@errors} incorrect guesses."
      end
      if win?
        puts "You have guessed the secret word!"
        break
      end
      @guessed_letters << @guess
    end
    if win?
      puts "The secret word was #{@display.join('')}"
    else
      puts "Sorry, you lose"
      puts "The solution was #{@chooser.solution}"
    end
  end

  def is_valid?
    valid_guesses = ("a".."z").to_a - @guessed_letters
    if !("a".."z").to_a.include?(@guess)
      puts "This is not a letter, try again."
      return false
    elsif @guessed_letters.include?(@guess)
      puts "You have guessed this already"
      return false
    end
    return true
  end

  def validate_guess(player)
    until is_valid?
      @guess = player.guess(@display)
    end
  end

  def win?
    true unless @display.include?("_")
  end
end

class HumanPlayer
  def guess(display_array)
    puts "Please enter your guess (example: 'z' ):"
    gets.chomp.downcase
  end

  def create_solution
    puts "How long is your word?"
    length = gets.chomp.to_i
    if length < 2
      puts "Too short, try again."
      create_solution
    elsif length > Hangman::DICTIONARY.sort_by(&:length).last.length
      puts "Too long, try again."
      create_solution
    else
      length
    end
  end

  def player_response_to_guess(guess)
    puts "Player 1 has guessed #{guess}, is this in your word? (Yes, or No)"
    boolean = gets.chomp.downcase
    case boolean
    when "yes"
      boolean = true
    when "no"
      boolean = false
    else
      puts "Invalid input, try again."
      player_response_to_guess(guess)
    end
    boolean
  end

  def evaluate_guess(guess)
    boolean = player_response_to_guess(guess)
    if boolean
      puts "Where in the word is #{guess}? (Hello has l, at 3, 4)"
      indeces = gets.split(',').map { |index| index.strip.to_i - 1 } #Deal with invalid input
      return [guess, indeces]
    else
      return false
    end
  end

  def solution
    puts "What is the solution?"
    gets.chomp
  end
end

class ComputerPlayer
  def initialize
    @guessed = []
  end

  def create_solution
    until @solution.to_s.length >= 2 && !@solution.include?("-")
      @solution = Hangman::DICTIONARY.sample
    end
    @solution.length
  end

  def possible_words(display_array)
    more_words = []
    word_length = display_array.length
    possible_words = Hangman::DICTIONARY.select { |word| word.length == word_length }
    possible_words.each do |word|
      word_length.times do |i|
        unless display_array[i] == "_"
           break unless word[i] == display_array[i]
        end
        more_words << word if i == (word_length-1)
      end
    end
    more_words
  end

  def pick_letter(words, display_array)
    letter_repetition = Hash.new(0)
    words.each do |word|
      word.split('').each do |letter|
        letter_repetition[letter] += 1 unless (display_array.include?(letter) || @guessed.include?(letter))
      end
    end
    raise "Your word is not in the dictionary!" if letter_repetition.empty?
    letter_repetition.sort_by { |letter| letter.last }.last[0]
  end

  def guess(display_array)
    words = possible_words(display_array)
    letter = pick_letter(words, display_array)
    @guessed << letter
    letter
  end

  def evaluate_guess(guess)
    if @solution.include?(guess)
      indeces = []
      @solution.split('').each_with_index do |letter, i|
        if letter == guess
          indeces << i
        end
      end
      return [guess, indeces]
    else
      return false
    end
  end

  def solution
    @solution
  end
end