class User < ActiveRecord::Base
  include ActiveModel::Validations

  attr_accessible :name, :email

  validates :email, :uniqueness => true
  validates_with AtLeastOneOfValidator

  has_many(
    :contacts,
    :class_name => "Contact",
    :primary_key => :id,
    :foreign_key => :contact_id
  )

  has_many :contact_shares

  has_many :shared_contacts, :through => :contact_shares, :source => :contact
end
