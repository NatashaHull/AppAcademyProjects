class Mastermind
  OPTIONS = ["red", "green", "blue", "yellow", "orange", "purple"]

  def initialize
    @win = false
  end

  def play
    create_solution
    player = create_player
    10.times do |guess_num|
      puts "This is guess number #{guess_num+1}"
      @guess = player.guess
      validate_guess(player)
      evaluate_guess
      if @win
        puts "You won in #{guess_num+1} guesses"
        break
      end
    end
    unless @win
      puts "You lose, the solution was #{@solution.join(', ')}"
    end
  end

  def valid_guess?
    valid_colors = @guess.select { |color| OPTIONS.include?(color) }
    @guess == valid_colors && @guess.length == 4
  end

  def validate_guess(player)
    until valid_guess?
      puts "Guess invalid, try again"
      @guess = player.guess
    end
  end

  def evaluate_guess
    @win = true if @guess == @solution
    (0..3).each do |peg|
      if @solution[peg] == @guess[peg]
        puts "The #{@guess[peg]} in the #{peg+1} spot is correct."
      elsif @solution.include?(@guess[peg])
        puts "The #{@guess[peg]} in the #{peg+1} spot is correct, but in the wrong spot."
      end
    end
  end

  private

  def create_solution
    options = OPTIONS.shuffle
    @solution = options[0..3]
  end

  def create_player
    Player.new
  end
end

class Player
  def guess
    #format guess.
    puts "Input your guess, options are #{Mastermind::OPTIONS.join(', ')}:"
    gets.downcase.split(',').map(&:strip)
  end
end