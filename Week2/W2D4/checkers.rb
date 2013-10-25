# coding: utf-8
require 'colorize'
require './checkers_board.rb'
require './checkers_pieces.rb'
require './checkers_players.rb'

class Checkers
	def initialize
		@board = Board.new
		@player1 = HumanPlayer.new(:red)
		@player2 = HumanPlayer.new(:white)
	end

	def play
		select_players

		until @board.over?(@current_player.color)
			sleep 1
			@board.display
			show_player
			move = @current_player.move(@board)
			@board.move(move)
			calculate_next_move if @board.can_move_again?
			switch_players
		end

		switch_players
		@board.display
		puts "#{@current_player.color.capitalize} won!"
	end

	private
		def select_players
			puts "How many Human players? (0-2)"
			humans = gets.chomp.to_i
			if humans == 0
				@player1 = ComputerPlayer.new(:red)
				@player2 = ComputerPlayer.new(:white)
			elsif humans == 1
				@player2 = ComputerPlayer.new(:white)
			end

			@current_player = @player1
		end

		def switch_players
			if @current_player == @player1
				@current_player = @player2
			else
				@current_player = @player1
			end
		end

		def show_player
			show_value = "It's #{@current_player.color}'s turn."
			puts show_value.colorize( @current_player.color )
		end

		def calculate_next_move
			move = @current_player.move_again(@board)
			@board.move(move)
			calculate_next_move if @board.can_move_again?
		end
end

game = Checkers.new
game.play