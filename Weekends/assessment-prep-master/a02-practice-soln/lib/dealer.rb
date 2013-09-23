require 'player'

class Dealer < Player
  attr_reader :bets

  def initialize
    super("dealer", 0)

    @bets = {}
  end

  def play_hand(deck)
    until hand.busted? || (hand.points >= 17)
      hand.hit(deck)
    end
  end

  def place_bet(dealer, amt)
    raise "Dealer doesn't bet"
  end

  def take_bet(player, amt)
    @bets[player] = amt
  end

  def pay_bets
    @bets.each do |player, amt|
      player.pay_winnings(2 * amt) if player.hand.beats?(self.hand)
    end

    nil
  end
end
