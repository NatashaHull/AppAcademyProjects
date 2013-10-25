class MyClass
  def initialize
    @name = nil
    @age = nil
  end
  def setattr(name,age = 50)
    @name = name
    @age = age
  end
end

person1 = MyClass.new
#person1.setattr = "bob"
person1.setattr("bob",40)