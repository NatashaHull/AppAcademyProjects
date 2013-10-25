require 'transpose.rb'

describe Array do
  describe 'my_transpose' do
    let(:rows) { [[0, 1, 2],[3, 4, 5],[6, 7, 8]] }
    let(:cols) { [[0, 3, 6],[1, 4, 7],[2, 5, 8]] }

    it "should transpose the rows to the columns" do
      my_transpose(rows).should == cols
      my_transpose(cols).should == rows
    end
  end
end