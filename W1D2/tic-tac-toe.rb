class TicTacToe
  attr_reader :board, :current_player, :player_one, :player_two
  def initialize
  end

  def play
    setup_game
    until @board.win? || @board.tie?
      @board.show
      row, col = @current_player.select_square
      until @board.empty_square?(row, col)
        row, col = @current_player.select_square
      end
      make_move(row, col)
      switch_player
      puts ""
    end
    @board.show
    if @board.win?
      puts winner
    else
      puts "It was a tie."
    end
  end

  def setup_game
    @board = Board.new
    pick_players
    @current_player = @player_one
  end

  def pick_players
    puts "Player 1: Human or AI?"
    player_type = gets.chomp
    @player_one = Player.type(player_type.downcase)
    puts "Player 2: Human or AI?"
    player_type = gets.chomp
    @player_two = Player.type(player_type.downcase)
  end

  def switch_player
    if @current_player == @player_one
      @current_player = @player_two
    else
      @current_player = @player_one
    end
  end

  def make_move(row, col)
    if @current_player == @player_one
      @board.player_one_move(row, col)
    else
      @board.player_two_move(row, col)
    end
  end

  def winner
    if @current_player == @player_one
      "Player 2 won!"
    else
      "Player 1 won!"
    end
  end
end

class Board
  def initialize
    @board = [["_","_","_"],
              ["_","_","_"],
              ["_","_","_"]]
  end

  def show
    @board.each do |row|
      p row
    end
  end

  def empty_square?(row, col)
    @board[row][col] == "_"
  end

  def player_one_move(row, col)
    @board[row][col] = 'X' if empty_square?(row, col)
  end

  def player_two_move(row, col)
    @board[row][col] = 'O' if empty_square?(row, col)
  end

  #Check win after each move and use current_player to determine winner
  def win?
    win = false
    @board.each do |row|
      win = true if (row[0] == row[1] && row[0] == row[2] && row[0] != "_")
    end

    (0..2).each do |col_i|
      win = true if (@board[0][col_i] == @board[1][col_i] && @board[0][col_i] == @board[2][col_i] && @board[2][col_i] != "_")
    end

    win = true if (@board[0][0] == @board[1][1] && @board[2][2] == @board[0][0] && @board[0][0] != "_")
    win = true if (@board[0][2] == @board[1][1] && @board[0][2] == @board[2][0] && @board[2][0] != "_")
    win
  end

  def tie?
    tie = true unless @board.flatten.include?("_")
  end
end

class Player
  def self.type(player)
    if player == "human"
      HumanPlayer.new
    elsif player == "ai"
      ComputerPlayer.new
    end
  end
end

class HumanPlayer < Player
  def select_square
    puts "Pick a square: row, column (example: 1, 1) from 1-3"
    square = gets.chomp.split(", ").map(&:to_i).map { |num| num - 1}
    square
  end
end

class ComputerPlayer < Player
  def select_square
    square = [rand(2), rand(2)]
  end
end