# class InvalidMoveError < RuntimeError
# 	def check_input(pos)
# 		if !"abcdefgh".include?(pos[0])
#       raise "Your first input must be a letter between a and h"
#     elsif !"12345678".include?(pos[1])
#       raise "Your second input must be a number between 1 and 8"
#     elsif pos.length > 2
#     	raise "Your input must only be a letter and a number"
#     end
# 	end

# 	def check_move(start_pos, end_pos)
# 		unless board.valid_move?[start_pos, end_pos]
# 			raise "This is not a valid move!"
# 		end
# 	end
# end