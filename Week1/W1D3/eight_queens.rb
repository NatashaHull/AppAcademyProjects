class EightQueens
end

class Queen
  attr_accessor :col
  attr_reader :row
  @@num_queens = 0

  def initialize
    @col = rand(7)
    @row = @@num_queens
    @@num_queens += 1
  end

  def conflicts
    #return number of conflicts for this queen
  end

  def least_conflicts
    #return square where there is the least number of conflicts
    #go through each square without a queen
  end



end

class Board
  DEFAULT_ROW = [false, false, false, false, false, false, false, false]

  def initialize
    @board = [].tap do |column|
      8.times {column << DEFAULT_ROW.dup }
    end
    add_queens
  end

  def add_queens
    @queenA = Queen.new
    set_position(@queenA)
    @queenB = Queen.new
    set_position(@queenB)
    @queenC = Queen.new
    set_position(@queenC)
    @queenD = Queen.new
    set_position(@queenD)
    @queenE = Queen.new
    set_position(@queenE)
    @queenF = Queen.new
    set_position(@queenF)
    @queenG = Queen.new
    set_position(@queenG)
    @queenH = Queen.new
    set_position(@queenH)
  end

  def set_position(queen)
    @board[queen.row] = DEFAULT_ROW.dup
    @board[queen.row][queen.col] = true
    [queen.row,queen.col]
  end


end

#Things to decide/do:
#  The set up a list of the constraints and a way to test them
#  How to implement Local search with min_conflicts