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
end