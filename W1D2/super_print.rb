def super_print(str, options={})
  super_print_str = str
  default_options = {
    :times => 1,
    :upcase => false,
    :reverse => false
  }
  default_options.merge!(options)
  super_print_str *= default_options[:times] if default_options[:times] > 1
  super_print_str.upcase! if default_options[:upcase]
  super_print_str.reverse! if default_options[:reverse]
  super_print_str
  end

  puts super_print("Hello")                                    #=> "Hello"
  puts super_print("Hello", :times => 3)                       #=> "Hello" 3x
  puts super_print("Hello", :upcase => true)                   #=> "HELLO"
  puts super_print("Hello", :upcase => true, :reverse => true) #=> "OLLEH"