require 'rspec'
require 'deck'
require 'hand'
require 'player'

describe Player do
  subject(:player) do
    Player.new("Nick the Greek", 200_000)
  end

  let(:deck) do
    Deck.new([
        Card.new(:spades, :deuce),
        Card.new(:spades, :three)
      ])
  end

  before do
    player.hand = Hand.deal_from(deck)
  end

  its(:name) { should == "Nick the Greek" }
  its(:bankroll) { should == 200_000 }
  its("hand.cards.count") { should == 2 }

  describe "#place_bet" do
    let(:dealer) { double("dealer", :take_bet => nil) }

    it "registers bet with dealer" do
      dealer.should_receive(:take_bet).with(player, 10_000)

      player.place_bet(dealer, 10_000)
    end

    it "deducts bet from bankroll" do
      player.place_bet(dealer, 10_000)

      player.bankroll.should == 190_000
    end

    it "enforces limits" do
      expect do
        player.place_bet(dealer, 1_000_000)
      end.to raise_error("player can't cover bet")
    end
  end

  describe "#pay_winnings" do
    it "adds to winnings" do
      expect do
        player.pay_winnings(200)
      end.to change{player.bankroll}.by(200)
    end
  end

  describe "#return_cards" do
    it "returns player's cards to the deck" do
      deck = double("deck")
      player.hand.should_receive(:return_cards).with(deck)

      player.return_cards(deck)
    end

    it "resets hand to nil" do
      player.return_cards(deck)
      player.hand.should be_nil
    end
  end
end
