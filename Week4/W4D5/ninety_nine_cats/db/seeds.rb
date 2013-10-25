# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.new(:username => "Josh", :password => "josh")
u1.reset_session_token!
u1.save!

u2 = User.new(:username => "Natasha", :password => "joshiscool")
u2.reset_session_token!
u2.save!

a = Cat.new(:name => "Gizmo", :age => 2, :birth_date => "01/03/2011",
            :color => "brown", :gender => "F")
a.owner_id = 1
a.save!

b = Cat.new(:name => "Gadget", :age => 15, :birth_date => "01/03/2000",
            :color => "black", :gender => "M")
b.owner_id = 2
b.save!

c = Cat.new(:name => "Lala", :age => 5, :birth_date => "01/03/2008",
            :color => "brown", :gender => "F")
c.owner_id = 1
c.save!

d = Cat.new(:name => "Dumbledore", :age => 100, :birth_date => "01/03/1913",
            :color => "grey", :gender => "M")
d.owner_id = 2
d.save!

CatRental.create!(:start_date => "05/08/2013", :end_date => "05/10/2013", :cat_id => 1)
CatRental.create!(:start_date => "05/08/2013", :end_date => "05/10/2013", :cat_id => 2)
CatRental.create!(:start_date => "06/10/2013", :end_date => "07/10/2013", :cat_id => 1)
CatRental.create!(:start_date => "06/10/2013", :end_date => "07/10/2013", :cat_id => 2)
CatRental.create!(:start_date => "04/08/2012", :end_date => "10/10/2012", :cat_id => 1)
CatRental.create!(:start_date => "04/08/2012", :end_date => "10/10/2012", :cat_id => 2)
CatRental.create!(:start_date => "05/08/2013", :end_date => "05/10/2013", :cat_id => 1)
CatRental.create!(:start_date => "05/08/2013", :end_date => "05/10/2013", :cat_id => 2)
CatRental.create!(:start_date => "06/10/2013", :end_date => "07/10/2013", :cat_id => 1)