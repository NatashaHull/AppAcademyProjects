require 'set'

class TreeNode
  attr_accessor :parent, :value
  attr_reader :left, :right

  def initialize(value)
    @left = nil
    @right = nil
    @parent = nil
    @value = value
  end

  def left=(child)
    if @left
      @left.parent = nil
    end
    @left = TreeNode.new(child)
    @left.parent = self
  end

  def right=(child)
    if @right
      @right.parent = nil
    end
    @right = TreeNode.new(child)
    @right.parent = self
  end

  def dfs(target)
    return self if @value == target
    return @left.dfs(target) if @left && @left.dfs(target)
    return @right.dfs(target) if @right && @right.dfs(target)
    return false
  end

  def bfs(target)
    frontier = [self]
    closed = Set[self]
    while true
      return false if frontier.empty?
      current_node = frontier.shift
      return current_node if current_node.value == target
      children = [current_node.left, current_node.right]
      children.each do |child|
        next if closed.include?(child)
        if child
          frontier << child
          closed << child
        end
      end
    end
  end
end

#test

root = TreeNode.new(5)
root.left = 9
root.right = 7
root.left.left = 4
root.left.right = 3
root.right.right = 6
root.right.right.right = 10

p root.dfs(10).value
p root.dfs(3).value
p root.dfs(8)

p root.bfs(10).value
p root.bfs(3).value
p root.bfs(8)
