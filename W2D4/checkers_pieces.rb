# coding: utf-8
class Piece
	attr_accessor :color, :pos, :king, :just_jumped

	def initialize(color, pos)
		@color, @pos = color, pos
		@king = false
		@just_jumped = false
	end

	def mark
		@king ? "⛃".colorize(@color) : "⛂".colorize(@color)
	end

	def move_dirs
		#Only allows the pawns to move forward diagonally
		potential_dirs = [[1,-1], [1,1]]

		#Allows the kings to move backward diagonally
		potential_dirs += [[-1,-1], [1,-1]] if @king

		potential_dirs
	end

	def moves(board)
		#Need to make sure you don't kill your own piece
		#Need to handle multiple moves.


		#Scale the moves to the location of the piece on
		#the board
		scalar = @color == :red ? -1 : 1
		move_dirs = self.move_dirs

		potential_moves = move_dirs.map do |row, col|
			[scalar * row, scalar * col]
		end

		#Add moves that jump over another piece and kill it
		diagonal_kills = potential_moves.map do |row, col|
			[2 * row, 2 * col]
		end

		#Apply the vectors to both sets of moves
		potential_moves.map! { |move| apply_vector(@pos, move) }
		diagonal_kills.map! { |move| apply_vector(@pos, move) }

		#Gets rid of potential moves that step on a piece
		#Adds moves which kill opponent pieces instead
		moves = []
		potential_moves.each_with_index do |move, i|
			current_diag = diagonal_kills[i]
			if move_on_board(move) && board[move].nil?
				#The move is valid if the square is empty.
				moves << move
			elsif move_on_board(current_diag) &&
						board[move].color != @color &&
						board[current_diag].nil?
				#You can jump over an opponent pice to
				#and empty square
				moves << diagonal_kills[i]
			end
		end

		#Gets rid of moves that are not on the board
		moves.select! { |move| move_on_board(move) }

		#Forces the piece to only make killing moves
		#if they are available
		killing_moves = moves.select do |move|
			diagonal_kills.include?(move)
		end

		return killing_moves unless killing_moves.empty?
		moves
	end

	private
		def move_on_board(move)
			return false unless (0..7).include?(move[0])
			return false unless (0..7).include?(move[1])
			true
		end

		def apply_vector(square, vector)
			[square[0]+vector[0], square[1]+vector[1]]
		end
end