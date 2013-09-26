require 'colorize'
require './checkers_board.rb'
require './checkers_pieces.rb'
require './checkers_players.rb'

class Checkers
	def initialize
		@board = Board.new
		@player1 = Player.new(:red)
		@player1 = Player.new(:white)
		@current_player = @player1
	end

	def play
		until @board.over?(@current_player.color)
			@board.display
			show_player
			move = @current_player.move(@board)
			@board.move(move)
			calculate_next_move
			switch_players
		end

		switch_players
		@board.display
		puts "#{@current_player.color.capitalize} won!"
	end

	private
		def switch_players
			if @current_player == @player1
				@current_player = @player2
			else
				@current_player = @player1
			end
		end

		def show_player
			show_value = "It's #{@current_player.color}'s turn."
			puts show_value.colorize( :background => @current_player.color )
		end

		def calculate_new_move
			@current_player.move_again(board)
			calculate_new_move if @board.can_move_again?
		end
end