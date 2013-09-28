class Player
  attr_reader :name, :hand
  attr_accessor :pot

  def initialize(name)
    @name = name
    @hand = Hand.new
    @pot = 100
  end

  def bet
    puts "Your hand is:"
    hand.display
    puts "What would you like to bet?"
    puts "If you would like to fold, you must bet less than the minimum."
    puts "You have #{@pot} dollars!"
    bet_amount = gets.chomp.to_i
    return 0 if bet_amount > @pot
    @pot -= bet_amount
    return bet_amount
  end

  def discard
    #The following assumes intelligence on the part of the users
    puts "Your hand is:"
    hand.display
    puts "Which card indeces would you like to remove (0-4)"
    cards = gets.split(',').map(&:to_i).uniq

    #Makes it so that the cards are only discarded in reverse order
    cards.sort!.reverse!
    cards.each do |card_i|
      card = @hand.cards[card_i]
      @hand.discard_card(card)
    end
  end
end