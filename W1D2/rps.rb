def rps(action)
  computer_choice = %w{rock paper scissors}.sample

  case action.downcase
  when computer_choice
    return "You both chose #{computer_choice}. Tie!"
  when "rock"
    if computer_choice == 'scissors'
      return "Computer chose '#{computer_choice}', you win!"
    else
      return "Computer chose '#{computer_choice}', you lose!"
    end

  when "scissors"
    if computer_choice == 'paper'
      return "Computer chose '#{computer_choice}', you win!"
    else
      return "Computer chose '#{computer_choice}', you lose!"
    end
  when "paper"
    if computer_choice == 'rock'
      return "Computer chose '#{computer_choice}', you win!"
    else
      return "Computer chose '#{computer_choice}', you lose!"
    end
  end
end