class Deck
  attr_reader :cards

  FACE_CARDS = [:jack, :queen, :king, :ace]
  NUM_CARDS = [2,3,4,5,6,7,8,9,10]
  SUITS = [:hearts, :diamonds, :spades, :clubs]

  def initialize
    @cards = []
    init_cards
  end

  def draw_card
    raise "The deck is empty" if @cards.empty?
    @cards.shuffle!
    @cards.pop
  end

  private

    def init_cards
      SUITS.each do |suit|
        (NUM_CARDS+FACE_CARDS).each_with_index do |card, value|
          @cards << Card.new(card, suit, value)
        end
      end
    end
end

class Card
  attr_reader :type, :suit, :value

  def initialize(type, suit, value)
    @type, @suit, @value = type, suit, value
  end

  def display
    "#{@type} of #{@suit}"
  end
end