require 'hanoi.rb'

describe Hanoi do
  subject(:game) { Hanoi.new }

  its(:towers) { should == [[1,2,3], [], []] }
  it { should_not be_won }

  it "moves blocks between stacks" do
    game.move(0,1)

    game.towers.should == [[2,3], [1], []]
  end

  it "does not move from an empty stack" do
    expect do
      game.move(1,0)
    end.to raise_error
  end

  it "does not move bigger blocks on top of smaller blocks" do
    game.move(0,1)

    expect do
      game.move(0,1)
    end.to raise_error
  end

  it "is over when all the blocks are on the last stack" do
    game.move(0,2)
    game.move(0,1)
    game.move(2,1)
    game.move(0,2)
    game.move(1,0)
    game.move(1,2)
    game.move(0,2)

    game.should be_won
  end
end