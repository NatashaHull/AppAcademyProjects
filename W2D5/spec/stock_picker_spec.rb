require 'stock_picker.rb'

describe Array do
  describe 'stock_picker' do
    subject(:stocks) { [0,-1,10,55,30] }

    it "returns the best days to buy and sell stock" do
      stock_picker(stocks).should == [1, 3]
    end
  end
end