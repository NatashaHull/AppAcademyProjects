class APIMethods
  def initialize(class_name)
    @class_name = class_name #Input will be a plural of the class name
  end

  def show_all
    url = create_url(@class_name)
    RestClient.get(url)
  end

  def show(id)
    url = create_url("#{@class_name}/#{id}")
    RestClient.get(url)
  end

  def create(params)
    url = create_url(@class_name)
    RestClient.post(url, params)
  end

  def update(id, params)
    url = create_url("#{@class_name}/#{id}")
    RestClient.put(url, params)
  end

  def delete(id)
    url = create_url("#{@class_name}/#{id}")
    RestClient.delete(url)
  end

  def create_url(path)
    url = Addressable::URI.new(
      scheme: 'http',
      host: 'localhost',
      port: 3000,
      path: path
    ).to_s
  end
end

class ContactAPI < APIMethods
  def show_all_contacts_for_user(id)
    url = create_url("users/#{id}/#{@class_name}")
    RestClient.get(url)
  end
end

users = APIMethods.new('users')
contacts = ContactAPI.new('contacts')
contact_shares = APIMethods.new('contact_shares')

puts users.show_all
puts users.show(1)
puts users.create(:user => {:name => "hello", :email => "hello@example.com"})
puts users.update(2, :user => {:name => "Bob2"})
puts users.delete(4)
puts users.show_all

puts contacts.show_all_contacts_for_user(3)
puts contacts.show_all_contacts_for_user(2)
puts contacts.show(1)
puts contacts.create(:contact => {:name => "goodbye", :email => "goodbye@example.com", :user_id => 3})
puts contacts.update(2, :contact => {:name => "Special2"})
puts contacts.delete(3)
puts contacts.show_all_contacts_for_user(3)
puts contacts.show_all_contacts_for_user(2)

puts contacts.show_all_contacts_for_user(3)
puts contact_shares.create(:contact_share => {:user_id => 3, :contact_id => 2})
puts contacts.show_all_contacts_for_user(3)
puts contact_shares.delete(3)
puts contacts.show_all_contacts_for_user(3)