class Tag < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true, :uniqueness => true
  has_many :secret_taggings
  has_many :secrets, :through => :secret_taggings, :source => :secret
end
