class MassObject  
  def self.my_attr_accessible(*attributes)
		@attributes = [] if @attributes.nil?
    
    attributes.each do |attribute|
      attr_accessor attribute.to_sym
  		unless @attributes.include?(attribute)
        @attributes << attribute
      end
    end
  end

  def self.attributes
  	@attributes
  end

  def self.parse_all(results)
  end

  def initialize(params = {})
  	attrs = self.class.attributes
  	params.each do |attr_name, value|
      if attrs.include?(attr_name.to_sym)
  			send("#{attr_name}=", value)
      else
  			raise RuntimeError, "mass assignment to unregistered attribute #{attr_name}"
      end
  	end
  end
end