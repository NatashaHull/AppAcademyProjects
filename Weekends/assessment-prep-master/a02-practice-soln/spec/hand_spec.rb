require 'rspec'
require 'card'
require 'deck'
require 'hand'

describe Hand do
  describe "::deal_from" do
    it "deals a hand of two cards" do
      cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :three)
      ]

      deck = Deck.new(cards.dup)
      hand = Hand.deal_from(deck)

      deck.count.should == 0
      hand.cards.should =~ cards
    end
  end

  context "with low hand" do
    subject(:low_hand) do
      Hand.new([
          Card.new(:spades, :deuce),
          Card.new(:spades, :four)
        ])
    end

    its(:points) { should == 6 }

    describe "#busted?" do
      it "is not busted?" do
        low_hand.busted?.should be_false
      end
    end

    describe "#hit" do
      let(:deck) { Deck.new([Card.new(:spades, :seven)]) }

      before do
        low_hand.hit(deck)
      end

      it "takes a card" do
        low_hand.cards.count.should == 3
      end

      it "increases score" do
        low_hand.points.should == 13
      end
    end

    describe "#return_cards" do
      let(:deck) { double("deck") }

      it "returns cards to deck" do
        deck.should_receive(:return) do |cards|
          cards.count.should == 2
        end

        low_hand.return_cards(deck)

        low_hand.cards.count.should == 0
      end
    end
  end

  context "with high hand" do
    subject(:high_hand) do
      Hand.new([
          Card.new(:spades, :ten),
          Card.new(:spades, :ace)
        ])
    end

    let(:deck) do
      Deck.new([
          Card.new(:spades, :deuce),
          Card.new(:spades, :ten),
          Card.new(:spades, :four)
        ])
    end

    it "uses ace as 11 by default" do
      high_hand.points.should == 21
    end

    it "uses ace as 1 if needed" do
      high_hand.hit(deck)
      high_hand.points.should == 13
    end

    it "handles multiple aces" do
      Hand.new([
          Card.new(:spades, :ten),
          Card.new(:hearts, :ace),
          Card.new(:clubs, :ace)
        ]).points.should == 12
    end

    context "busted" do
      before do
        high_hand.hit(deck)
        high_hand.hit(deck)
      end

      it "is busted" do
        high_hand.busted?.should be_true
      end

      it "won't allow further hits" do
        expect do
          high_hand.hit(deck)
        end.to raise_error("already busted")
      end
    end
  end

  context "with two hands" do
    let(:hand1) do
      Hand.new([
          Card.new(:spades, :ten),
          Card.new(:spades, :four)
        ])
    end

    let(:hand2) do
      Hand.new([
          Card.new(:spades, :ten),
          Card.new(:spades, :jack)
        ])
    end

    let(:busted_hand1) do
      Hand.new([
          Card.new(:spades, :ten),
          Card.new(:spades, :jack),
          Card.new(:spades, :queen)
        ])
    end

    let(:busted_hand2) do
      Hand.new([
          Card.new(:spades, :ten),
          Card.new(:spades, :jack),
          Card.new(:spades, :four)
        ])
    end

    describe "#beats?" do
      it "awards win to higher hand" do
        hand2.beats?(hand1).should be_true
      end

      it "can compare tied hands" do
        hand1.beats?(hand1).should be_false
      end

      it "awards win if we didn't bust, but they did" do
        hand1.beats?(busted_hand1).should be_true
      end

      it "never lets busted hand win" do
        busted_hand1.beats?(busted_hand2).should be_false
        busted_hand2.beats?(busted_hand1).should be_false
      end
    end
  end
end
