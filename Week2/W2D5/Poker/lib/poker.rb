require 'poker_deck_cards.rb'
require 'poker_hand.rb'
require 'poker_player.rb'

class Poker
  def initialize
    @players = []
    @deck = nil
    @pot = 0
  end

  def play
    create_players
    create_new_game
    bet
    discard
    bet
    show_hands
    calculate_and_display_winner
  end

  private

    def create_new_game
      @deck = Deck.new
      @players.each do |player|
        player.hand.get_hand(@deck)
      end
    end

    def create_players
      get_player_num.times do
        @players << Player.new(get_player_name)
      end
    end

    def get_player_num
      begin
        puts "How many players would you like?"
        players = gets.chomp.to_i
        if players < 2
          raise InvalidSelectionError, "You must have at least two players!"
        end
      rescue InvalidSelectionError => e
        puts e.message
        retry
      end
      players
    end

    def get_player_name
     puts "Who is this player?"
     gets.chomp
    end

    def bet
      folders = []
      bet_minimum = 0
      @players.each do |player|
        puts "It's #{player.name}'s turn!"
        puts "The current minimum bet is #{bet_minimum}"
        current_bet = player.bet
        if current_bet >= bet_minimum
          @pot += current_bet
          bet_minimum = current_bet
        else
          folders << player
        end
      end

      @players.reject! { |player| folders.include?(player) }
    end

    def discard
      @players.each do |player|
        puts "It's #{player.name}'s turn!"
        player.discard
        player.hand.get_hand(@deck)
      end
    end

    def show_hands
      @players.each do |player|
        puts "#{player.name} has the cards:"
        player.hand.display
      end
    end

    def calculate_and_display_winner
      highest_hand = 0
      winner = nil
      @players.each do |player|
        current_hand = player.hand.hand_value
        if current_hand > highest_hand
          highest_hand = current_hand
          winner = player
        end
      end
      winner.pot += @pot
      puts "#{winner.name.capitalize} won!"
    end
end

class InvalidSelectionError < RuntimeError
end

# game = Poker.new
# game.play