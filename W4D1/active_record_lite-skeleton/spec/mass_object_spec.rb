require 'active_record_lite'

# Use these if you like.
describe MassObject do
  subject(:obj) { MyMassObject.new(:x => :x_val, :y => :y_val) }

  before(:all) do
    class MyMassObject < MassObject
      my_attr_accessible(:x, :y)
    end
  end

  it "#my_attr_accessible should add #x and #y" do
    obj.methods.should include(:x)
    obj.methods.should include(:y)
  end

  it "#initialize should take a hash and properly assign values" do
    obj.x.should == :x_val
    obj.y.should == :y_val
  end
end