# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cat.create!(:name => "Gizmo", :age => 2, :birth_date => "01/03/2011", :color => "brown", :gender => "F")
Cat.create!(:name => "Gadget", :age => 15, :birth_date => "01/03/2000", :color => "black", :gender => "M")
Cat.create!(:name => "Lala", :age => 5, :birth_date => "01/03/2008", :color => "brown", :gender => "F")
Cat.create!(:name => "Dumbledore", :age => 100, :birth_date => "01/03/1913", :color => "grey", :gender => "M")

CatRental.create!(:start_date => "05/08/2013", :end_date => "05/10/2013", :cat_id => 1)
CatRental.create!(:start_date => "05/08/2013", :end_date => "05/10/2013", :cat_id => 2)
CatRental.create!(:start_date => "06/10/2013", :end_date => "07/10/2013", :cat_id => 1)
CatRental.create!(:start_date => "06/10/2013", :end_date => "07/10/2013", :cat_id => 2)
CatRental.create!(:start_date => "04/08/2012", :end_date => "10/10/2012", :cat_id => 1)
CatRental.create!(:start_date => "04/08/2012", :end_date => "10/10/2012", :cat_id => 2)
CatRental.create!(:start_date => "05/08/2013", :end_date => "05/10/2013", :cat_id => 1)
CatRental.create!(:start_date => "05/08/2013", :end_date => "05/10/2013", :cat_id => 2)
CatRental.create!(:start_date => "06/10/2013", :end_date => "07/10/2013", :cat_id => 1)