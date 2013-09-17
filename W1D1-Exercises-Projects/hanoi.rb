class Hanoi
  def initialize
    @towers = [[1,2,3], [], []]
  end

  def print_out
    puts "The first tower contains #{@towers[0].join(", ")}"
    puts "The second tower contains #{@towers[1].join(", ")}"
    puts "The third tower contains #{@towers[2].join(", ")}"
  end

  def move(from, to)
    @towers[to].unshift(@towers[from].shift)
  end

  def valid_move?(from, to)
    if @towers[from].length > 0
      return true if @towers[to].length == 0
      return true if @towers[from].first < @towers[to].first
    end
    return false
  end

  def play
    until @towers[2] == [1,2,3]
      print_out
      puts "Which block to move? (1, 2, or 3)"
      from = gets.chomp.to_i
      puts "Where would you like to move it? (1, 2, or 3)"
      to = gets.chomp.to_i
      if valid_move?(from - 1, to - 1)
        move(from - 1, to - 1)
      end
    end
    puts "You win!"
  end
end

game = Hanoi.new
game.play