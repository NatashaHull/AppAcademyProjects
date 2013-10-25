class Hangman
  def initialize
    @solution = "X"
    @errors = 0
    @guessed_letters = []
    @display = []
  end

  def create_solution
    until @solution.length >= 2
      @solution = File.readlines("dictionary.txt").map(&:chomp).sample
    end
  end

  def create_display
    @solution.length.times { @display << "_" }
  end

  def update_display
    @solution.split('').each_with_index do |letter, i|
      if letter == @guess
        @display[i] = letter
      end
    end
  end

  def play
    create_solution
    create_display
    player = HumanPlayer.new
    while @errors < 10
      puts "Secret word: #{@display.join(' ')}"
      puts "You have guessed: #{@guessed_letters.join(', ')}" if @guessed_letters.length > 0
      @guess = player.guess
      validate_guess(player)
      evaluate_guess
      if win?
        puts "You have guessed the secret word!"
        break
      end
      @guessed_letters << @guess
    end
    puts "Sorry, you lose" unless win?
    puts "The secret word was #{@solution}"
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
      @guess = player.guess
    end
  end

  def evaluate_guess
    if @solution.include?(@guess)
      update_display
    else
      @errors += 1
      puts "The secret word does not contain #{@guess}."
      puts "You have made #{@errors} incorrect guesses."
    end
  end

  def win?
    true if @display.join('') == @solution
  end
end

class HumanPlayer
  def guess
    puts "Please enter your guess (example: 'z' ):"
    gets.chomp.downcase
  end
end

class ComputerPlayer
end