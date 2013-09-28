require 'arrays.rb'

describe Array do
  subject(:array) { [-3,1,2,3,-2,5,0,3,3,2,9,5] }

  describe "#my_uniq" do

    it "does not contain duplicates" do
      array.my_uniq.should == array.uniq
    end
  end

  describe "#two_sum" do

    it "contains the indeces that sum to zero" do
      array.two_sum.should include([0,3])
      array.two_sum.should include([2,4])
      array.two_sum.should include([4,9])
    end

    it "does not have elements paired with themselves" do
      array.two_sum.should_not include([6,6])
    end

    it "only has indeces that sum to zero" do
      array.two_sum.should == [[0, 3], [0, 7], [0, 8], [2, 4], [4, 9]]
    end
  end
end