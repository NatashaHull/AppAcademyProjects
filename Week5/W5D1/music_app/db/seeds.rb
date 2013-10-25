# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#I do not activate any of these users, so they must be activated
#manually or code must be added below to activate them
u1 = User.new(:email => "natasha@example.com", :password => "password")
u1.set_activation_token
u1.save!
u2 = User.new(:email => "alex@example.com", :password => "password")
u2.set_activation_token
u2.save!
u3 = User.new(:email => "lala@example.com", :password => "password")
u3.set_activation_token
u3.save!

u1.make_admin!

band1 = Band.create!(:name => "Fleetwood Mac")
band2 = Band.create!(:name => "America")
band3 = Band.create!(:name => "The Beatles")

album1 = Album.create!(:name => "Fleetwood Mac", :band_id => 1)
album2 = Album.create!(:name => "America's Greatest Hits", :band_id => 2)
album3 = Album.create!(:name => "Rubber Soul", :band_id => 3)
album4 = Album.create!(:name => "Abbey Road", :band_id => 3)
album5 = Album.create!(:name => "Srgt Pepper", :band_id => 3)

track1 = Track.create!(:name => "Don't Stop", :album_id => 1)
track2 = Track.create!(:name => "The Chain", :album_id => 1)
track3 = Track.create!(:name => "Songbird", :album_id => 1)
track4 = Track.create!(:name => "You Make Loving Fun", :album_id => 1)

track5 = Track.create!(:name => "A Horse with No Name", :album_id => 2)
track6 = Track.create!(:name => "I Need You", :album_id => 2)
track7 = Track.create!(:name => "Ventura Highway", :album_id => 2)
track8 = Track.create!(:name => "Don't Cross the River", :album_id => 2)

track9 = Track.create!(:name => "Norwegian Wood", :album_id => 3)
track10 = Track.create!(:name => "Michelle", :album_id => 3)
track11 = Track.create!(:name => "Octopuses Garden", :album_id => 4)
track12 = Track.create!(:name => "For the Benefit of Mr. Kite", :album_id => 5)