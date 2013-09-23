require 'player'

class HumanPlayer < Player
  def request_bet(dealer)
    print_status
    puts "Place bet"
    place_bet(dealer, Integer(gets))
  end

  def play_hand(deck)
    until hand.busted?
      print_status
      puts "    Hit or stay?"
      case gets.chomp.downcase
      when "hit"
        hand.hit(deck)
      when "stay"
        break
      end
    end

    puts "    Hand: #{hand}"
  end

  private
  def print_status
    puts "Name:"
    puts "    Bankroll: #{bankroll}"
    puts "    Hand: #{hand}"
  end
end
