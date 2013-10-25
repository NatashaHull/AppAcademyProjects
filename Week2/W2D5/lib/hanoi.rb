class Hanoi
  attr_reader :towers

  def initialize
    @towers = [[1,2,3], [], []]
  end

  def won?
    @towers[2] == [1,2,3]
  end

  def move(tower1, tower2)
    block1 = @towers[tower1].first
    block2 = @towers[tower2].first
    if !block1 || (block2 && block1 > block2)
      raise InvalidMoveError, "This move is invalid!"
    else
      @towers[tower1].shift
      @towers[tower2].unshift(block1)
    end
  end

  def play
    until won?
      display
      begin
        tower1, tower2 = prompt_move
        move(tower1, tower2)
      rescue InvalidMoveError => e
        puts e.message
        retry
      end
    end

    puts "Congratulations, you won!"
  end

  def display
    puts "The first tower has blocks #{@towers[0]}"
    puts "The second tower has blocks #{@towers[1]}"
    puts "The third tower has blocks #{@towers[2]}"
  end

  def prompt_move
    begin
      puts "Which tower would you like to take a piece from?"
      tower1 = gets.chomp.to_i
      if tower1 > 3 || tower1 < 1
        raise InvalidMoveError, "This is not a valid input!"
      end
    rescue InvalidMoveError => e
      puts e.message
      retry
    end

    begin
      puts "Which tower would put it on?"
      tower2 = gets.chomp.to_i
      if tower2 > 3 || tower2 < 1
        raise InvalidMoveError, "This is not a valid input!"
      end
    rescue InvalidMoveError => e
      puts e.message
      retry
    end

    [tower1-1, tower2-1]
  end
end

class InvalidMoveError < RuntimeError
end
#
# game = Hanoi.new
# game.play