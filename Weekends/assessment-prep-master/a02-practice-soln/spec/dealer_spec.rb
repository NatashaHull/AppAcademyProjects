require 'rspec'
require 'dealer'

describe Dealer do
  subject(:dealer) { Dealer.new }

  it "calls super with a default name/empty bankroll" do
    dealer.name.should == "dealer"
    dealer.bankroll.should == 0
  end

  it { should be_a(Player) }

  it "should not place bets" do
    expect do
      dealer.place_bet(dealer, 100)
    end.to raise_error("Dealer doesn't bet")
  end

  describe "#play_hand" do
    let(:dealer_hand) { double("hand") }
    let(:deck) { double("deck") }
    before do
      dealer.hand = dealer_hand
    end

    it "should not hit on seventeen" do
      dealer_hand.stub(
        :busted? => false,
        :points => 17)
      dealer_hand.should_not_receive(:hit)

      dealer.play_hand(deck)
    end

    it "should hit until seventeen acheived" do
      dealer_hand.stub(:busted? => false)

      # need to use a block to give points, because we'll hit hand and points
      # will change
      points = 12
      dealer_hand.stub(:points) do
        # returns `points` defined in the outside local variable. The
        # `points` variable is said to be *captured*.
        points
      end
      dealer_hand.should_receive(:hit).with(deck).exactly(3).times do
        # changes `points` variable above. Changes will be seen by the block
        # passed to `stub(:points).
        points += 2
      end

      dealer.play_hand(deck)
    end

    it "should stop when busted" do
      dealer_hand.stub(:points => 22)
      dealer_hand.stub(:busted? => true)

      dealer_hand.should_not_receive(:hit)
      dealer.play_hand(deck)
    end
  end

  context "with a player" do
    let(:player) do
      double("player", :hand => player_hand)
    end

    let(:dealer_hand) do
      double("dealer_hand")
    end

    let(:player_hand) do
      double("player_hand")
    end

    before do
      dealer.hand = dealer_hand
      player.stub(:hand => player_hand)
    end

    it "should take bets" do
      dealer.take_bet(player, 100)
      dealer.bets.should == { player => 100 }
    end

    it "should not pay losers (or ties)" do
      dealer.take_bet(player, 100)
      player_hand.should_receive(:beats?).with(dealer_hand).and_return(false)

      # loses
      player.should_not_receive(:pay_winnings)

      dealer.pay_bets
    end

    it "should pay winners" do
      dealer.take_bet(player, 100)
      player_hand.should_receive(:beats?).with(dealer_hand).and_return(true)

      # wins twice the bet
      player.stub(:bankroll => 0)
      player.should_receive(:pay_winnings).with(200)

      dealer.pay_bets
    end
  end
end
