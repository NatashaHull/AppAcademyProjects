# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(email: "b@b.com")
User.create!(email: "c@c.com")
User.create!(email: "d@d.com")
User.create!(email: "e@e.com")
User.create!(email: "f@f.com")

ShortenedUrl.create_for_user_and_long_url!(User.all[0], "long_urlb")
ShortenedUrl.create_for_user_and_long_url!(User.all[0], "long_urlb2")
ShortenedUrl.create_for_user_and_long_url!(User.all[1], "long_urlc")
ShortenedUrl.create_for_user_and_long_url!(User.all[2], "long_urld")

Visit.record_visit!(User.all[0], ShortenedUrl.all[0])
Visit.record_visit!(User.all[0], ShortenedUrl.all[1])
Visit.record_visit!(User.all[1], ShortenedUrl.all[0])
Visit.record_visit!(User.all[2], ShortenedUrl.all[0])

Tag.create!({topic: "Science"})
Tag.create!({topic: "Sports"})

Tagging.create!({tag_id: 1, url_id: 1})
Tagging.create!({tag_id: 2, url_id: 1})