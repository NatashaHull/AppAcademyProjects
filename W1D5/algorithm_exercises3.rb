require 'set'

class TreeNode
  attr_accessor :parent, :value
  attr_reader :children

  def initialize(value)
    @children = []
    @value = value
  end

  def child=(child)
    child = TreeNode.new(child)
    child.parent = self
    @children << child
  end

  def dfs(target = nil,&prc)
    if target
      prc = Proc.new { |x| x == target }
    end

    return self if prc.call(@value)
    @children.each do |child|
      branch = child.dfs(&prc)
      return branch if branch
    end
    return false
  end

  def bfs(target = nil, &prc)
    if target
      prc = Proc.new { |x| x == target }
    end

    frontier = [self]
    #For Graph Search
    closed = Set[self]
    while true
      return false if frontier.empty?
      current_node = frontier.shift
      return current_node if prc.call(current_node.value)
      current_node.children.each do |child|
        next if closed.include?(child)
        frontier << child
        closed << child
      end
    end
  end
end

#test


root = TreeNode.new(5)
root.child = 9
root.child = 7
root.children[0].child = 4
root.children[0].child = 3
root.children[1].child = 6
root.children[1].children[0].child = 10

p root.dfs(10).value
p root.dfs(6).value
p root.dfs(8)

#Block Tests
p root.dfs {|x| x < 5}.value
p root.dfs {|x| x > 40}

p root.bfs(10).value
p root.bfs(3).value
p root.bfs(8)

#Block Tests
p root.dfs {|x| x < 5}.value
p root.dfs {|x| x > 40}