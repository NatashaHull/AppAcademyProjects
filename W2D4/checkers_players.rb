class Player
	attr_reader :color

	def initialize(color)
		@color = color
		@last_move_pos = nil
	end

	def move(board)
		#Runs if the players don't have this method
		raise "Not defined"
	end

	def move_again(board)
		#Runs if the players don't have this method
		raise "Not defined"
	end
end

class ComputerPlayer < Player
	def move(board)
		#Finds all the pieces that belong to this player
		all_pieces = board.rows.flatten.compact

		my_pieces = all_pieces.select do |piece|
			piece.color == @color
		end

		#Gets all the possible (valid) moves
		moves = []

		my_pieces.each do |piece|
			piece.moves(board).each do |possible_move|
				move = [piece.pos, possible_move]
				p "I might be able to make this move #{move}"
				moves << move if board.valid_move?(move)
			end
		end

		p "My moves are #{moves}"

		select_move(moves)
	end

	def move_again(board)
		#Uses the last position it moved to to find
		#its current possible moves.
		possible_moves = board[@last_move_pos].moves(board)

		
		possible_moves.map! do |move|
			[@last_move_pos, move]
		end

		possible_moves.select! do |move|
			board.valid_move?(move)
		end

		select_move(possible_moves)
	end

	private
		def select_move(moves)
			#Selects an available move at random
			start_pos, end_pos = moves.sample

			#Assings the end position to the last_move_pos
			#variable so that the computer knows the last
			#position it moved to.
			@last_move_pos = end_pos

			[start_pos, end_pos]
		end
end


class HumanPlayer < Player
	def move(board)
		begin
			start_pos = get_start_position(board)
			end_pos = get_end_position(board)

			#Checks to make sure that the move is valid
			check_move(board, start_pos, end_pos)
		rescue ArgumentError => e
			puts e.message
			retry
		end
		
		#Creates a variable the end position of the
		#last move to simplify moving again
		@last_move_pos = end_pos

		[start_pos, end_pos]
	end

	def move_again(board)
		interp_last_move_pos = "abcdefgh"[@last_move_pos[0]]
		interp_last_move_pos += (@last_move_pos[0] - 1).to_s
		begin
			puts "You can move the piece now at #{interp_last_move_pos}"
			end_pos = get_end_position(board)

			#Makes sure the move is valid
			check_move(board, @last_move_pos, end_pos)
		rescue ArgumentError => e
			puts e.message
			retry
		end

		[@last_move_pos, end_pos]
	end

	private
		def get_start_position(board)
			begin
				puts "Which piece would you like to move?"
				start_pos = parse_input(board)

				#Makes sure the player is selecting their
				#own piece
				unless board[start_pos] && board[start_pos].color == @color
					raise ArgumentError, "This is not your piece"
				end
			rescue ArgumentError => e
				puts e.message
				retry
			end

			start_pos
		end

		def get_end_position(board)
			begin
				puts "Where would you like to move your piece?"
				end_pos = parse_input(board)
			rescue ArgumentError => e
				puts e.message
				retry
			end

			end_pos
		end

		def parse_input(board)
			pos = gets.chomp.split('')
			check_input(pos)
			pos[0] = "abcdefgh".index(pos[0])
	    pos[1] = pos[1].to_i - 1
	    #Because our players aren't necessarily programmers
	    pos
		end

		#Create special errors for these things.
		def check_input(pos)
			if !"abcdefgh".include?(pos[0])
	      raise ArgumentError, "Your first input must be a letter between a and h"
	    elsif !"12345678".include?(pos[1])
	      raise ArgumentError, "Your second input must be a number between 1 and 8"
	    elsif pos.length > 2
	    	raise ArgumentError, "Your input must only be a letter and a number"
	    end
		end

		def check_move(board, start_pos, end_pos)
			unless board.valid_move?([start_pos, end_pos])
				raise ArgumentError, "This is not a valid move!"
			end
		end
end