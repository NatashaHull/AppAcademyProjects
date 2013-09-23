require 'rspec'
require 'deck'

describe Deck do
  subject(:deck) { Deck.new }

  describe "::all_cards" do
    it "returns 52 cards" do
      cards = Deck.all_cards
      cards.count == 52

      # should contain one of each; no duplicates
      cards.uniq.count == 52
    end
  end

  it "should not expose its cards" do
    deck.should_not respond_to(:cards)
  end

  it "contains all 52 cards by default" do
    deck.count.should == 52
  end

  it "lets us peek at the top card without taking it" do
    deck.peek.should be_a(Card)
    deck.count.should == 52
  end

  it "lets us test if a card is present in the deck" do
    deck.include?(deck.peek).should be_true
  end

  it "can be initialized with an array of cards" do
    cards = [
      Card.new(:spades, :ace),
      Card.new(:spades, :king),
      Card.new(:spades, :queen)
    ]

    # **Should take the top two cards off the stack**
    Deck.new(cards.dup).take(2).should == cards[0...2]
  end

  it "shuffles the cards" do
    expect do
      deck.shuffle
    end.to change{deck.peek}
  end

  describe "#take" do
    it "lets user take cards" do
      taken_cards = deck.take(5)

      taken_cards.count.should == 5
      taken_cards.each { |card| card.is_a?(Card) }
    end

    it "removes those cards from deck" do
      taken_cards = deck.take(5)

      deck.count.should == 47
      taken_cards.each do |card|
        deck.include?(card).should be_false
      end
    end

    it "doesn't let the user take too many cards" do
      expect do
        deck.take(100)
      end.to raise_error("not enough cards")
    end
  end

  describe "#return" do
    let(:taken_cards) { deck.take(5) }

    it "returns cards to deck" do
      deck.return(taken_cards)

      deck.count.should == 52
      taken_cards.each do |card|
        deck.should include(card)
      end
    end

    it "returns cards to bottom of deck" do
      original_cards = taken_cards.dup

      deck.return(taken_cards)
      deck.take(47)
      deck.take(5).should =~ original_cards
    end
  end
end
