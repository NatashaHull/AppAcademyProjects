require 'yaml'
class Minesweeper
  attr_accessor :lost, :board
  @@best_times = []

  def initialize
    @lost = false
    @player = Player.new
  end

  def play
    start_new_game

    until over?
      start_time = Time.now
      @board.show
      move = interpret(@player.move)
      return nil if lose?
      move = validate_move(move)
      update_board(move)
    end
    @board.show
    game_result
    completion_time = (Time.now - start_time).to_i
    @@best_times << completion_time if (@@best_times.length < 10) || (completion_time < @@best_times.sort.last) #Needs to be edited to pop the last completion time if it's worse than the current time
    puts "It took you #{completion_time} seconds to finish."
    puts "The best times are:"
    puts @@best_times
  end

  def start_new_game
    puts "Would you like to load a saved game? (y/n)"
    puts "If you say 'n', a new game will start."
    load = gets.chomp.downcase
    case load
    when 'y'
      saved_game = File.readlines('saved_minesweeper.txt').join('')
      @board = YAML::load(saved_game)
    when 'n'
      create_board
      @board.generate_tiles
      @board.place_mines
    else
      puts "Invalid input."
      start_new_game
    end
  end

  def create_board
    puts "Would you like to play an easy or hard game?"
    difficulty = gets.chomp.downcase
    case difficulty
    when "easy"
      @board = Board.new(9, 10)
    when "hard"
      @board = Board.new(16, 40)
    else
      puts "Invalid input."
      create_board
    end
  end

  def over?
    win? || lose?
  end

  def win?
    won = true
    @board.size.times do |row|
      @board.size.times do |col|
        won = false unless @board.display[row][col].value == "M" || @board.display[row][col].explored
      end
    end
    won
  end

  def lose?
    @lost
  end

  def update_board(move)
    type, row, col = move
    case type
    when'f'
      @board.display[row][col].flagged = true
    when 'r'
      @board.display[row][col].explore(self, @board.display)
    when 'uf'
      @board.display[row][col].flagged = false
    end
  end

  def valid_move?(move)
    type, row, col = move
    return false unless type && row && col
    return false unless type == "r" || type == "f" || type == "uf"
    return false unless (0...@board.size).include?(row) && (0...@board.size).include?(col)
    return false if @board.display[row][col].explored
    return false if (@board.display[row][col].flagged && type != "uf")
    return true
  end

  def validate_move(move)
    until valid_move?(move)
      puts "Invalid move. Please reselect move."
      move = interpret(@player.move)
    end
    move
  end

  def interpret(move)
    if move[0] == 'quit'
      puts "Would you like to save the game? (y/n)"
      if gets.chomp.downcase == "y"
        File.open("saved_minesweeper.txt", "w") do |file|
          file.puts @board.to_yaml
        end
        puts "Your game has been saved."
      end
      @lost = true
    else
      move[0] = move[0].downcase if move[0]
      move[1] = move[1].to_i-1 if move[1]
      move[2] = move[2].to_i-1 if move[2]
    end
    move
  end

  def game_result
    puts "You won!" if win?
    puts "You stepped on a mine and lost!" if lose?
  end
end

class Board
  attr_accessor :display, :size, :mines

  def initialize(size, mines)
    @size = size
    @mines = mines
    @display = []
  end

  def generate_tiles
    @size.times do |row|
      row_tiles = []
      @size.times do |col|
        row_tiles << Tile.new([row, col])
      end
      @display << row_tiles
    end
  end

  def place_mines
    @mines.times do
      x, y = rand(0..@size-1), rand(0..@size-1)
      while @display[x][y].value == "M"
        x, y = rand(0..@size-1), rand(0..@size-1)
      end
      @display[x][y].place_mine
    end
  end

  def header
    if @size == 9
      "  | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |"
    else
      "  | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10| 11| 12| 13| 14| 15| 16|"
    end
  end

  def footer
    if @size == 9
      "---------------------------------------"
    else
      "-------------------------------------------------------------------"
    end
  end

  def show
    flagged_spaces = 0
    puts header
    puts footer
    row_i = 1 #Since our players might not be programmers
    @display.each do |row|
      show_row = row_i < 10 ? "#{row_i} | " : "#{row_i}| "
      row.each do |tile|
        if tile.explored
          value = tile.value == 0 ? "-" : tile.value
          show_row << "#{value} | "
        elsif tile.flagged
          show_row << "F | "
          flagged_spaces += 1
        else
          show_row << "* | "
        end
      end
      puts show_row
      puts footer
      row_i += 1
    end
    puts "#{flagged_spaces}/#{@mines} mines"
  end
end

class Tile
  attr_accessor :pos, :value, :neighbors, :explored, :flagged

  def initialize(pos)
    @pos = pos
    @value = nil
    @neighbors = []
    @explored = false
    @flagged = false
  end

  def place_mine
    @value = "M"
  end

  def explore(game, board)
    @explored = true
    return game.lost = true if @value == "M"
    get_neighbors(board)
    @value = calculate_nearby_mines
    if @value == 0
      @neighbors.each { |neighbor| neighbor.explore(game, board) unless neighbor.explored }
    end
  end

  def calculate_nearby_mines
    nearby_mines = 0
    @neighbors.each do |neighbor|
      nearby_mines += 1 if neighbor.value == "M"
    end
    nearby_mines
  end

  def get_neighbors(board)
    neighbor_pairs = [[@pos[0]-1, @pos[1]-1], [@pos[0]-1, @pos[1]], [@pos[0]-1, @pos[1]+1],
                      [@pos[0], @pos[1]-1], [@pos[0], @pos[1]+1], [@pos[0]+1, @pos[1]-1],
                      [@pos[0]+1, @pos[1]], [@pos[0]+1, @pos[1]+1]
                    ]
    neighbor_pairs.select! { |x,y| (0...board.size).include?(x) && (0...board.size).include?(y) }
    neighbor_pairs.each do |pair|
      tile = board[pair[0]][pair[1]]
      @neighbors << tile unless @neighbors.include?(tile)
    end
  end
end

class Player
  def move
    puts "Please select an action and a square."
    puts "Type 'r' to reveal a square, 'f' to flag a square for a mine of 'uf' to unflag a square."
    puts "Ex: Type 'r 4 5' to reveal the fourth row down and the fifth column over."
    puts "If you would like to quit, type 'quit'."
    gets.strip.split(/,\s+|\s+|,/)
  end
end

game = Minesweeper.new
game.play