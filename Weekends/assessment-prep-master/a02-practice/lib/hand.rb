class Hand
  # This is called a *factory method*; it's a *class method* that
  # takes the a `Deck` and creates and returning a `Hand`
  # object. This is in contrast to the `#initialize` method that
  # expects an `Array` of cards to hold.
  def self.deal_from(deck)
    cards = deck.take(2)
    Hand.new(cards)
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def points
    aces = []
    points = 0
    @cards.each do |card|
      if is_ace?(card)
        aces << card
        next
      end
      points += card.blackjack_value
    end
    return add_aces(points, aces) unless aces.empty?
    points
  end

  def add_aces(points, aces)
    num_aces = aces.length
    high_value = 11 * num_aces
    low_value = num_aces
    return points + high_value if points + high_value < 22
    points + low_value
  end

  def is_ace?(card)
    card.value == :ace
  end

  def busted?
    points > 21
  end

  def hit(deck)
    raise "already busted" if busted?
    @cards += deck.take(1)
  end

  def beats?(other_hand)
    if !busted? && (points > other_hand.points || other_hand.busted?)
      true
    else
      false
    end
  end

  def return_cards(deck)
    deck.return(@cards)
    @cards = []
  end

  def to_s
    @cards.join(",") + " (#{points})"
  end
end
