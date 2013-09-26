class Board
  attr_accessor :rows

  def initialize
    @rows = Array.new(8) do
      Array.new(8) { nil }
    end
    initial_setup
  end

  def piece_at_position(coord_pair)
    @rows[coord_pair[0]][coord_pair[1]]
  end

  def [](coord_pair)
    @rows[coord_pair[0]][coord_pair[1]]
  end

  def []=(coord_pair, piece)
    @rows[coord_pair[0]][coord_pair[1]] = piece
  end

  def move(player_move)

    # Takes [origin_coord, destination_coord]
    origin_coord, destination_coord = player_move
    piece = self[origin_coord]
    self[destination_coord] = piece
    self[origin_coord] = nil
    piece.pos = destination_coord
    piece.first_move = false

    #Handle using en passant
    if piece.is_a?(Pawn)
      potential_pawn = self[[origin_coord[0], destination_coord[1]]]
      if potential_pawn.is_a?(Pawn) && potential_pawn.en_passant_susceptible
        self[[origin_coord[0], destination_coord[1]]] = nil
      end
    end

    #Resets en passant susceptibility
    reset_en_passant_values

    if piece.is_a?(Pawn)
      #Handles pawn promotion
      if destination_coord[0] == 0 || destination_coord[0] == 7
        self[destination_coord] = Queen.new(piece.color, destination_coord, false)
      end

      #Changes pawn to be en_passant_susceptible
      piece.en_passant_susceptible = true if row_distance(player_move) == 2
    end

    #Handles castling
    if piece.is_a?(King) && col_distance(player_move) == 2
      piece.castle(self, destination_coord)
    end
  end

  def valid_move?(player_move, piece)
    # Legal move for that piece?
    return false unless piece.moves(self).include?(player_move[1])

    # Does it put me in check?
    dupped_board = self.dup
    dupped_board.move(player_move)

    return false if dupped_board.check?(piece.color)

    true
  end

  def over?(color)
    return true if checkmate?(color)
    return true if stalemate?(color)
    #Checks to see if there are only two pieces(kings) left.
    return true if @rows.flatten.compact.count == 2
    false
  end

  def check?(color)
    check = false

    all_pieces = @rows.flatten.compact
    king = all_pieces.select { |piece| piece.is_a?(King) && piece.color == color }
    king = king[0]

    enemy_pieces = all_pieces.reject { |piece| piece.color == color }

    enemy_pieces.each do |piece|
      enemy_moves = piece.moves(self)
      check = true if enemy_moves && enemy_moves.include?(king.pos)
    end

    check
  end

  def checkmate?(color)
    return false unless check?(color)
    return no_legal_moves?(color)
  end

  def stalemate?(color)
    return false if check?(color)
    return no_legal_moves?(color)
  end

  def player_pieces(color)
    all_pieces = @rows.flatten.compact
    all_pieces.select { |piece| piece.color == color }
  end

  def display
    system("clear")
    square_colors = [:white, :light_white]*50
    puts "-"+("1".."8").to_a.map {|i| i.center(3)}.join("")
    #puts '-'*34
    row_letter = ("a".."z").to_a
    @rows.each_with_index do |row, index|
      show_row = [row_letter[index]]
      show_row += row.map do |square|
        if square.nil?
          "   ".colorize( :background => square_colors.pop)
        else
          square.mark.colorize( :background => square_colors.pop)
        end
      end
      square_colors.pop
      puts show_row.join('')
     # puts '-'*34
    end
  end

  def dup
    new_board = Board.new
    new_board.rows = dupped_rows
    new_board
  end

  private

    def initial_setup
      home_row(0, :red)
      home_row(7, :black)
      pawn_row(1, :red)
      pawn_row(6, :black)
    end

    def home_row(row_number, color)
      @rows[row_number] = [
                        Rook.new(color, [row_number, 0]),
                        Knight.new(color, [row_number, 1]),
                        Bishop.new(color, [row_number, 2]),
                        Queen.new(color, [row_number, 3]),
                        King.new(color, [row_number, 4]),
                        Bishop.new(color, [row_number, 5]),
                        Knight.new(color, [row_number, 6]),
                        Rook.new(color, [row_number, 7])
                      ]
    end

    def pawn_row(row_number, color)
      #This sets the pawn rows so that they automatically know
      #that their next move is their first move.
      @rows[row_number] = [
                        Pawn.new(color, [row_number, 0]),
                        Pawn.new(color, [row_number, 1]),
                        Pawn.new(color, [row_number, 2]),
                        Pawn.new(color, [row_number, 3]),
                        Pawn.new(color, [row_number, 4]),
                        Pawn.new(color, [row_number, 5]),
                        Pawn.new(color, [row_number, 6]),
                        Pawn.new(color, [row_number, 7])
                      ]
    end

    def dupped_rows
      dupped_rows = []
      @rows.each do |row|
        dupped_row = []
        row.each do |piece|
          piece.nil? ? dupped_row << piece : dupped_row << piece.dup
        end
        dupped_rows << dupped_row
      end
      dupped_rows
    end

    def row_distance(player_move)
      origin_coord, destination_coord = player_move
      (origin_coord[0] - destination_coord[0]).abs
    end

    def col_distance(player_move)
      origin_coord, destination_coord = player_move
      (origin_coord[1] - destination_coord[1]).abs
    end

    def no_legal_moves?(color)
      our_pieces = player_pieces(color)

      our_pieces.each do |piece|
        piece.moves(self).each do |move|
          return false if valid_move?([piece.pos, move], piece)
        end
      end

      true
    end

    def reset_en_passant_values
      all_pieces = @rows.flatten.compact
      pawns = all_pieces.select { |piece| piece.is_a?(Pawn) }

      pawns.each do |pawn|
        pawn.en_passant_susceptible = false
      end
    end
end