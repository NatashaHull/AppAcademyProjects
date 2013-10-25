require 'set'

class TreeNode
  attr_accessor :parent, :value
  attr_reader :children

  def initialize(value)
    @children = []
    @value = value
    @parent = nil
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

  def path_to_root
    return [@value] unless @parent
    return [@value] + @parent.path_to_root
  end
end

class KnightPathFinder
  def initialize(value)
    @value = value
    @move_tree = TreeNode.new(value)
    create_move_tree
  end

  def create_move_tree
    closed_set = Set[@move_tree.value]
    frontier = [@move_tree]
    until frontier.empty?
      current_node = frontier.shift
      possible_values = []
      [-2,-1,1,2].each do |x|
        [-2,-1,1,2].each do |y|
          possible_values << [current_node.value[0]+x,current_node.value[1]+y] unless (x+y).even?
        end
      end

     possible_values.select! {|location| (0<=location[0]) && (location[0]<8) &&
                                         (0<=location[1]) && (location[1]<8)}
     possible_values.each { |location| current_node.child = location unless closed_set.include?(location) }

     current_node.children.each do |child|
       frontier << child
       closed_set << child.value
     end
    end
  end

  def find_path(location)
    @move_tree.bfs(location).path_to_root.reverse
  end
end

#Testing path_to_parent method
root = TreeNode.new(5)
root.child = 9
root.child = 7
root.children[0].child = 4
root.children[0].child = 3
root.children[1].child = 6
root.children[1].children[0].child = 10

p root.dfs(10).path_to_root

kpf = KnightPathFinder.new([0, 0])

p kpf.find_path([2, 1]) # => [[0, 0], [2, 1]]
p kpf.find_path([3, 3]) # => [[0, 0], [2, 1], [3, 3]]
p kpf.find_path([7, 6])