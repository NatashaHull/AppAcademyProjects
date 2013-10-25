# coding: utf-8
require 'colorize'
load './chess_players.rb'
load './chess_board.rb'
load './chess_pieces.rb'


class Chess
  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new(:black)
    @player2 = HumanPlayer.new(:red)
  end

  def play
    game_setup

    until @board.over?(@current_player.color)
      sleep 1
      @board.display
      show_turn = "It is #{@current_player.color}'s turn."
      puts show_turn.colorize( {:color => @current_player.color, :background => :white, :mode => :swap} )
      move = @current_player.select_move(@board)
      @board.move(move)
      switch_players
    end
    @board.display
    if @board.checkmate?(@current_player.color)
      switch_players
      puts "#{@current_player.color} won!"
    elsif @board.stalemate?(@current_player.color)
      puts "It was a stalemate!"
    else
      puts "It was a tie!" #For when it's just kings left.
    end
  end

  private

    def game_setup
      human_players = select_players
      case human_players
      when 1
        @player2 = ComputerPlayer.new(:red)
      when 0
        @player1 = ComputerPlayer.new(:black)
        @player2 = ComputerPlayer.new(:red)
      end
      @current_player = @player1
    end

    def select_players
      begin
        puts "How many human players? (0-2)"
        humans = gets.chomp
        raise ArgumentError, "This is not a valid number of players" unless "012".include?(humans)
      rescue ArgumentError => e
        puts e.message
        retry
      end
      humans.to_i
    end

    def switch_players
      if @current_player == @player1
        @current_player = @player2
      else
        @current_player = @player1
      end
    end
end


game = Chess.new
game.play