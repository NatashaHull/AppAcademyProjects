class Hand
  # This is called a *factory method*; it's a *class method* that
  # takes the a `Deck` and creates and returning a `Hand`
  # object. This is in contrast to the `#initialize` method that
  # expects an `Array` of cards to hold.
  def self.deal_from(deck)
  end

  attr_accessor :cards

  def initialize(cards)
  end

  def points
  end

  def busted?
  end

  def hit(deck)
  end

  def beats?(other_hand)
  end

  def return_cards(deck)
  end

  def to_s
    @cards.join(",") + " (#{points})"
  end
end
