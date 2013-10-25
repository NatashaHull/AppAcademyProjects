class RPNCalculator
	attr_accessor :stack, :value

	def initialize
		@stack = [0]
	end

	def push(n)
		@stack << n.to_f
	end

	def value
		stack[stack.length-1]
	end

	def plus
		raise "calculator is empty" if stack.length <= 1
		@stack << @stack.pop(2).reduce(:+)
	end

	def minus
		raise "calculator is empty" if stack.length <= 1
		@stack << @stack.pop(2).reduce(:-)
	end

	def times
		raise "calculator is empty" if stack.length <= 1
		@stack << @stack.pop(2).reduce(:*)
	end

	def divide
		raise "calculator is empty" if stack.length <= 1
		@stack << @stack.pop(2).reduce(:/)
	end

	def tokens(s)
		operators = ['*', '/', '+', '-']
		tokens = s.scan(/[\d*\/+-]/).map do |t|
			if operators.include? t
				t.to_sym
			else
				t.to_f
			end
		end
	end

	def evaluate(s)
		tokens(s).each do |t|
			if t.is_a? Float
				push(t)
			else
				case t
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