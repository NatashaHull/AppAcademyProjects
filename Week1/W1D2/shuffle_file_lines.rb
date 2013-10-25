puts "Enter a file to shuffle"
filename = gets.chomp
file_lines = File.readlines(filename).shuffle
filename.gsub!('.txt', '')
File.open("#{filename}-shuffled.txt", 'w') do |file|
  file_lines.each { |line| file.puts line }
end