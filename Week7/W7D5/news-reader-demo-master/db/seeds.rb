# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#

urls = [
  'http://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml',
  'http://feeds.wired.com/wired/index',
  'http://www.npr.org/rss/rss.php?id=1001'
]

urls.each do |url|
  Feed.find_or_create_by_url url
end
