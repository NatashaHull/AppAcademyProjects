class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class HumanPlayer < Player
  def select_move(board)
    begin
      puts "Which piece would you like to move? (ex: a3)"
      start_pos = parse_input(board)
      if board.piece_at_position(start_pos).nil? || @color != board.piece_at_position(start_pos).color
        raise ArgumentError, "This is not your piece"
      end
    rescue ArgumentError => e
      puts e.message
      retry
    end

    start_piece = board.piece_at_position(start_pos)

    begin
      puts "Where would you like to move this piece? (ex: a3)"
      end_pos = parse_input(board)
    rescue ArgumentError => e
      puts e.message
      retry
    end

    return [start_pos, end_pos] if board.valid_move?([start_pos, end_pos], start_piece)

    puts "That was not a valid move!"
    select_move(board)
  end

  def parse_input(board)
    piece_pos = gets.chomp.split("")
    check_input(board, piece_pos)
    piece_pos[0] = "abcdefgh".index(piece_pos[0])
    piece_pos[1] = piece_pos[1].to_i - 1 #Because our players aren't necessarily programmers
    piece_pos
  end

  def check_input(board, piece_pos)
    if !"abcdefgh".include?(piece_pos[0])
      raise ArgumentError, "Your first input must be a letter between a and h"
    elsif !"12345678".include?(piece_pos[1])
      raise ArgumentError, "Your second input must be a number between 1 and 8"
    end
  end
end

class ComputerPlayer < Player
  def select_move(board)
    my_pieces = board.player_pieces(@color)

    possible_moves = []
    my_pieces.each do |piece|
      piece.moves(board).each do |move|
        possible_moves << [piece.pos, move] if board.valid_move?([piece.pos, move], piece)
      end
    end
    possible_moves.sample
  end
end