# coding: utf-8
require 'colorize'

class Piece
  attr_reader :color
  attr_accessor :pos, :first_move

  def initialize(color, pos, first_move=true)
    #The first_move paramater is needed, so that when
    #the board is dupped, the pawns know it isn't their first move
    @color = color
    @pos = pos
    @first_move = first_move
  end

  def new_position(old_pos, vector)
    [old_pos[0] + vector[0], old_pos[1] + vector[1]]
  end

  def remove_self_killing_moves(moves, board)
    moves.select! do |move|
      board.piece_at_position(move).nil? || board.piece_at_position(move).color != @color
    end
    moves
  end

  def move_on_board?(move)
    (0...8).include?(move[0]) && (0...8).include?(move[1])
  end

  def dup
    if self.is_a?(Pawn)
      self.class.new(@color, @pos, @first_move, @en_passant_susceptible)
    else
      self.class.new(@color, @pos, @first_move)
    end
  end
end



module SlidingPieces
  def moves(board)
    # returns array of valid move positions

    # Keep going until you reach another piece, or edge of board
    moves = []

    move_dirs.each do |vector|
      (1..7).each do |scalar|
        new_vector = vector.map { |el| scalar * el }
        move = new_position(@pos, new_vector)
        next unless move_on_board?(move)
        moves << move
        break unless board.piece_at_position(move).nil?
      end
    end

    # Don't step on your own pieces
    remove_self_killing_moves(moves, board)
  end

end

module SteppingPieces
  def moves(board)
    # returns array of valid move positions

    moves = move_dirs.map { |vec| new_position(@pos, vec)}

    # On the board?
    moves.select! { |move| move_on_board?(move) }

    #Allow castling for kings
    if self.is_a?(King)
      castling_moves = castle_move(board)
      moves += castling_moves unless castling_moves.empty?
    end

    # Don't step on your own pieces
    remove_self_killing_moves(moves, board)
  end

end

class Queen < Piece
  include SlidingPieces

  def move_dirs
   [[0, -1], [0, 1], [1, 0], [-1, 0], [-1, -1], [-1, 1], [1, -1], [1, 1]]
  end

  def mark
    return " ♛ ".colorize(@color)
  end
end


class King < Piece
  include SteppingPieces

  def move_dirs
   [[0, -1], [0, 1], [1, 0], [-1, 0], [-1, -1], [-1, 1], [1, -1], [1, 1]]
  end

  def mark
    return " ♚ ".colorize(@color)
  end

  def castle_move(board)
    #Check to see if the king has moved
    return [] unless @first_move

    #Check to see which rooks, if any, have not moved
    potential_rooks = [board[[@pos[0], 0]], board[[@pos[0], 7]]]
    potential_rooks.select! do |rook|
      rook.is_a?(Rook) && rook.first_move
    end
    return [] if potential_rooks.empty?

    #Check to see if there's something between contender rooks and the king
    potential_rooks.map! do |rook|
      if rook.pos[1] == 0
        left_castle(board) ? [@pos[0], 2] : nil
      else
        right_castle(board) ? [@pos[0], 6] : nil
      end
    end

    potential_moves = potential_rooks.compact || potential_rooks
  end

  #Potentially move this to the board class
  def castle(board, destination_coord)
    #For executing the castle
    if destination_coord[1] == 2
      rook_move = [[@pos[0], 0], [@pos[0], 3]]
    else #King is moving to column 6(AKA user coordinate 7)
      rook_move = [[@pos[0], 7], [@pos[0], 5]]
    end
    board.move(rook_move)
  end

  private

    def left_castle(board)
      return false unless board[[@pos[0], 1]].nil?
      return false unless board[[@pos[0], 2]].nil?
      return false unless board[[@pos[0], 3]].nil?
      true
    end

    def right_castle(board)
      return false unless board[[@pos[0], 5]].nil?
      return false unless board[[@pos[0], 6]].nil?
      true
    end
end



class Bishop < Piece
  include SlidingPieces

  def move_dirs
    [[-1, -1], [-1, 1], [1, -1], [1, 1]]
  end

  def mark
    return " ♝ ".colorize(@color)
  end
end


class Knight < Piece
  include SteppingPieces

  def move_dirs
    [[1, 2], [2, 1], [-1, 2], [2, -1], [-1, -2], [-2, -1], [1, -2], [-2, 1]]
  end

  def mark
    return " ♞ ".colorize(@color)
  end
end


class Rook < Piece
  include SlidingPieces

  def move_dirs
    [[0, -1], [0, 1], [1, 0], [-1, 0]]
  end

  def mark
    return " ♜ ".colorize(@color)
  end
end


class Pawn < Piece
  attr_accessor :en_passant_susceptible

  def initialize(color, pos, first_move=true, en_passant_susceptible=false)
    super(color, pos, first_move)
    @en_passant_susceptible = en_passant_susceptible
  end

  def mark
    return " ♟ ".colorize(@color)
  end

  def moves(board)
    # returns array of valid move positions

    movement_vector = [-1,0] if @color == :black
    movement_vector = [1,0] if @color == :red
    diagonal_vectors = [[movement_vector[0], -1], [movement_vector[0], 1]]

    moves = []
    if @first_move
      # Can optionally step forward 2 squares if nothing directly in front of it
      piece_one_move_in_front = board.piece_at_position(new_position(@pos, movement_vector))
      moves << new_position(@pos, movement_vector.map { |el| el * 2} ) if piece_one_move_in_front.nil?
    end

    #Allows en passant moves
    en_passant_victims = [[@pos[0], @pos[1]-1], [@pos[0], @pos[1]+1]]
    en_passant_victims.select! { |move| move_on_board?(move) }
    en_passant_victims.select! do |move|
      piece = board[move]
      piece.is_a?(Pawn) && piece.en_passant_susceptible
    end

    #Handle movement
    en_passant_victims.each do |victim|
      moves << new_position(victim, movement_vector)
    end

    # single step forward
    moves << new_position(@pos, movement_vector)

    # reject if move location is already occupied (can't kill forward)
    #Fix "piece_at_position" to []
    moves.select! { |move| move_on_board?(move) && board.piece_at_position(move).nil?}

    # diagonal kill
    diagonal_vectors.each do |diag_vec|
      move = new_position(@pos, diag_vec)
      next unless move_on_board?(move)
      victim_piece = board.piece_at_position(move)
      moves << move unless victim_piece.nil? || victim_piece.color == @color
    end

    moves
  end
end