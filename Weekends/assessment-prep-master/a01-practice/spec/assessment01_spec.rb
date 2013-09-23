require 'rspec'
require 'assessment01'

describe "#primes" do
  # `primes(num)` returns an array of the first `num` primes

  it "returns first five primes in order" do
    primes(5).should == [2, 3, 5, 7, 11]
  end

  it "returns an empty array when asked for zero primes" do
    primes(0).should == []
  end
end

describe "#factorials_rec" do
  # write a **recursive** implementation of a method that returns the
  # first `n` factorial numbers.

  it "returns first factorial number" do
    factorials_rec(1) == [1] # = [1!]
  end

  it "returns first two factorial numbers" do
    factorials_rec(2).should == [1, 2] # = [1!, 2!]
  end

  it "returns many factorials numbers" do
    factorials_rec(5).should == [1, 2, 6, 24, 120]
    # == [1!, 2!, 3!, 4!, 5!]
  end

  it "calls itself recursively" do
    # this should enforce you calling your method recursively.

    should_receive(:factorials_rec).at_least(:twice).and_call_original
    factorials_rec(6)
  end
end

describe "#dups" do
  # Write a new Array method (using monkey-patching) that will return
  # the location of all identical elements. The keys are the
  # duplicated elements, and the values are arrays of their positions,
  # sorted lowest to highest.

  it "solves a simple example" do
    [1, 3, 0, 1].dups.should == { 1 => [0, 3] }
  end

  it "finds two dups" do
    [1, 3, 0, 3, 1].dups.should == { 1 => [0, 4], 3 => [1, 3] }
  end

  it "finds multi-dups" do
    [1, 3, 4, 3, 0, 3].dups.should == { 3 => [1, 3, 5] }
  end

  it "returns {} when no dups found" do
    [1, 3, 4, 5].dups.should == {}
  end
end

describe "#symmetric_substrings" do
  # Write a `String#symmetric_substrings` method that takes a returns
  # substrings which are equal to their reverse image ("abba" ==
  # "abba"). We should only include substrings of length > 1.

  it "handles a simple example" do
    "aba".symmetric_substrings.should =~ ["aba"]
  end

  it "handles two substrings" do
    "aba1cdc".symmetric_substrings.should =~ ["aba", "cdc"]
  end

  it "handles nested substrings" do
    "xabax".symmetric_substrings.should =~ ["aba", "xabax"]
  end
end

describe "#bubble_sort" do
  # write a new `Array#bubble_sort` method; it should not modify the
  # array it is called on, but creates a new sorted array.

  it "works with an empty array" do
    [].bubble_sort.should == []
  end

  it "works with an array of one item" do
    [1].bubble_sort.should == [1]
  end

  it "sorts numbers" do
    [5, 4, 3, 2, 1].bubble_sort.should == [1, 2, 3, 4, 5]
  end

  it "will use block if given" do
    [1, 2, 3, 4, 5].bubble_sort do |num1, num2|
      # reverse order
      num2 <=> num1
    end.should == [5, 4, 3, 2, 1]
  end

  it "does not modify original" do
    original = [5, 4, 3, 2, 1]
    duped_original = original.dup
    duped_original.bubble_sort
    duped_original.should == original
  end
end
