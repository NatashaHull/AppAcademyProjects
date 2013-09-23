require 'deck'
require 'hand'

class Game
  def initialize(players, dealer = Dealer.new, deck = nil)
    if deck.nil?
      deck = Deck.new
      deck.shuffle
    end

    @players, @dealer, @deck = players, dealer, deck
  end

  def deal_cards
    (@players + [@dealer]).each { |p| p.hand = Hand.deal_from(@deck) }
  end

  def request_bets
    (@players).each { |p| p.request_bet(@dealer) }
  end

  def play_hands
    (@players + [@dealer]).each { |p| p.play_hand(@deck) }
  end

  def resolve_bets
    puts "Dealer hand: #{@dealer.hand}"
    @dealer.pay_bets
  end

  def return_cards
    (@players + [@dealer]).each { |p| p.return_cards(@deck) }
  end

  def play_round
    deal_cards
    request_bets
    play_hands
    resolve_bets
    return_cards

    nil
  end
end
