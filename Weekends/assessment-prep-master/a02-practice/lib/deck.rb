require 'card'

# Represents a deck of playing cards.
class Deck
  # Returns an array of all 52 playing cards.
  def self.all_cards
    cards = []
    Card::SUIT_STRINGS.each do |suit, symbol|
      Card::VALUE_STRINGS.each do |value, symbol|
        cards << Card.new(suit, value)
      end
    end
    cards
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  # Returns the number of cards in the deck.
  def count
    @cards.count
  end

  def peek
    @cards.first
  end

  def include?(card)
    @cards.include?(card)
  end

  def shuffle
    @cards.shuffle!
  end

  # Takes `n` cards from the top of the deck.
  def take(n)
    cards_taken = []
    n.times do
      if @cards.empty?
        raise "not enough cards"
        break
      end
      cards_taken << @cards.shift
    end
    cards_taken
  end

  # Returns an array of cards to the bottom of the deck.
  def return(cards)
    @cards += cards
  end
end
