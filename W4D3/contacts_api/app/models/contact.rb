class Contact < ActiveRecord::Base
  include ActiveModel::Validations

  attr_accessible :name, :email, :user_id

  validates :user_id, :presence => true
  validates_with AtLeastOneOfValidator

  belongs_to :user
  has_many :contact_shares

  has_many :shared_users, :through => :contact_shares, :source => :user

  def self.contacts_for_user_id(my_user_id)
    Contact.find_by_sql([<<-SQL, my_user_id, my_user_id])
      SELECT DISTINCT contacts.*
      FROM contacts
        LEFT JOIN contact_shares
          ON contact_shares.contact_id = contacts.id
      WHERE contacts.user_id = ?
         OR contact_shares.user_id = ?
    SQL
  end
end
