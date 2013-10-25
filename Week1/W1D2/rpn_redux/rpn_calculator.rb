class RPNCalculator
  def initialize
    @stack = []
  end

  def push(num)
    @stack << num
  end

  def plus
    raise "calculator is empty" if @stack.length <= 1
    @stack << @stack.pop(2).inject(:+)
  end

  def minus
    raise "calculator is empty" if @stack.length <= 1
    @stack << @stack.pop(2).inject(:-)
  end

  def times
    raise "calculator is empty" if @stack.length <= 1
    @stack << @stack.pop(2).map(&:to_f).inject(:*)
  end

  def divide
    raise "calculator is empty" if @stack.length <= 1
    @stack << @stack.pop(2).map(&:to_f).inject(:/)
  end

  def value
    @stack[-1]
  end

  def tokens(str)
    token_array = str.split(' ')
    token_array.collect do |token|
      case token
      when '+', '-', '*', '/'
        token.to_sym
      else
        token.to_i
      end
    end
  end

  def evaluate(str)
    tokens_array = tokens(str)
    tokens_array.each do |token|
      if token.is_a?(Fixnum)
        push(token)
      else
        case token
        when :+ then plus
        when :- then minus
        when :* then times
        when :/ then divide
        end
      end
    end

    value
  end

  def file_given?
    ARGF.argv ? true : false
  end

  def run_file
    filename = ARGF.argv ? ARGF.argv[0] : nil
    if filename
      expression = File.readlines(filename).map(&:chomp).join
      puts evaluate(expression)
    end
  end

  def run
    if file_given?
      run_file
    else
      puts "Calculator started!"
      input = ''
      until input == "exit"
        input = gets.chomp
        break if input == 'exit'
        puts evaluate(input)
      end
    end
  end
end

use_calculator = RPNCalculator.new

if __FILE__ == $PROGRAM_NAME
  use_calculator.run
end