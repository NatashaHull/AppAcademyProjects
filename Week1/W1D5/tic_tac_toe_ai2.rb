require 'set'

class TreeNode
  attr_accessor :parent, :value, :pos
  attr_reader :children, :best_child

  def initialize(value)
    @children = []
    @value = value
    #@winner = nil #:x, :o, or :d for draw
    @parent = nil
    @pos = nil
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

  def path_to_prior_node(nth_parent)
    return self if self.parent == nth_parent
    self.parent.path_to_prior_node(nth_parent)
  end
end

class Board
  attr_reader :rows

  def self.blank_grid
    (0...3).map { [nil] * 3 }
  end

  def initialize(rows = self.class.blank_grid)
    @rows = rows
  end

  def dup
    duped_rows = rows.map(&:dup)
    self.class.new(duped_rows)
  end

  def same_board(board)
    board.rows == self.rows
  end

  def empty?(pos)
    self[pos].nil?
  end

  def []=(pos, mark) # sgfsgsf[9] = 0
    raise "mark already placed there!" unless empty?(pos)

    x, y = pos[0], pos[1]
    @rows[x][y] = mark
  end

  def [](pos)
    x, y = pos[0], pos[1]
    @rows[x][y]
  end

  def cols
    cols = [[], [], []]
    @rows.each do |row|
      row.each_with_index do |mark, col|
        cols[col] << mark
      end
    end

    cols
  end

  def diagonals
    down_diag = [[0, 0], [1, 1], [2, 2]]
    up_diag = [[0, 2], [1, 1], [2, 0]]

    [down_diag, up_diag].map do |diag|
      # Note the `x, y` inside the block; this unpacks, or
      # "destructures" the argument. Read more here:
      # http://tony.pitluga.com/2011/08/08/destructuring-with-ruby.html
      diag.map { |x, y| @rows[x][y] }
    end
  end

  def over?
    # style guide says to use `or`, but I (and many others) prefer to
    # use `||` all the time. We don't like two ways to do something
    # this simple.
    won? || tied?
  end

  def won?
    !winner.nil?
  end

  def tied?
    return false if won?

    # no empty space?
    @rows.all? { |row| row.none? { |el| el.nil? }}
  end

  def winner
    (rows + cols + diagonals).each do |triple|
      return :x if triple == [:x, :x, :x]
      return :o if triple == [:o, :o, :o]
    end

    nil
  end
end

class TicTacToe
  class IllegalMoveError < RuntimeError
  end

  attr_reader :board, :game_tree

  def initialize(player1, player2)
    @board = Board.new
    @players = { :x => player1, :o => player2 }
    @turn = :x
    @game_tree = TreeNode.new(@board.dup)
    build_game_tree
  end

  def build_game_tree
    frontier = [@game_tree]
    until frontier.empty?
      current_node = frontier.pop
      board = current_node.value
      next if board.won?
      (0..2).each do |x|
        newboard = board
        (0..2).each do |y|
           next unless board.empty?([x,y])
           newboard = board.dup
           newboard[[x,y]] = @turn
           current_node.child = newboard
           current_node.children.last.pos = [x,y]
           break if newboard.won?
         end
         break if newboard.won?
      end

      current_node.children.each do |child|
        break if child.value.won?
        frontier << child
      end
     @turn = ((self.turn == :x) ? :o : :x)
    end
   @turn = :x
  end

  def show
    # not very pretty printing!
    self.board.rows.each { |row| p row }
  end

  def run
    until self.board.over?
      play_turn
    end

    if self.board.won?
      winning_player = self.players[self.board.winner]
      puts "#{winning_player.name} won the game!"
    else
      puts "No one wins!"
    end
  end

  attr_reader :players, :turn

  def play_turn
    while true
      current_player = self.players[self.turn]
      pos = current_player.move(self, self.turn)

      break if place_mark(pos, self.turn)
    end

    # swap next whose turn it will be next
    @turn = ((self.turn == :x) ? :o : :x)
  end

  def place_mark(pos, mark)
    if self.board.empty?(pos)
      self.board[pos] = mark
      true
    else
      false
    end
  end
end

class HumanPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def move(game, mark)
    game.show
    while true
      puts "#{@name}: please select your space"
      x, y = gets.chomp.split(",").map(&:to_i)
      if HumanPlayer.valid_coord?(x, y)
        return [x, y]
      else
        puts "Invalid coordinate!"
      end
    end
  end

  private
  def self.valid_coord?(x, y)
    [x, y].all? { |coord| (0..2).include?(coord) }
  end
end

class ComputerPlayer
  attr_reader :name

  def initialize
    @name = "Tandy 400"
  end

  def move(game, mark)
    winner_move(game, mark) || random_move(game, mark)
  end

  private
  def winner_move(game, mark)
    start_node = game.game_tree.bfs { |other_board| game.board.same_board(other_board) }
    start_node.children.each do |child|
      return child.path_to_prior_node(start_node).pos if child.value.won? #Returns a winning move if you can make one.
      child.children.each do |grandchild|
        return grandchild.pos if grandchild.value.won? #Returns a move that blocks the other player from winning
      end
    end

    nil #Move randomly otherwise
  end

  def random_move(game, mark)
    board = game.board
    while true
      range = (0..2).to_a
      pos = [range.sample, range.sample]

      return pos if board.empty?(pos)
    end
  end
end