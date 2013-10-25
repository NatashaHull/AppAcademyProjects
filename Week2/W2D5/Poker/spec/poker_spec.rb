require 'poker.rb'

describe Poker do
  subject(:game) { Poker.new }

  it { should respond_to(:play) }
end

describe Player do
  subject(:player) { Player.new("test") }

  it { should respond_to(:name) }
  it { should respond_to(:hand) }
  it { should respond_to(:pot) }
  it { should respond_to(:pot=) }
  it { should respond_to(:bet) }
  it { should respond_to(:discard) }
end

describe Deck do
  subject(:deck) { Deck.new }

  it { should respond_to(:cards) }
  it { should respond_to(:draw_card) }

  it "has 52 cards" do
    deck.cards.length.should == 52
  end

  it "only has one of each card" do
    deck.cards.uniq.should == deck.cards
    #Should also test for multiple cards of the same type.
  end

  it "can't draw from an empty deck" do
    52.times { deck.draw_card }

    expect do
      deck.draw_card
    end.to raise_error
  end
end

describe Hand do
  subject(:hand) { Hand.new }
  let(:deck) { Deck.new }

  it { should respond_to(:hand_value) }
  it { should respond_to(:get_hand) }
  it { should respond_to(:discard_card) }

  it "gets 5 cards after getting a hand" do
    hand.get_hand(deck)

    hand.cards.length.should == 5
  end

  it "gets 5 cards after discarding a few and completing the hand" do
    hand.get_hand(deck)
    hand.cards.pop
    hand.cards.pop
    hand.get_hand(deck)

    hand.cards.length.should == 5
  end

  it "discards cards correctly" do
    hand.get_hand(deck)
    card = hand.cards.sample
    hand.discard_card(card)

    hand.cards.should_not include(card)
  end

  describe "Types" do

    context "Straight flush" do

      it "returns the correct value for a low value straight flush" do
        card1 = Card.new(4,:clubs, 2)
        card2 = Card.new(5,:clubs, 3)
        card3 = Card.new(6,:clubs, 4)
        card4 = Card.new(7,:clubs, 5)
        card5 = Card.new(8,:clubs, 6)
        hand.cards = [card1, card2, card3, card4, card5]

        hand.hand_value.should == 166
      end

      it "returns the correct value for a high value straight flush" do
        card1 = Card.new(10,:clubs, 8)
        card2 = Card.new(:jack,:clubs, 9)
        card3 = Card.new(:queen,:clubs, 10)
        card4 = Card.new(:king,:clubs, 11)
        card5 = Card.new(:ace,:clubs, 12)
        hand.cards = [card1, card2, card3, card4, card5]

        hand.hand_value.should == 172
      end

      it "returns the correct value for a normal straight flush" do
        card1 = Card.new(:ace,:clubs, 12)
        card2 = Card.new(2,:clubs, 0)
        card3 = Card.new(3,:clubs, 1)
        card4 = Card.new(4,:clubs, 2)
        card5 = Card.new(5,:clubs, 3)
        hand.cards = [card1, card2, card3, card4, card5]

        hand.hand_value.should == 163
      end
    end

    context "Four of a kind" do
      it "returns 140 plus the card value" do
        card1 = Card.new(4,:clubs, 2)
        card2 = Card.new(4,:hearts, 2)
        card3 = Card.new(4,:spades, 2)
        card4 = Card.new(4,:diamonds, 2)
        card5 = Card.new(8,:clubs, 6)
        hand.cards = [card1, card2, card3, card4, card5]

        hand.hand_value.should == 142
      end
    end

    context "Full house" do
      it "returns the right value when the 3-of-a-kind is bigger" do
        card1 = Card.new(4,:clubs, 2)
        card2 = Card.new(4,:hearts, 2)
        card3 = Card.new(5,:spades, 3)
        card4 = Card.new(5,:diamonds, 3)
        card5 = Card.new(5,:clubs, 3)
        hand.cards = [card1, card2, card3, card4, card5]

        hand.hand_value.should == 123
      end

      it "returns the right value when the 3-of-a-kind is smaller" do
        card1 = Card.new(6,:clubs, 4)
        card2 = Card.new(6,:hearts, 4)
        card3 = Card.new(5,:spades, 3)
        card4 = Card.new(5,:diamonds, 3)
        card5 = Card.new(5,:clubs, 3)
        hand.cards = [card1, card2, card3, card4, card5]

        hand.hand_value.should == 123
      end
    end

    context "Flush" do
      it "returns the highest card value plus 100" do
        card1 = Card.new(:ace,:clubs, 12)
        card2 = Card.new(4,:clubs, 2)
        card3 = Card.new(6,:clubs, 4)
        card4 = Card.new(:king,:clubs, 11)
        card5 = Card.new(8,:clubs, 6)
        hand.cards = [card1, card2, card3, card4, card5]

        hand.hand_value.should == 112
      end
    end

    context "Straight" do
      it "returns the highest card value plus 80" do
        card1 = Card.new(4,:clubs, 2)
        card2 = Card.new(5,:hearts, 3)
        card3 = Card.new(6,:diamonds, 4)
        card4 = Card.new(7,:clubs, 5)
        card5 = Card.new(8,:clubs, 6)
        hand.cards = [card1, card2, card3, card4, card5]

        hand.hand_value.should == 86
      end
    end

    context "Three of a kind" do
      it "returns 60 plus the card value" do
        card1 = Card.new(4,:clubs, 2)
        card2 = Card.new(4,:hearts, 2)
        card3 = Card.new(4,:spades, 2)
        card4 = Card.new(6,:diamonds, 4)
        card5 = Card.new(8,:clubs, 6)
        hand.cards = [card1, card2, card3, card4, card5]

        hand.hand_value.should == 62
      end
    end

    context "Two pair" do
      it "returns 40 plus the card value" do
        card1 = Card.new(4,:clubs, 2)
        card2 = Card.new(4,:hearts, 2)
        card3 = Card.new(5,:spades, 3)
        card4 = Card.new(8,:diamonds, 6)
        card5 = Card.new(8,:clubs, 6)
        hand.cards = [card1, card2, card3, card4, card5]

        hand.hand_value.should == 46
      end
    end

    context "One pair" do
      it "returns 20 plus the card value" do
        card1 = Card.new(4,:clubs, 2)
        card2 = Card.new(4,:hearts, 2)
        card3 = Card.new(5,:spades, 3)
        card4 = Card.new(6,:diamonds, 4)
        card5 = Card.new(8,:clubs, 6)
        hand.cards = [card1, card2, card3, card4, card5]

        hand.hand_value.should == 22
      end
    end

    context "High card" do
      it "returns the card value" do
        card1 = Card.new(:ace,:clubs, 12)
        card2 = Card.new(4,:hearts, 2)
        card3 = Card.new(6,:spades, 4)
        card4 = Card.new(:king,:diamonds, 11)
        card5 = Card.new(8,:clubs, 6)
        hand.cards = [card1, card2, card3, card4, card5]

        hand.hand_value.should == 12
      end
    end
  end
end

describe Card do
  subject(:card) { Card.new(2, :clubs, 0) }

  it { should respond_to(:type) }
  it { should respond_to(:value) }
  it { should respond_to(:suit) }
end