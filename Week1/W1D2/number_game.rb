class NumberGuessingGame
  def initialize
    @secret_number = rand(100)
    @number_of_guesses = 0
  end

  def evaluate_guess(guess)
    puts "Your guess is too high" if guess > @secret_number
    puts "Your guess is too low" if guess < @secret_number
  end

  def play
    loop do
      puts "Guess which number the computer has chosen:"
      guess = gets.chomp.to_i
      break if guess == @secret_number
      evaluate_guess(guess)
    end
    puts "You win!"
  end
end

game = NumberGuessingGame.new
game.play