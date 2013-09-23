require 'player'

class Dealer < Player
  attr_reader :bets

  def initialize
    super("dealer", 0)

    @bets = {}
  end

  def play_hand(deck)
  end

  def place_bet(dealer, amt)
  end

  def take_bet(player, amt)
  end

  def pay_bets
  end
end
