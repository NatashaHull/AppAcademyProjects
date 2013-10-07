class Object
	def new_attr_accessor(*args)
		args.each do |method|
			define_method(method.to_s) do
				instance_variable_get("@#{method}")
			end

			define_method("#{method}=") do |arg|
				instance_variable_set("@#{method}", arg)
			end
		end
	end
end

class Cat
  new_attr_accessor :name, :color
end

cat = Cat.new
cat.name = "Sally"
cat.color = "brown"

p cat.name # => "Sally"
p cat.color # => "brown"