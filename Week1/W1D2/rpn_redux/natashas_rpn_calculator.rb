class RPNCalculator
	def initialize
		@nums = []
	end
	def push num
		@nums << num
	end
	def plus
		raise "calculator is empty" unless @nums.length > 0
		@sum = 0
		num1 = @nums.pop
		num2 = @nums.pop
		@sum += num1 + num2
		@nums << @sum
		@sum
	end
	def minus
		raise "calculator is empty" unless @nums.length > 0
		@sum = 0
		num1 = @nums.pop
		num2 = @nums.pop
		@sum += num2 - num1
		@nums << @sum
		@sum
	end
	def times
		raise "calculator is empty" unless @nums.length > 0
		@sum = 0
		num1 = @nums.pop
		num2 = @nums.pop
		@sum += num2 * num1
		@nums << @sum
		@sum
	end
	def divide
		raise "calculator is empty" unless @nums.length > 0
		@sum = 0
		num1 = @nums.pop
		num2 = @nums.pop
		@sum += num2.to_f / num1.to_f
		@nums << @sum
		@sum
	end
	def value
		@sum
	end
	def tokens vals_str
		vals = vals_str.split
		vals.map! do |val|
			case val
			when "+"
				:+
			when "-"
				:-
			when "*"
				:*
			when "/"
				:/
			else
				val.to_i
			end
		end
		vals
	end
	def evaluate vals_str
		values = tokens(vals_str)
		values.each do |value|
			if value.class == Fixnum
				@nums << value
			else
				case value
				when :+
					plus
				when :-
					minus
				when :*
					times
				when :/
					divide
				end
			end
		end
		value
	end
end