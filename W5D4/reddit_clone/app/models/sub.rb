class Sub < ActiveRecord::Base
  attr_accessible :name

  validates :name, :moderator_id, :presence => true

  belongs_to :moderator, :class_name => 'User'
  has_many :link_subs
  has_many :links, :through => :link_subs, :source => :link
end
