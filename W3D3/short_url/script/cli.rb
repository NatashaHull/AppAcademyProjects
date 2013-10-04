puts "Enter user name:"
user = gets.chomp

if User.find_by_email(user)
  user = User.find_by_email(user)
else
  puts "Email not found!"
  return
end

puts "What do you want to do?"
puts "0. Create shortened URL"
puts "1. Visit shortened URL"

decision = gets.chomp
p decision

case decision
when "0"
  puts "Type in your long url"
  long_url = gets.chomp
  url_object = ShortenedUrl.create_for_user_and_long_url!(user, long_url)
  puts "Type in a tag from the following #{Tag::TAGS}"
  tag_str = gets.chomp
  tag_object = Tag.create_or_return_existing_tag(tag_str)
  Tagging.create_for_tag_and_url(tag_object.id, url_object.id)
  puts "#{url_object.short_url}"
  puts "#{tag_object.topic}"
when "1"
  puts "Type in the shorten url"
  short_url = gets.chomp
  user.visit(short_url)
end