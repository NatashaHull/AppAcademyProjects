require './checkers_player_errors.rb'

class Player
	def initialize(color)
		@color = color
		@last_move_pos = nil
	end

	def move(board)
		begin
			start_pos = get_start_position
			end_pos = get_end_position

			#Checks to make sure that the move is valid
			check_move(start_pos, end_pos)
		rescue Error => e
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
			end_pos = get_end_position

			#Makes sure the move is valid
			check_move(@last_move_pos, end_pos)
		rescue Error => e
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
				unless board[start_pos].color == @color
					raise "This is not your piece"
				end
			rescue StandardError => e
				puts e.message
				retry
			end

			start_pos
		end

		def get_end_position(board)
			begin
				puts "Where would you like to move your piece?"
				end_pos = parse_input(board)
			rescue StandardError => e
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
	      raise "Your first input must be a letter between a and h"
	    elsif !"12345678".include?(pos[1])
	      raise "Your second input must be a number between 1 and 8"
	    elsif pos.length > 2
	    	raise "Your input must only be a letter and a number"
	    end
		end

		def check_move(start_pos, end_pos)
			unless board.valid_move?[start_pos, end_pos]
				raise "This is not a valid move!"
			end
		end
end