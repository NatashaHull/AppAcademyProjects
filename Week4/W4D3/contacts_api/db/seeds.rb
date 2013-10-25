# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(:name => "Lala", :email => "lala@example.com")
User.create!(:name => "Bob", :email => "bob@example.com")
User.create!(:name => "Val", :email => "val@example.com")
User.create!(:name => "Deb", :email => "deb@example.com")

Contact.create!(:name => "Important", :email => "important@example.com", :user_id => 1)
Contact.create!(:name => "Special", :email => "special@example.com", :user_id => 2)
Contact.create!(:name => "Highfalauten", :email => "highfalauten@example.com", :user_id => 2)

ContactShare.create!(:user_id => 1, :contact_id => 2)
ContactShare.create!(:user_id => 3, :contact_id => 1)


