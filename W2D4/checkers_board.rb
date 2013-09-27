require 'colorize'
require './checkers_pieces.rb'

class Board
	attr_reader :rows

	def initialize
		@rows = Array.new(8) { Array.new(8) }
		init_board
	end

	def over?(color)
		@rows.flatten.compact.none? do |piece|
			piece.color == color
		end
	end

	def move(player_move)
		origin_coord, destination_coord = player_move

		#Moves the piece on the board
		piece = self[origin_coord]
		self[destination_coord] = piece
		self[origin_coord] = nil
		piece.pos = destination_coord

		#Make just_jumped is false for all pieces
		reset_just_jumped_value

		#Handles killing moves
		if is_killing_move?(player_move)
			#Delete square moved over
			kill_pos = kill(player_move)
			self[kill_pos] = nil
			piece.just_jumped = true
		end

		#Handles promotion to king
		if destination_coord[0] == 0 ||
				destination_coord[0] == 7 &&
				!piece.king
			piece.king = true

			#You cannot move again right after
			#king promotion
			piece.just_jumped = false
		end
	end

	def valid_move?(player_move)
		#Makes sure there is a piece to move
		current_piece = self[player_move[0]]
		return false unless current_piece
		
		#Makes sure that that is a valid move for
		#the selected piece
		moves = current_piece.moves(self)
		return false unless moves.include?(player_move[1])

		#If the current move is a killing move it is valid
		return true if is_killing_move?(player_move)
		
		#If it isn't a killing move, but killing moves exist,
		#for me, then it is not a valid move
		pieces = @rows.flatten.compact
		player_pieces = pieces.select do |piece|
			piece.color == current_piece.color
		end

		player_pieces.each do |piece|
			piece.moves(self).each do |move|
				return false if is_killing_move?([piece.pos, move])
			end
		end

		true
	end

	def can_move_again?
		#Finds the most recently moved piece, and
		#returns whether it can make another killing move.
		all_pieces = @rows.flatten.compact
		just_jumped_pieces = all_pieces.select(&:just_jumped)
		return false if just_jumped_pieces.empty?
		piece = just_jumped_pieces[0]
		possible_next_moves = piece.moves(self)
		possible_next_moves.each do |move|
			if is_killing_move?([piece.pos, move])
				return true
			end
		end
		false
	end

	def display
		system("clear")
		row_selector = "abcdefgh"
		row_separator = "-" * 35
		puts ("1".."8").to_a.join(' | ').rjust(33)
		puts row_separator
		@rows.each_with_index do |row, i|
			row_display = [row_selector[i]]
			row.each_with_index do |piece, j|
				if piece.nil?
					row_display << " "
				else
					row_display << piece.mark
				end
			end
			puts row_display.join(" | ")
			puts row_separator
		end
	end

	def [](pos)
		@rows[pos[0]][pos[1]]
	end

	def []=(pos, piece)
		@rows[pos[0]][pos[1]] = piece
	end

	private

		def init_board
			#Initialize black pieces
			left_rows(:white, 0)
			right_rows(:white, 1)
			left_rows(:white, 2)

			#Initialize red pieces
			right_rows(:red, 5)
			left_rows(:red, 6)
			right_rows(:red, 7)
		end

		def left_rows(color, i)
			@rows[i] = [Piece.new(color, [i, 0]), nil,
									Piece.new(color, [i, 2]), nil,
									Piece.new(color, [i, 4]), nil,
									Piece.new(color, [i, 6]), nil]
		end

		def right_rows(color, i)
			@rows[i] = [nil, Piece.new(color, [i, 1]),
									nil, Piece.new(color, [i, 3]),
									nil, Piece.new(color, [i, 5]),
									nil, Piece.new(color, [i, 7])]
		end

		def is_killing_move?(player_move)
			origin_coord, destination_coord = player_move
			distance = (origin_coord[0] - destination_coord[0]).abs

			#If the distance is two, it moved over another piece
			distance == 2
		end

		def kill(player_move)
			#Takes in the move and returns the position of the
			#killed piece
			origin_coord, destination_coord = player_move
			row_vector = (origin_coord[0] - destination_coord[0])/2
			col_vector = (origin_coord[1] - destination_coord[1])/2

			[origin_coord[0]-row_vector, origin_coord[1]-col_vector]
		end

		def reset_just_jumped_value
			#Sets all the pieces to say they did not move last
			@rows.flatten.compact.each do |piece|
				piece.just_jumped = false
			end
		end
end